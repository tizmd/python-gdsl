from gdsl_common cimport *
cdef extern from "gdsl-cython.h":
    ctypedef struct unboxed_branch_hint_callbacks_t:
        obj_t (*branch_hint_)(state_t,int_t) except NULL
    ctypedef unboxed_branch_hint_callbacks_t* branch_hint_callbacks_t

    ctypedef struct unboxed_sem_address_callbacks_t:
        obj_t (*sem_address_)(state_t,int_t,obj_t) except NULL
    ctypedef unboxed_sem_address_callbacks_t* sem_address_callbacks_t

    ctypedef struct unboxed_sem_exception_callbacks_t:
        obj_t (*arch)(state_t,string_t) except NULL
        obj_t (*shared)(state_t,int_t) except NULL
    ctypedef unboxed_sem_exception_callbacks_t* sem_exception_callbacks_t

    ctypedef struct unboxed_sem_expr_callbacks_t:
        obj_t (*sem_and)(state_t,obj_t,obj_t) except NULL
        obj_t (*sem_div)(state_t,obj_t,obj_t) except NULL
        obj_t (*sem_divs)(state_t,obj_t,obj_t) except NULL
        obj_t (*sem_mod)(state_t,obj_t,obj_t) except NULL
        obj_t (*sem_mods)(state_t,obj_t,obj_t) except NULL
        obj_t (*sem_mul)(state_t,obj_t,obj_t) except NULL
        obj_t (*sem_or)(state_t,obj_t,obj_t) except NULL
        obj_t (*sem_sexpr)(state_t,obj_t) except NULL
        obj_t (*sem_shl)(state_t,obj_t,obj_t) except NULL
        obj_t (*sem_shr)(state_t,obj_t,obj_t) except NULL
        obj_t (*sem_shrs)(state_t,obj_t,obj_t) except NULL
        obj_t (*sem_sx)(state_t,int_t,obj_t) except NULL
        obj_t (*sem_xor)(state_t,obj_t,obj_t) except NULL
        obj_t (*sem_zx)(state_t,int_t,obj_t) except NULL
    ctypedef unboxed_sem_expr_callbacks_t* sem_expr_callbacks_t

    ctypedef struct unboxed_sem_expr_cmp_callbacks_t:
        obj_t (*sem_cmpeq)(state_t,obj_t,obj_t) except NULL
        obj_t (*sem_cmples)(state_t,obj_t,obj_t) except NULL
        obj_t (*sem_cmpleu)(state_t,obj_t,obj_t) except NULL
        obj_t (*sem_cmplts)(state_t,obj_t,obj_t) except NULL
        obj_t (*sem_cmpltu)(state_t,obj_t,obj_t) except NULL
        obj_t (*sem_cmpneq)(state_t,obj_t,obj_t) except NULL
    ctypedef unboxed_sem_expr_cmp_callbacks_t* sem_expr_cmp_callbacks_t

    ctypedef struct unboxed_sem_flop_callbacks_t:
        obj_t (*sem_flop_)(state_t,int_t) except NULL
    ctypedef unboxed_sem_flop_callbacks_t* sem_flop_callbacks_t

    ctypedef struct unboxed_sem_id_callbacks_t:
        obj_t (*arch)(state_t,string_t) except NULL
        obj_t (*shared)(state_t,int_t) except NULL
        obj_t (*virt_o)(state_t,int_t) except NULL
        obj_t (*virt_t)(state_t,int_t) except NULL
    ctypedef unboxed_sem_id_callbacks_t* sem_id_callbacks_t

    ctypedef struct unboxed_sem_linear_callbacks_t:
        obj_t (*sem_lin_add)(state_t,obj_t,obj_t) except NULL
        obj_t (*sem_lin_imm)(state_t,int_t) except NULL
        obj_t (*sem_lin_scale)(state_t,int_t,obj_t) except NULL
        obj_t (*sem_lin_sub)(state_t,obj_t,obj_t) except NULL
        obj_t (*sem_lin_var)(state_t,obj_t) except NULL
    ctypedef unboxed_sem_linear_callbacks_t* sem_linear_callbacks_t

    ctypedef struct unboxed_sem_sexpr_callbacks_t:
        obj_t (*sem_sexpr_arb)(state_t) except NULL
        obj_t (*sem_sexpr_cmp)(state_t,int_t,obj_t) except NULL
        obj_t (*sem_sexpr_lin)(state_t,obj_t) except NULL
    ctypedef unboxed_sem_sexpr_callbacks_t* sem_sexpr_callbacks_t

    ctypedef struct unboxed_sem_stmt_callbacks_t:
        obj_t (*sem_assign)(state_t,int_t,obj_t,obj_t) except NULL
        obj_t (*sem_branch)(state_t,obj_t,obj_t) except NULL
        obj_t (*sem_cbranch)(state_t,obj_t,obj_t,obj_t) except NULL
        obj_t (*sem_flop)(state_t,obj_t,obj_t,obj_t,obj_t) except NULL
        obj_t (*sem_ite)(state_t,obj_t,obj_t,obj_t) except NULL
        obj_t (*sem_load)(state_t,int_t,obj_t,obj_t) except NULL
        obj_t (*sem_prim)(state_t,string_t,obj_t,obj_t) except NULL
        obj_t (*sem_store)(state_t,int_t,obj_t,obj_t) except NULL
        obj_t (*sem_throw)(state_t,obj_t) except NULL 
        obj_t (*sem_while)(state_t,obj_t,obj_t) except NULL
    ctypedef unboxed_sem_stmt_callbacks_t* sem_stmt_callbacks_t

    ctypedef struct unboxed_sem_stmt_list_callbacks_t:
        obj_t (*sem_stmt_list_init)(state_t) except NULL
        obj_t (*sem_stmt_list_next)(state_t,obj_t,obj_t) except NULL
    ctypedef unboxed_sem_stmt_list_callbacks_t* sem_stmt_list_callbacks_t

    ctypedef struct unboxed_sem_var_callbacks_t:
        obj_t (*sem_var_)(state_t,obj_t,int_t) except NULL
    ctypedef unboxed_sem_var_callbacks_t* sem_var_callbacks_t

    ctypedef struct unboxed_sem_varl_callbacks_t:
        obj_t (*sem_varl_)(state_t,obj_t,int_t,int_t) except NULL
    ctypedef unboxed_sem_varl_callbacks_t* sem_varl_callbacks_t

    ctypedef struct unboxed_sem_varl_list_callbacks_t:
        obj_t (*sem_varl_list_init)(state_t) except NULL
        obj_t (*sem_varl_list_next)(state_t,obj_t,obj_t) except NULL
    ctypedef unboxed_sem_varl_list_callbacks_t* sem_varl_list_callbacks_t

    ctypedef struct unboxed_callbacks_t:
        branch_hint_callbacks_t branch_hint
        sem_address_callbacks_t sem_address
        sem_exception_callbacks_t sem_exception
        sem_expr_callbacks_t sem_expr
        sem_expr_cmp_callbacks_t sem_expr_cmp
        sem_flop_callbacks_t sem_flop
        sem_id_callbacks_t sem_id
        sem_linear_callbacks_t sem_linear
        sem_sexpr_callbacks_t sem_sexpr
        sem_stmt_callbacks_t sem_stmt
        sem_stmt_list_callbacks_t sem_stmt_list
        sem_var_callbacks_t sem_var
        sem_varl_callbacks_t sem_varl
        sem_varl_list_callbacks_t sem_varl_list
    ctypedef unboxed_callbacks_t* callbacks_t

    ctypedef struct unboxed_translate_result_t:
        obj_t insns
        obj_t succ_a
        obj_t succ_b
    ctypedef unboxed_translate_result_t* translate_result_t

    ctypedef struct unboxed_lv_super_result_t:
        obj_t after
        obj_t initial
    ctypedef unboxed_lv_super_result_t* lv_super_result_t

    ctypedef struct unboxed_insndata_t:
        int_t addr_sz
        int_t config
        int_t features
        obj_t insn
        int_t length
        int_t lock
        int_t opnd_sz
        int_t rep
        int_t repne
    ctypedef unboxed_insndata_t* insndata_t

    ctypedef struct unboxed_opt_result_t:
        obj_t insns
        obj_t rreil
    ctypedef unboxed_opt_result_t* opt_result_t
    
    ctypedef struct unboxed_asm_insn_t:
        obj_t annotations
        int_t length
        string_t mnemonic
        obj_t opnds
    ctypedef unboxed_asm_insn_t* asm_insn_t

    ctypedef struct unboxed_asm_annotation_callbacks_t:
        obj_t (*ann_string)(state_t,string_t) except NULL
        obj_t (*function)(state_t,string_t,obj_t) except NULL
        obj_t (*opnd)(state_t,string_t,obj_t) except NULL
    ctypedef unboxed_asm_annotation_callbacks_t* asm_annotation_callbacks_t

    ctypedef struct unboxed_asm_annotation_list_callbacks_t:
        obj_t (*annotation_list_next)(state_t,obj_t,obj_t) except NULL
        obj_t (*init)(state_t) except NULL
    ctypedef unboxed_asm_annotation_list_callbacks_t* asm_annotation_list_callbacks_t

    ctypedef struct unboxed_asm_boundary_callbacks_t:
        obj_t (*sz)(state_t,int_t) except NULL
        obj_t (*sz_o)(state_t,int_t,int_t) except NULL
    ctypedef unboxed_asm_boundary_callbacks_t* asm_boundary_callbacks_t

    ctypedef struct unboxed_asm_opnd_callbacks_t:
        obj_t (*annotated)(state_t,obj_t,obj_t) except NULL
        obj_t (*bounded)(state_t,obj_t,obj_t) except NULL
        obj_t (*composite)(state_t,obj_t) except NULL
        obj_t (*imm)(state_t,int_t) except NULL
        obj_t (*memory)(state_t,obj_t) except NULL
        obj_t (*opnd_register)(state_t,string_t) except NULL
        obj_t (*post_op)(state_t,obj_t,obj_t) except NULL
        obj_t (*pre_op)(state_t,obj_t,obj_t) except NULL
        obj_t (*rel)(state_t,obj_t) except NULL
        obj_t (*scale)(state_t,int_t,obj_t) except NULL
        obj_t (*sign)(state_t,obj_t,obj_t) except NULL
        obj_t (*sum)(state_t,obj_t,obj_t) except NULL
    ctypedef unboxed_asm_opnd_callbacks_t* asm_opnd_callbacks_t

    ctypedef struct unboxed_asm_opnd_list_callbacks_t:
        obj_t (*init)(state_t) except NULL
        obj_t (*opnd_list_next)(state_t,obj_t,obj_t) except NULL
    ctypedef unboxed_asm_opnd_list_callbacks_t* asm_opnd_list_callbacks_t

    ctypedef struct unboxed_asm_signedness_callbacks_t:
        obj_t (*asm_signed)(state_t) except NULL
        obj_t (*asm_unsigned)(state_t) except NULL
    ctypedef unboxed_asm_signedness_callbacks_t* asm_signedness_callbacks_t

    ctypedef struct unboxed_asm_callbacks_t:
        asm_annotation_callbacks_t annotation 
        asm_annotation_list_callbacks_t annotation_list
        asm_boundary_callbacks_t boundary
        obj_t (*insn)(state_t,int_t,string_t,obj_t,obj_t)
        asm_opnd_callbacks_t opnd
        asm_opnd_list_callbacks_t opnd_list
        asm_signedness_callbacks_t signedness
    ctypedef unboxed_asm_callbacks_t* asm_callbacks_t

