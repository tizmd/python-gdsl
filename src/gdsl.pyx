# cython: c_string_type=str, c_string_encoding=ascii
from gdsl_callbacks cimport *
from libc.stdlib cimport malloc, free
from libc.string cimport memcpy
from libc.setjmp cimport setjmp
from cpython cimport Py_DECREF
from gdrr_builder cimport *

cdef inline object obj_t2object(obj_t p):
    if p is NULL:
        return None
    o = <object> p
    Py_DECREF(o)
    return o
   
cdef extern from "gdsl-cython.h":
    cdef struct frontend_desc:
        const char *name
        const char *ext
       
    cdef struct _generic:
        state_t (*init)()
        void (*set_code)(state_t state, unsigned char *buffer, uint64_t size, uint64_t base);
        char (*seek)(state_t state, int_t ip);
        jmp_buf *(*err_tgt)(state_t s);
        string_t (*merge_rope)(state_t s, obj_t rope);
        char* (*get_error_message)(state_t s);
        uint64_t (*get_ip)(state_t s);
        void (*reset_heap)(state_t state);
        void (*destroy)(state_t state);

    cdef struct _decoder:
        int_t (*config_default)(state_t state);
        obj_t (*decoder_config)(state_t state);
        int_t (*has_conf)(state_t state, obj_t config);
        obj_t (*conf_next)(state_t state, obj_t config);
        string_t (*conf_short)(state_t state, obj_t config);
        string_t (*conf_long)(state_t state, obj_t config);
        int_t (*conf_data)(state_t state, obj_t config);
        obj_t (*decode)(state_t state, int_t config);
        obj_t (*generalize)(state_t state, obj_t insn);
        obj_t (*asm_convert_insn)(state_t s, asm_callbacks_t cbs, asm_insn_t insn);
        obj_t (*pretty)(state_t state, obj_t insn);

    cdef struct _translator: 
        obj_t (*translate)(state_t state, obj_t insn)
        obj_t (*pretty)(state_t state, obj_t rreil)
        obj_t (*pretty_arch_id)(state_t state, obj_t id)
        obj_t (*pretty_arch_exception)(state_t state, obj_t id)
        obj_t (*rreil_convert_sem_stmt_list)(state_t s, callbacks_t cbs, obj_t stmts)
        obj_t (*optimization_config)(state_t state)
        opt_result_t (*decode_translate_block_optimized)(state_t state, int_t config, int_t limit, int_t pres);
        obj_t (*traverse_insn_list)(state_t state, obj_t insn_list, obj_t insns_init, obj_t (*insn_cb)(state_t, obj_t, obj_t))

    cdef struct frontend:
        _generic generic
        _decoder decoder
        _translator translator
    size_t gdsl_multiplex_frontends_list(frontend_desc **descs);
    size_t gdsl_multiplex_frontends_list_with_base(frontend_desc **descs, char *base);
    char gdsl_multiplex_frontend_get_by_desc(frontend *frontend, frontend_desc desc);
    char gdsl_multiplex_frontend_get_by_lib_name(frontend *frontend, char *name);
    void gdsl_multiplex_descs_free(frontend_desc *descs, size_t descs_length);
    void gdsl_multiplex_frontend_close(frontend *frontend);

def frontends_list(base=None):
   cdef frontend_desc* descs
   cdef size_t count
   if base is None:
       count = gdsl_multiplex_frontends_list(&descs)
   else:
       count = gdsl_multiplex_frontends_list_with_base(&descs, base)
   l = []
   for i in range(count):
      if descs[i].name.endswith("rreil"):
         l.append((descs[i].name, descs[i].ext))
   if count:
       gdsl_multiplex_descs_free(descs, count) 
   return l

class GDSLError(Exception):
   pass

cdef class Stmts:
   cdef State state
   cdef obj_t _stmts

   def __cinit__(self, State state):
      self.state = state

   def __str__(self):
      cdef obj_t rope
      rope = self.state.frontend._frontend.translator.pretty(self.state._state, self._stmts)
      return self.state.merge_rope(rope)

   def convert(self, object builder):
      cdef void *userdata_backup
      cdef unboxed_callbacks_t callbacks
      cdef obj_t _res
      if not init_rreil_builder_callbacks(&callbacks):
         raise ValueError("Stmts.convert: something wrong.")
      userdata_backup = self.state._state.userdata
      self.state._state.userdata = <void *> builder
      _res = self.state.frontend._frontend.translator.rreil_convert_sem_stmt_list(self.state._state, &callbacks, self._stmts)
      self.state._state.userdata = userdata_backup
      return obj_t2object(_res)

cdef class Insn:
   cdef State state
   cdef obj_t _insn
   cdef asm_insn_t _ginsn

   def __cinit__(self, State state):
      self.state = state

   def __str__(self):
      cdef obj_t rope
      rope = self.state.frontend._frontend.decoder.pretty(self.state._state, self._insn)
      return self.state.merge_rope(rope)

   cdef obj_t convert(self, asm_callbacks_t callbacks):
      if self._ginsn is NULL:
         self._ginsn = <asm_insn_t>  self.state.frontend._frontend.decoder.generalize(self.state._state, self._insn)
      if setjmp(self.state.err_tgt()[0]):
         self.state.raise_error()
      return self.state.frontend._frontend.decoder.asm_convert_insn(self.state._state, callbacks, self._ginsn)

   def translate(self):
      stmts = Stmts(self.state)
      stmts._stmts = self.state.frontend._frontend.translator.translate(self.state._state, self._insn)
      return stmts

