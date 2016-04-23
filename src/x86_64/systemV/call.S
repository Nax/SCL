.global _SCL_CallNew
.global _SCL_CallResume

/*
 * Params :
 * rdi - The routine
 * rsi - The param
 * rdx - The stack
 */
_SCL_CallNew:
    movq %rbp, -8(%rdx)
    movq %rsp, -16(%rdx)

    movq %rdx, %rbp
    movq %rdx, %rsp
    movq %rdi, %rax
    movq %rsi, %rdi

    subq $16, %rsp

    callq *%rax

    movq -16(%rbp), %rsp
    movq -8(%rbp), %rbp

    movq $1, %rax
    
    ret

/*
 * Params :
 * rdi - The state ptr
 */
_SCL_CallResume:
    movq %rdi, %rax
    movq 0x10(%rax), %rbx
    movq 0x18(%rax), %rcx
    movq 0x20(%rax), %rdx
    movq 0x28(%rax), %rsi
    movq 0x30(%rax), %rdi
    movq 0x38(%rax), %rbp
    movq 0x40(%rax), %rsp

    movq 0x08(%rax), %rax
    ret
