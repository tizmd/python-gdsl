from libc.stdlib cimport malloc, free
from cpython cimport Py_INCREF, Py_DECREF

from gdsl_callbacks cimport *
import rreil
import sys

cdef inline obj_t object2obj_t(object o):
    Py_INCREF(o)
    return <obj_t> o

cdef inline object obj_t2object(obj_t p):
    if p is NULL:
        return None
    o = <object> p
    Py_DECREF(o)
    return o
        
cdef obj_t branch_hint_callback(state_t state, int_t con) except NULL:
   b = rreil.BranchHint(con + 1)
   return object2obj_t(b)

cdef obj_t sem_address_callback(state_t state, int_t size, obj_t _a) except NULL:
    builder = <object> state.userdata
    if _a is NULL:
        return NULL
    a = obj_t2object(_a)
    r = builder.Address(size, a)
    return object2obj_t(r)

cdef obj_t sem_exception_callback_arch(state_t state, string_t arch) except NULL:
    builder = <object> state.userdata
    r = builder.ArchException(arch)
    return object2obj_t(r)

cdef obj_t sem_exception_callback_shared(state_t state, int_t shared) except NULL:
    builder = <object> state.userdata
    r = builder.SharedException(shared)
    return object2obj_t(r)

cdef obj_t sem_expr_callback_and(state_t state, obj_t _a, obj_t _b) except NULL:
    builder = <object> state.userdata
    if _a is NULL or _b is NULL:
        return NULL
    a = obj_t2object(_a)
    b = obj_t2object(_b)    
    r = builder.And(a, b)
    return object2obj_t(r)

cdef obj_t sem_expr_callback_div(state_t state, obj_t _a, obj_t _b) except NULL:
    builder = <object> state.userdata
    if _a is NULL or _b is NULL:
        return NULL
    a = obj_t2object(_a)
    b = obj_t2object(_b)    
    r = builder.Div(a, b)
    return object2obj_t(r)

cdef obj_t sem_expr_callback_divs(state_t state, obj_t _a, obj_t _b) except NULL:
    builder = <object> state.userdata
    if _a is NULL or _b is NULL:
        return NULL
    a = obj_t2object(_a)
    b = obj_t2object(_b)    
    r = builder.DivS(a, b)
    return object2obj_t(r)

cdef obj_t sem_expr_callback_mod(state_t state, obj_t _a, obj_t _b) except NULL:
    builder = <object> state.userdata
    if _a is NULL or _b is NULL:
        return NULL
    a = obj_t2object(_a)
    b = obj_t2object(_b)    
    r = builder.Mod(a, b)
    return object2obj_t(r)

cdef obj_t sem_expr_callback_mods(state_t state, obj_t _a, obj_t _b) except NULL:
    builder = <object> state.userdata
    if _a is NULL or _b is NULL:
        return NULL
    a = obj_t2object(_a)
    b = obj_t2object(_b)    
    r = builder.ModS(a, b)
    return object2obj_t(r)

cdef obj_t sem_expr_callback_mul(state_t state, obj_t _a, obj_t _b) except NULL:
    builder = <object> state.userdata
    if _a is NULL or _b is NULL:
        return NULL
    a = obj_t2object(_a)
    b = obj_t2object(_b)    
    r = builder.Mul(a, b)
    return object2obj_t(r)

cdef obj_t sem_expr_callback_or(state_t state, obj_t _a, obj_t _b) except NULL:
    builder = <object> state.userdata
    if _a is NULL or _b is NULL:
        return NULL
    a = obj_t2object(_a)
    b = obj_t2object(_b)    
    r = builder.Or(a, b)
    return object2obj_t(r)

cdef obj_t sem_expr_callback_sexpr(state_t state, obj_t _a) except NULL:
    builder = <object> state.userdata
    if _a is NULL:
        return NULL
    a = obj_t2object(_a)
    r = builder.SExpr(a)
    return object2obj_t(r)

cdef obj_t sem_expr_callback_shl(state_t state, obj_t _a, obj_t _b) except NULL:
    builder = <object> state.userdata
    if _a is NULL or _b is NULL:
        return NULL
    a = obj_t2object(_a)
    b = obj_t2object(_b)    
    r = builder.ShL(a, b)
    return object2obj_t(r)

cdef obj_t sem_expr_callback_shr(state_t state, obj_t _a, obj_t _b) except NULL:
    builder = <object> state.userdata
    if _a is NULL or _b is NULL:
        return NULL
    a = obj_t2object(_a)
    b = obj_t2object(_b)    
    r = builder.ShR(a, b)
    return object2obj_t(r)

