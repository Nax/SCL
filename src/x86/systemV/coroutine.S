.global _SCL_GetActiveCoroutine

.global _SCL_CallNew
.global _SCL_CallResume
.global _SCL_Yield

.macro push_all
    push %ebx
    push %edi
    push %esi
.endm

.macro pop_all
    pop %esi
    pop %edi
    pop %ebx
.endm

/*
 * Params :
 * 8(ebp)  - The routine
 * 12(ebp) - The param
 * 16(ebp) - The stack
 */
_SCL_CallNew:
    push %ebp
    mov %esp, %ebp
    
    /* Save callee-saved registers */
    push_all

    /*
     * Temporary save
     * esp -> ebx
     * routine -> edi
     * param -> esi
     * stack -> edx
     */
    mov %esp, %ebx
    mov 8(%ebp), %edi
    mov 12(%ebp), %esi
    mov 16(%ebp), %edx

    /*
     * Stack switch
     */
    mov %edx, %ebp
    mov %ebp, %esp

    /*
     * Push old esp
     */
    push %ebx

    /* Align stack */
    sub $8, %esp

    push %esi

    call *%edi

    /*
     * Restore registers
     */
    add $12, %esp
    pop %esp

    pop_all

    mov $1, %eax

    pop %ebp
    ret

/*
 * Params :
 * 8(ebp) - The state ptr
 */
_SCL_CallResume:
    push %ebp
    mov %esp, %ebp

    push_all

    /*
     * Quick stack switch
     */
    mov 8(%ebp), %edi
    mov (%edi), %esp

    pop_all

    pop %ebp
    ret

_SCL_Yield:
    push %ebp
    mov %esp, %ebp

    push_all

    call _SCL_GetActiveCoroutine
    mov %esp, 4(%eax)

    /*
     * Get the stack bottom
     */
    mov (%eax), %esi
    mov -4(%esi), %esp

    pop_all

    xor %eax, %eax

    pop %ebp
    ret
