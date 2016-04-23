# SCL
## The Simple Coroutine Library

SCL is a C implementation of coroutines.  
This is still work in progress, expect your code to break.

As of now, only x86_64 with SystemV calling convention is supported (read: 64 bits Mac OS X, Linux and BSD).

Linux support is still in progress. Windows and 32 bit support is also planned.

## Example code

```c
#include <stdio.h>
#include <SCL/SCL.h>

void foo(void* param)
{
    printf("Hello\n");
    yield;
    printf("... World ...\n");
    yield;
    printf("... from a Coroutine!\n");
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
```

Output

```
Hello
Between coroutine calls.
... World ...
Between coroutine calls. (again)
... from a Coroutine!
```

## How to build

SCL uses the cmake build system.

Example using ninja:
```
mkdir build
cd build
cmake .. -G Ninja
ninja
sudo ninja install
```

## Known issues

 * Coroutines can't be resumed from other threads. This is a design choice and won't be fixed.

## License

SCL is distributes under the MIT license.
