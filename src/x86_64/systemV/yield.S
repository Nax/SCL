.global _SCL_Yield
.global _SCL_GetActiveCoroutine

_SCL_Yield:
    pushq %rax
    callq _SCL_GetActiveCoroutine
    addq $8, %rax

    /* rax now points to the state */

    /* Push the return addr */
    pushq %rbx
    movq -8(%rbp), %rbx
    movq %rbx, 0(%rax)
    /* Push the stored rax */
    movq -16(%rsp), %rbx
    movq %rbx, 8(%rax)
    popq %rbx
    add $8, %rsp

    mov %rbx, 0x10(%rax)
    mov %rcx, 0x18(%rax)
    mov %rdx, 0x20(%rax)
    mov %rsi, 0x28(%rax)
    mov %rdi, 0x30(%rax)
    mov %rbp, 0x38(%rax)
    mov %rsp, 0x40(%rax)

    mov -8(%rax), %rax

    movq -16(%rax), %rsp
    movq -8(%rax), %rbp
    xorq %rax, %rax
    ret