cdef obj_t sem_expr_callback_shrs(state_t state, obj_t _a, obj_t _b) except NULL:
    builder = <object> state.userdata
    if _a is NULL or _b is NULL:
        return NULL
    a = obj_t2object(_a)
    b = obj_t2object(_b)    
    r = builder.ShRS(a, b)
    return object2obj_t(r)

cdef obj_t sem_expr_callback_sx(state_t state, int_t size, obj_t _a) except NULL:
    builder = <object> state.userdata
    if _a is NULL:
        return NULL
    a = obj_t2object(_a)
    r = builder.Sx(size, a)
    return object2obj_t(r)

cdef obj_t sem_expr_callback_xor(state_t state, obj_t _a, obj_t _b) except NULL:
    builder = <object> state.userdata
    if _a is NULL or _b is NULL:
        return NULL
    a = obj_t2object(_a)
    b = obj_t2object(_b)    
    r = builder.Xor(a, b)
    return object2obj_t(r)

cdef obj_t sem_expr_callback_zx(state_t state, int_t size, obj_t _a) except NULL:
    builder = <object> state.userdata
    if _a is NULL:
        return NULL
    a = obj_t2object(_a)
    r = builder.Zx(size, a)
    return object2obj_t(r)

cdef obj_t sem_expr_cmp_callback_eq(state_t state, obj_t _a, obj_t _b) except NULL:
    builder = <object> state.userdata
    if _a is NULL or _b is NULL:
        return NULL
    a = obj_t2object(_a)
    b = obj_t2object(_b)    
    r = builder.Eq(a, b)
    return object2obj_t(r)

cdef obj_t sem_expr_cmp_callback_les(state_t state, obj_t _a, obj_t _b) except NULL:
    builder = <object> state.userdata
    if _a is NULL or _b is NULL:
        return NULL
    a = obj_t2object(_a)
    b = obj_t2object(_b)    
    r = builder.LeS(a, b)
    return object2obj_t(r)

cdef obj_t sem_expr_cmp_callback_leu(state_t state, obj_t _a, obj_t _b) except NULL:
    builder = <object> state.userdata
    if _a is NULL or _b is NULL:
        return NULL
    a = obj_t2object(_a)
    b = obj_t2object(_b)    
    r = builder.LeU(a, b)
    return object2obj_t(r)

cdef obj_t sem_expr_cmp_callback_lts(state_t state, obj_t _a, obj_t _b) except NULL:
    builder = <object> state.userdata
    if _a is NULL or _b is NULL:
        return NULL
    a = obj_t2object(_a)
    b = obj_t2object(_b)    
    r = builder.LtS(a, b)
    return object2obj_t(r)

cdef obj_t sem_expr_cmp_callback_ltu(state_t state, obj_t _a, obj_t _b) except NULL:
    builder = <object> state.userdata
    if _a is NULL or _b is NULL:
        return NULL
    a = obj_t2object(_a)
    b = obj_t2object(_b)    
    r = builder.LtU(a, b)
    return object2obj_t(r)

cdef obj_t sem_expr_cmp_callback_neq(state_t state, obj_t _a, obj_t _b) except NULL:
    builder = <object> state.userdata
    if _a is NULL or _b is NULL:
        return NULL
    a = obj_t2object(_a)
    b = obj_t2object(_b)    
    r = builder.Neq(a, b)
    return object2obj_t(r)

cdef obj_t sem_flop_callback_(state_t state, int_t flop) except NULL:
    r = rreil.RREIL_FLOP(flop + 1)
    return object2obj_t(r)

cdef obj_t sem_id_callback_arch(state_t state, string_t arch) except NULL:
    builder = <object> state.userdata
    r = builder.ArchId(arch)
    return object2obj_t(r)

cdef obj_t sem_id_callback_shared(state_t state, int_t shared) except NULL:
    builder = <object> state.userdata
    r = builder.SharedId(shared)
    return object2obj_t(r)

cdef obj_t sem_id_callback_virt_o(state_t state, int_t temp) except NULL:
    builder = <object> state.userdata
    r = builder.TemporaryId(temp)
    return object2obj_t(r)

cdef obj_t sem_id_callback_virt_t(state_t state, int_t temp) except NULL:
    builder = <object> state.userdata
    r = builder.TemporaryId(temp)
    return object2obj_t(r)

