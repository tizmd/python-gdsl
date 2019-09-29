from libc.stdint cimport *
from libc.setjmp cimport jmp_buf

cdef extern from "gdsl-cython.h":
    cdef struct state:
        void *userdata

    ctypedef state* state_t
    ctypedef void * obj_t
    ctypedef char * string_t
    ctypedef long long int int_t
    ctypedef uint64_t vec_data_t

    cdef struct vec_t:
        unsigned int size
        vec_data_t data

    ctypedef int_t con_tag_t


