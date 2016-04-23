#include <stdio.h>
#include <SCL/SCL.h>

void foo(void* param)
{
    printf("Hello\n");
    yield;
    printf("... World ...\n");
    yield;
    printf("... from a Coroutine !\n");
    return;
}

int main()
{
    SCL_Coroutine* coroutine = SCL_CreateCoroutine(foo, NULL, 0);
    SCL_Call(coroutine);
    printf("Between coroutine calls.\n");
    SCL_Call(coroutine);
    printf("Between coroutine calls. (again)\n");
    SCL_Call(coroutine);
    return 0;
}
