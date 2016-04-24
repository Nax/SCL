#ifndef SCL_SCLPP_H
#define SCL_SCLPP_H

#ifndef __cplusplus
# error A C++ compiler is required to use SCL++
#endif

#include <SCL/SCL.h>

namespace scl
{
#ifndef yield
    inline void yield()
    {
        SCL_Yield();
    }
#endif

    typedef ::SCL_Routine Routine;

    enum Status
    {
        StatusNew = SCL_STATUS_NEW,
        StatusIdle = SCL_STATUS_IDLE,
        StatusFinished = SCL_STATUS_FINISHED
    };

    class Coroutine
    {
    public:
        Coroutine()
        {
            _coroutine = 0;
        }

        Coroutine(Routine routine, void* param = 0, size_t stackSize = 0)
        {
            _coroutine = SCL_CreateCoroutine(routine, param, stackSize);
        }

#if (__cplusplus >= 201103L)
        Coroutine(Coroutine&& rhs) : _coroutine(rhs._coroutine)
        {
            rhs._coroutine = 0;
        }

        Coroutine& operator=(Coroutine&& rhs)
        {
            _coroutine = rhs._coroutine;
            rhs._coroutine = 0;
            return *this;
        }
#endif

        Status status()
        {
            return (scl::Status)SCL_GetStatus(_coroutine);
        }

        void* param()
        {
            return SCL_GetParam(_coroutine);
        }

        Status call()
        {
            return (scl::Status)SCL_Call(_coroutine);
        }

        Status operator()()
        {
            return call();
        }

        void reset()
        {
            SCL_Reset(_coroutine);
        }

        void recreate(Routine routine, void* param = 0, size_t stackSize = 0)
        {
            if (_coroutine)
                SCL_RecreateCoroutine(_coroutine, routine, param, stackSize);
            else
                _coroutine = SCL_CreateCoroutine(routine, param, stackSize);
        }

        bool valid() const
        {
            return _coroutine != 0;
        }

        void clear()
        {
            if (_coroutine)
                SCL_DestroyCoroutine(_coroutine);
            _coroutine = 0;
        }

        SCL_Coroutine* rawPtr()
        {
            return _coroutine;
        }

        ~Coroutine()
        {
            if (_coroutine)
                SCL_DestroyCoroutine(_coroutine);
        }

    private:
        Coroutine(const Coroutine& rhs) {}
        Coroutine& operator=(const Coroutine& rhs) { return *this; }

        SCL_Coroutine*   _coroutine;
    };
}

#endif