cdef obj_t sem_linear_callback_lin_add(state_t state, obj_t _a, obj_t _b) except NULL:
    builder = <object> state.userdata
    if _a is NULL or _b is NULL:
        return NULL
    a = obj_t2object(_a)
    b = obj_t2object(_b)    
    r = builder.LinAdd(a, b)
    return object2obj_t(r)

cdef obj_t sem_linear_callback_lin_imm(state_t state, int_t imm) except NULL:
    builder = <object> state.userdata
    r = builder.LinImm(imm)
    return object2obj_t(r)

cdef obj_t sem_linear_callback_lin_scale(state_t state, int_t imm, obj_t _a) except NULL:
    builder = <object> state.userdata
    if _a is NULL:
        return NULL
    a = obj_t2object(_a)
    r = builder.LinScale(imm, a)
    return object2obj_t(r)

cdef obj_t sem_linear_callback_lin_sub(state_t state, obj_t _a, obj_t _b) except NULL:
    builder = <object> state.userdata
    if _a is NULL or _b is NULL:
        return NULL
    a = obj_t2object(_a)
    b = obj_t2object(_b)    
    r = builder.LinSub(a, b)
    return object2obj_t(r)

cdef obj_t sem_linear_callback_lin_var(state_t state, obj_t _a) except NULL:
    builder = <object> state.userdata
    if _a is NULL:
        return NULL
    a = obj_t2object(_a)
    r = builder.LinVar(a)
    return object2obj_t(r)

cdef obj_t sem_sexpr_callback_arb(state_t state) except NULL:
    builder = <object> state.userdata
    r = builder.Arb()
    return object2obj_t(r)

cdef obj_t sem_sexpr_callback_cmp(state_t state, int_t size, obj_t _a) except NULL:
    builder = <object> state.userdata
    if _a is NULL:
        return NULL
    a = obj_t2object(_a)
    r = builder.Cmp(size, a)
    return object2obj_t(r)

cdef obj_t sem_sexpr_callback_lin(state_t state, obj_t _a) except NULL:
    builder = <object> state.userdata
    if _a is NULL:
        return NULL
    a = obj_t2object(_a)
    r = builder.Lin(a)
    return object2obj_t(r)

cdef obj_t sem_stmt_callback_assign(state_t state, int_t size, obj_t _a, obj_t _b) except NULL:
    builder = <object> state.userdata
    if _a is NULL or _b is NULL:
        return NULL
    a = obj_t2object(_a)
    b = obj_t2object(_b)    
    r = builder.Assign(size, a, b)
    return object2obj_t(r)

cdef obj_t sem_stmt_callback_branch(state_t state, obj_t _a, obj_t _b) except NULL:
    builder = <object> state.userdata
    if _a is NULL or _b is NULL:
        return NULL
    a = obj_t2object(_a)
    b = obj_t2object(_b)    
    r = builder.Branch(a, b)
    return object2obj_t(r)

cdef obj_t sem_stmt_callback_cbranch(state_t state, obj_t _a, obj_t _b, obj_t _c) except NULL:
    builder = <object> state.userdata
    if _a is NULL or _b is NULL or _c is NULL:
        return NULL
    a = obj_t2object(_a)
    b = obj_t2object(_b)
    c = obj_t2object(_c)        
    r = builder.CBranch(a, b, c)
    return object2obj_t(r)

cdef obj_t sem_stmt_callback_flop(state_t state, obj_t _a, obj_t _b, obj_t _c, obj_t _d) except NULL:
    builder = <object> state.userdata
    if _a is NULL or _b is NULL or _c is NULL or _d is NULL:
        return NULL
    a = obj_t2object(_a)
    b = obj_t2object(_b)
    c = obj_t2object(_c)
    d = obj_t2object(_d)            
    r = builder.Flop(a, b, c, d)
    return object2obj_t(r)

cdef obj_t sem_stmt_callback_ite(state_t state, obj_t _a, obj_t _b, obj_t _c) except NULL: 
    builder = <object> state.userdata
    if _a is NULL or _b is NULL or _c is NULL:
        return NULL
    a = obj_t2object(_a)
    b = obj_t2object(_b)
    c = obj_t2object(_c)
    r = builder.Ite(a, b, c)
    return object2obj_t(r)

cdef obj_t sem_stmt_callback_load(state_t state, int_t size, obj_t _a, obj_t _b) except NULL:
    builder = <object> state.userdata
    if _a is NULL or _b is NULL:
        return NULL
    a = obj_t2object(_a)
    b = obj_t2object(_b)
    r = builder.Load(size, a, b)
    return object2obj_t(r)

