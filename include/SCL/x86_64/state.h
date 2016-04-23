#ifndef SCL_X86_64_STATE_H
#define SCL_X86_64_STATE_H

#include <stdint.h>

struct SCL_State_
{
    uint64_t    rip;
    uint64_t    rax;
    uint64_t    rbx;
    uint64_t    rcx;
    uint64_t    rdx;
    uint64_t    rsi;
    uint64_t    rdi;
    uint64_t    rbp;
    uint64_t    rsp;
};

#endif
