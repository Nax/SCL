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
    movq 0x80(%rdi), %rax
    push %rax
    popf
    
    mov $1, %rax
    fxrstor64 0x88(%rdi)

    movq %rdi, %rax
    movq 0x8(%rax), %rbx
    movq 0x10(%rax), %rcx
    movq 0x18(%rax), %rdx
    movq 0x20(%rax), %rsi
    movq 0x28(%rax), %rdi
    movq 0x30(%rax), %rbp
    movq 0x38(%rax), %rsp
    movq 0x40(%rax), %r8
    movq 0x48(%rax), %r9
    movq 0x50(%rax), %r10
    movq 0x58(%rax), %r11
    movq 0x60(%rax), %r12
    movq 0x68(%rax), %r13
    movq 0x70(%rax), %r14
    movq 0x78(%rax), %r15

    movq 0x00(%rax), %rax
    ret