cdef obj_t sem_stmt_callback_prim(state_t state, string_t op, obj_t _a, obj_t _b) except NULL:
    builder = <object> state.userdata
    if _a is NULL or _b is NULL:
        return NULL
    a = obj_t2object(_a)
    b = obj_t2object(_b)
    r = builder.Prim(op, a, b)
    return object2obj_t(r)

cdef obj_t sem_stmt_callback_store(state_t state, int_t size, obj_t _a, obj_t _b) except NULL:
    builder = <object> state.userdata
    if _a is NULL or _b is NULL:
        return NULL
    a = obj_t2object(_a)
    b = obj_t2object(_b)
    r = builder.Store(size, a, b)
    return object2obj_t(r)

cdef obj_t sem_stmt_callback_throw(state_t state, obj_t _a) except NULL:
    builder = <object> state.userdata
    if _a is NULL:
        return NULL
    a = obj_t2object(_a)
    r = builder.Throw(a)
    return object2obj_t(r)

cdef obj_t sem_stmt_callback_while(state_t state, obj_t _a, obj_t _b) except NULL:
    builder = <object> state.userdata
    if _a is NULL or _b is NULL:
        return NULL
    a = obj_t2object(_a)
    b = obj_t2object(_b)
    r = builder.While(a, b)
    return object2obj_t(r)

cdef obj_t sem_var_callback_(state_t state, obj_t _a, int_t offset) except NULL:
    builder = <object> state.userdata
    if _a is NULL:
        return NULL
    a = obj_t2object(_a)
    r = builder.Variable(a, offset)
    return object2obj_t(r)

cdef obj_t sem_varl_callback_(state_t state, obj_t _a, int_t offset, int_t size) except NULL:
    builder = <object> state.userdata
    if _a is NULL:
        return NULL
    a = obj_t2object(_a)
    r = builder.VariableLimited(a, offset, size)
    return object2obj_t(r)

cdef obj_t sem_stmt_list_callback_init(state_t state) except NULL:
    builder = <object> state.userdata
    r = builder.StatementListInit()
    return object2obj_t(r)

cdef obj_t sem_stmt_list_callback_next(state_t state, obj_t _a, obj_t _b) except NULL:
    builder = <object> state.userdata
    if _a is NULL or _b is NULL:
        return NULL
    a = obj_t2object(_a)
    b = obj_t2object(_b)
    r = builder.StatementListNext(a, b)
    return object2obj_t(r)    

cdef obj_t sem_varl_list_callback_init(state_t state) except NULL:
    builder = <object> state.userdata
    r = builder.VariableLimitedListInit()
    return object2obj_t(r)

cdef obj_t sem_varl_list_callback_next(state_t state, obj_t _a, obj_t _b) except NULL:
    builder = <object> state.userdata
    if _a is NULL or _b is NULL:
        return NULL
    a = obj_t2object(_a)
    b = obj_t2object(_b)
    r = builder.VariableLimitedListNext(a, b)
    return object2obj_t(r)    

    
cdef unboxed_branch_hint_callbacks_t branch_hint
cdef unboxed_sem_address_callbacks_t sem_address
cdef unboxed_sem_exception_callbacks_t sem_exception
cdef unboxed_sem_expr_callbacks_t sem_expr
cdef unboxed_sem_expr_cmp_callbacks_t sem_expr_cmp
cdef unboxed_sem_flop_callbacks_t sem_flop
cdef unboxed_sem_id_callbacks_t sem_id
cdef unboxed_sem_linear_callbacks_t sem_linear
cdef unboxed_sem_sexpr_callbacks_t sem_sexpr
cdef unboxed_sem_stmt_callbacks_t sem_stmt
cdef unboxed_sem_stmt_list_callbacks_t sem_stmt_list
cdef unboxed_sem_var_callbacks_t sem_var
cdef unboxed_sem_varl_callbacks_t sem_varl
cdef unboxed_sem_varl_list_callbacks_t sem_varl_list

