#include <stdlib.h>
#include <SCL/coroutine.h>

SCL_API int SCL_CallNew(SCL_Routine routine, void* param, void* stack);
SCL_API int SCL_CallResume(SCL_State* state);

static __thread SCL_Coroutine* active_coroutine;

SCL_API SCL_Coroutine* SCL_GetActiveCoroutine()
{
    return active_coroutine;
}

SCL_API SCL_Coroutine* SCL_CreateCoroutine(SCL_Routine routine, void* param, size_t stack_size)
{
    SCL_Coroutine* coroutine;

    coroutine = malloc(sizeof(SCL_Coroutine));
    coroutine->routine = routine;
    coroutine->param = param;
    if (stack_size == 0)
        stack_size = SCL_DEFAULT_STACK_SIZE;
    coroutine->stack_size = stack_size;
    coroutine->stack = malloc(stack_size);
    coroutine->stack_top = coroutine->stack + stack_size;
    coroutine->status = SCL_STATUS_NEW;
    return coroutine;
}

SCL_API SCL_Status SCL_GetStatus(SCL_Coroutine* coroutine)
{
    return coroutine->status;
}

SCL_API void* SCL_GetParam(SCL_Coroutine* coroutine)
{
    return coroutine->param;
}

SCL_API SCL_Status SCL_Call(SCL_Coroutine* coroutine)
{
    SCL_Status status = coroutine->status;
    int ret;

    if (status == SCL_STATUS_FINISHED)
        return status;

    active_coroutine = coroutine;

    if (status == SCL_STATUS_NEW)
    {
        ret = SCL_CallNew(coroutine->routine, coroutine->param, coroutine->stack_top);
    }
    else
    {
        ret = SCL_CallResume(&coroutine->state);
    }
    if (ret)
        coroutine->status = SCL_STATUS_FINISHED;
    else
        coroutine->status = SCL_STATUS_IDLE;
    return coroutine->status;
}
