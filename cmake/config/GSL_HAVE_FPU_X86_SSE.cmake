if (CMAKE_SYSTEM_NAME STREQUAL Linux)
    set(cpu ${CMAKE_SYSTEM_PROCESSOR})
    string(TOLOWER ${cpu} cpu)
    if (cpu MATCHES "(.*intel.*|.*amd.*|.*x64.*|.*x86.*|.*i.86)")
        check_c_source_compiles("
            #include <stdlib.h>
            #define _FPU_SETMXCSR(cw) asm volatile (\"ldmxcsr %0\" : : \"m\" (*&cw))
            int main() { unsigned int mode = 0x1f80 ; _FPU_SETMXCSR(mode); exit(0); }"
            GSL_HAVE_FPU_X86_SSE)
    endif ()
endif ()