cdef init_rreil_builder_callbacks(callbacks_t _callbacks):
    if _callbacks is NULL:
        return False

    global branch_hint
    global sem_address
    global sem_exception
    global sem_expr
    global sem_expr_cmp
    global sem_flop
    global sem_id
    global sem_linear
    
    if branch_hint.branch_hint_ is NULL:
        branch_hint.branch_hint_ = branch_hint_callback

        sem_address.sem_address_ = sem_address_callback

        sem_exception.arch = sem_exception_callback_arch
        sem_exception.shared = sem_exception_callback_shared

        sem_expr.sem_and = sem_expr_callback_and
        sem_expr.sem_div = sem_expr_callback_div
        sem_expr.sem_divs = sem_expr_callback_divs        
        sem_expr.sem_mod = sem_expr_callback_mod
        sem_expr.sem_mods = sem_expr_callback_mods
        sem_expr.sem_mul = sem_expr_callback_mul            
        sem_expr.sem_or = sem_expr_callback_or
        sem_expr.sem_sexpr = sem_expr_callback_sexpr
        sem_expr.sem_shl = sem_expr_callback_shl    
        sem_expr.sem_shr = sem_expr_callback_shr
        sem_expr.sem_shrs = sem_expr_callback_shrs
        sem_expr.sem_sx = sem_expr_callback_sx
        sem_expr.sem_xor = sem_expr_callback_xor    
        sem_expr.sem_zx = sem_expr_callback_zx    
        
        sem_expr_cmp.sem_cmpeq = sem_expr_cmp_callback_eq
        sem_expr_cmp.sem_cmples = sem_expr_cmp_callback_les
        sem_expr_cmp.sem_cmpleu = sem_expr_cmp_callback_leu    
        sem_expr_cmp.sem_cmplts = sem_expr_cmp_callback_lts
        sem_expr_cmp.sem_cmpltu = sem_expr_cmp_callback_ltu    
        sem_expr_cmp.sem_cmpneq = sem_expr_cmp_callback_neq
        
        sem_flop.sem_flop_ = sem_flop_callback_
        
        sem_id.arch = sem_id_callback_arch
        sem_id.shared = sem_id_callback_shared
        sem_id.virt_o = sem_id_callback_virt_o        
        sem_id.virt_t = sem_id_callback_virt_t
        
        sem_linear.sem_lin_add = sem_linear_callback_lin_add
        sem_linear.sem_lin_imm = sem_linear_callback_lin_imm
        sem_linear.sem_lin_scale = sem_linear_callback_lin_scale
        sem_linear.sem_lin_sub = sem_linear_callback_lin_sub
        sem_linear.sem_lin_var = sem_linear_callback_lin_var    
        
        sem_sexpr.sem_sexpr_arb = sem_sexpr_callback_arb
        sem_sexpr.sem_sexpr_cmp = sem_sexpr_callback_cmp
        sem_sexpr.sem_sexpr_lin = sem_sexpr_callback_lin
        
        sem_stmt.sem_assign = sem_stmt_callback_assign
        sem_stmt.sem_branch = sem_stmt_callback_branch
        sem_stmt.sem_cbranch = sem_stmt_callback_cbranch
        sem_stmt.sem_flop = sem_stmt_callback_flop
        sem_stmt.sem_ite = sem_stmt_callback_ite
        sem_stmt.sem_load = sem_stmt_callback_load
        sem_stmt.sem_prim = sem_stmt_callback_prim
        sem_stmt.sem_store = sem_stmt_callback_store
        sem_stmt.sem_throw = sem_stmt_callback_throw
        sem_stmt.sem_while = sem_stmt_callback_while

        sem_stmt_list.sem_stmt_list_init = sem_stmt_list_callback_init
        sem_stmt_list.sem_stmt_list_next = sem_stmt_list_callback_next
        
        sem_var.sem_var_ = sem_var_callback_
        sem_varl.sem_varl_ = sem_varl_callback_    
        
        sem_varl_list.sem_varl_list_init = sem_varl_list_callback_init
        sem_varl_list.sem_varl_list_next = sem_varl_list_callback_next

    _callbacks.branch_hint = &branch_hint
    _callbacks.sem_address = &sem_address
    _callbacks.sem_exception = &sem_exception
    _callbacks.sem_expr = &sem_expr
    _callbacks.sem_expr_cmp = &sem_expr_cmp
    _callbacks.sem_flop = &sem_flop
    _callbacks.sem_id = &sem_id
    _callbacks.sem_linear = &sem_linear
    _callbacks.sem_sexpr = &sem_sexpr
    _callbacks.sem_stmt = &sem_stmt
    _callbacks.sem_stmt_list = &sem_stmt_list
    _callbacks.sem_var = &sem_var
    _callbacks.sem_varl = &sem_varl    
    _callbacks.sem_varl_list = &sem_varl_list
    return True
