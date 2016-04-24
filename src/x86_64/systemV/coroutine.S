.global _SCL_GetActiveCoroutine

.global _SCL_CallNew
.global _SCL_CallResume
.global _SCL_Yield

.macro push_all
    push %rbx
    push %r12
    push %r13
    push %r14
    push %r15
.endm

.macro pop_all
    pop %r15
    pop %r14
    pop %r13
    pop %r12
    pop %rbx
.endm

/*
 * Params :
 * rdi - The routine
 * rsi - The param
 * rdx - The stack
 */
_SCL_CallNew:
    push %rbp
    mov %rsp, %rbp
    
    /* Save callee-saved registers */
    push_all

    /*
     * Temporary save
     * rsp -> rbx
     */
    mov %rsp, %rbx

    /*
     * Stack switch
     */
    mov %rdx, %rbp
    mov %rbp, %rsp

    /*
     * Push old rsp
     */
    push %rbx

    /* Align stack */
    sub $8, %rsp

    mov %rdi, %rax
    mov %rsi, %rdi

    call *%rax

    /*
     * Restore registers
     */
    add $8, %rsp
    pop %rsp

    pop_all

    mov $1, %rax

    pop %rbp
    ret

/*
 * Params :
 * rdi - The state ptr
 */
_SCL_CallResume:
    push %rbp
    mov %rsp, %rbp

    push_all

    /*
     * Quick stack switch
     */
    mov (%rdi), %rsp

    pop_all

    pop %rbp
    ret


_SCL_Yield:
    push %rbp
    mov %rsp, %rbp

    push_all

    call _SCL_GetActiveCoroutine
    mov %rsp, 8(%rax)

    /*
     * Get the stack bottom
     */
    mov (%rax), %rsi
    mov -8(%rsi), %rsp

    pop_all

    xor %rax, %rax

    pop %rbp
    ret
