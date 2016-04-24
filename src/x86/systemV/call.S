.global _SCL_CallNew
.global _SCL_CallResume

/*
 * Params :
 * 8(ebp)   - The routine
 * 12(ebp)   - The param
 * 16(ebp)  - The stack
 */
_SCL_CallNew:
    push %ebp
    movl %esp, %ebp
    pusha

    movl 16(%ebp), %ecx
    movl %ebp, -4(%ecx)
    movl %esp, -8(%ecx)

    movl  8(%ebp), %eax
    movl  12(%ebp), %edx

    movl %ecx, %ebp
    sub $8, %ebp
    movl %ebp, %esp
    pushl %edx
    sub $4, %esp

    calll *%eax

    add $8, %esp
    movl 0(%ebp), %esp
    movl 4(%ebp), %ebp

    popa
    movl $1, %eax
    mov %ebp, %esp
    pop %ebp
    ret

/*
 * Params :
 * 8(ebp) - The state ptr
 */
_SCL_CallResume:
    push %ebp
    mov %esp, %ebp
    pusha

    movl 8(%ebp), %edi
    movl 0x20(%edi), %eax
    push %eax
    popf
    
    mov $1, %eax
    fxrstor 0x2c(%edi)

    movl %edi, %eax
    movl 0x04(%eax), %ebx
    movl 0x08(%eax), %ecx
    movl 0x0c(%eax), %edx
    movl 0x10(%eax), %esi
    movl 0x14(%eax), %edi
    movl 0x18(%eax), %ebp
    movl 0x1c(%eax), %esp

    movl 0x00(%eax), %eax
    ret
