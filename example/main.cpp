#include <cstdio>
#include <SCL/SCLpp.h>

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
    scl::Coroutine coroutine(foo);
    coroutine();
    printf("Between coroutine calls.\n");
    coroutine();
    printf("Between coroutine calls. (again)\n");
    coroutine();
    coroutine.reset();
    coroutine();
    coroutine();
    return 0;
}
