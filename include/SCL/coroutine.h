#ifndef SCL_COROUTINE_H
#define SCL_COROUTINE_H

#include <SCL/api.h>
#include <SCL/state.h>
#include <SCL/status.h>

#define SCL_DEFAULT_STACK_SIZE  0x8000

typedef void (*SCL_Routine)(void*);

struct SCL_Coroutine_
{
    /* Oder matters */
    void*           stack_top;
    SCL_State       state;
    
    SCL_Routine     routine;
    SCL_Status      status;
    void*           param;
    void*           stack;
    size_t          stack_size;
};

typedef struct SCL_Coroutine_ SCL_Coroutine;

SCL_API SCL_Coroutine*  SCL_CreateCoroutine(SCL_Routine routine, void* param, size_t stak_size);
SCL_API SCL_Status      SCL_GetStatus(SCL_Coroutine* coroutine);
SCL_API void*           SCL_GetParam(SCL_Coroutine* coroutine);
SCL_API SCL_Status      SCL_Call(SCL_Coroutine* coroutine);

#endif