cdef class State:
   cdef Frontend frontend
   cdef state_t _state
   cdef unsigned char *c_code
   cdef uint64_t c_len
   
   def __cinit__(self, Frontend frontend):
      self.frontend = frontend
      self.c_code = NULL
      self.c_len = 0
      
   cdef jmp_buf* err_tgt(self):
      cdef jmp_buf* tgt
      tgt = self.frontend._frontend.generic.err_tgt(self._state)
      return tgt

   cdef raise_error(self):
      msg = self.frontend._frontend.generic.get_error_message(self._state)
      raise GDSLError(msg)

   cdef merge_rope(self, obj_t rope):
      return self.frontend._frontend.generic.merge_rope(self._state, rope)

   def set_code(self, bytes code, uint64_t base):
      cdef uint64_t c_len
      if self.c_code is not NULL:
         free(self.c_code)
      self.c_len = len(code)
      self.c_code = <unsigned char*> malloc(self.c_len)
      memcpy(self.c_code, <unsigned char*> code, self.c_len) 
      self.frontend._frontend.generic.set_code(self._state, self.c_code, self.c_len, base)

   def decode(self, config=None):
      if config is None:
         config = self.config_default
      return self._decode(config)
   
   cdef _decode(self, int_t config):
      if setjmp(self.err_tgt()[0]):
         self.raise_error()
      return self.do_decode(config)

   cdef do_decode(self, int_t config):
      cdef obj_t _insn
      _insn = self.frontend._frontend.decoder.decode(self._state, config)
      insn = Insn(self)
      insn._insn = _insn
      return insn
   
   def __dealloc__(self):
      if self.c_code is not NULL:
         free(self.c_code)
         self.c_code = NULL
      self.frontend._frontend.generic.destroy(self._state)

   def seek(self, int_t d):
      self.frontend._frontend.generic.seek(self._state, d)          

   def reset_heap(self):
      self.frontend._frontend.generic.reset_heap(self._state)          

   cdef list_config(self, obj_t _config):
      l = []
      while self.frontend._frontend.decoder.has_conf(self._state, _config):
         short_desc = self.frontend._frontend.decoder.conf_short(self._state, _config)
         long_desc = self.frontend._frontend.decoder.conf_long(self._state, _config)
         data = self.frontend._frontend.decoder.conf_data(self._state, _config)
         l.append((short_desc, long_desc, data))
         _config = self.frontend._frontend.decoder.conf_next(self._state, _config)
      return l  

   property ip:
       def __get__(self):
          return self.frontend._frontend.generic.get_ip(self._state)

   property config_default:
       def __get__(self):
          return self.frontend._frontend.decoder.config_default(self._state)
          
   property decoder_config:
       def __get__(self):
          cdef obj_t _config
          _config = self.frontend._frontend.decoder.decoder_config(self._state)
          return self.list_config(_config)
       
   property optimization_config:
       def __get__(self):
          cdef obj_t _config
          _config = self.frontend._frontend.translator.optimization_config(self._state)
          return self.list_config(_config)
       
cdef class Frontend:
   cdef frontend* _frontend
   def __cinit__(self, name, ext=None):
       cdef frontend_desc desc
       cdef char res
       self._frontend = <frontend*> malloc(sizeof(frontend))
       if self._frontend is not NULL:
           if ext is not None:
               desc.name = name
               desc.ext = ext
               print 'gdsl_multiplex_frontend_get_by_desc', desc.name, desc.ext
               res = gdsl_multiplex_frontend_get_by_desc(self._frontend, desc)
               print 'res=', res
           else:
               res = gdsl_multiplex_frontend_get_by_lib_name(self._frontend, name)
            
           if res > 0:
              free(self._frontend)
              self._frontend = NULL
              err_msgs = [ "Frontends path not set.", "Unable to open.", "Symbol not found." ]
              err = res - 1
              if err < len(err_msgs):
                  msg = err_msgs[err]
              else:
                  msg = "Unknown Error(%d)" % res   
              raise ValueError(msg)
       else:
           raise MemoryError()
       
   def __dealloc__(self):
       if self._frontend is not NULL:
           gdsl_multiplex_frontend_close(self._frontend)
           free(self._frontend)
           self._frontend = NULL

   def init(self):
      cdef state_t _state
      cdef State state
      _state = self._frontend.generic.init()
      state = State(self)
      state._state = _state
      return state

this_module = __import__(__name__)   
for name, ext in frontends_list():
   if name.endswith("rreil"):
       fname = name[0:-6].upper()
       print "Loading", fname
       setattr(this_module, fname, Frontend(name, ext))
       print "Done"
print "Load"
del this_module
