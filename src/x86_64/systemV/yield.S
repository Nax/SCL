.global _SCL_Yield
.global _SCL_GetActiveCoroutine

_SCL_Yield:
    pushq %rax
    callq _SCL_GetActiveCoroutine
    addq $8, %rax

    /* rax now points to the state */

    /* Push the return addr */
    pushq %rbx
    /* Push the stored rax */
    movq -16(%rsp), %rbx
    movq %rbx, 0x00(%rax)
    popq %rbx
    add $8, %rsp

    mov %rbx, 0x08(%rax)
    mov %rcx, 0x10(%rax)
    mov %rdx, 0x18(%rax)
    mov %rsi, 0x20(%rax)
    mov %rdi, 0x28(%rax)
    mov %rbp, 0x30(%rax)
    mov %rsp, 0x38(%rax)
    mov %r8,  0x40(%rax)
    mov %r9,  0x48(%rax)
    mov %r10, 0x50(%rax)
    mov %r11, 0x58(%rax)
    mov %r12, 0x60(%rax)
    mov %r13, 0x68(%rax)
    mov %r14, 0x70(%rax)
    mov %r15, 0x78(%rax)

    mov -8(%rax), %rax

    movq -16(%rax), %rsp
    movq -8(%rax), %rbp
    xorq %rax, %rax
    ret
