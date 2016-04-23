#ifndef SCL_X86_STATE_H
#define SCL_X86_STATE_H

#include <stdint.h>

struct SCL_State_
{
    uint32_t    eax;
    uint32_t    ebx;
    uint32_t    ecx;
    uint32_t    edx;
    uint32_t    esi;
    uint32_t    edi;
    uint32_t    ebp;
    uint32_t    esp;
    uint32_t    dflags;
    char        padding[8];
    char        fxsave[512];
};

#endif
