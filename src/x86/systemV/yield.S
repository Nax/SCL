.global _SCL_Yield
.global _SCL_GetActiveCoroutine

_SCL_Yield:
    pushf
    push %eax
    call _SCL_GetActiveCoroutine
    add $4, %eax

    /* eax now points to the state */

    push %ebx
    /* Push the stored rax */
    movl 8(%esp), %ebx
    movl %ebx, 0x00(%eax)
    /* Push the flags */
    mov 12(%esp), %ebx
    mov %ebx, 0x20(%eax)
    pop %ebx
    add $8, %esp

    mov %ebx, 0x04(%eax)
    mov %ecx, 0x08(%eax)
    mov %edx, 0x0c(%eax)
    mov %esi, 0x10(%eax)
    mov %edi, 0x14(%eax)
    mov %ebp, 0x18(%eax)
    mov %esp, 0x1c(%eax)

    mov %eax, %edi
    mov $1, %eax
    fxsave 0x2c(%edi)

    mov -4(%edi), %eax

    mov -8(%eax), %esp
    mov -4(%eax), %ebp
    xor %eax, %eax
    ret
