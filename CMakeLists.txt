cmake_minimum_required(VERSION 3.0)
project(SCL)

set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)

enable_language(ASM)
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -fcolor-diagnostics")

if (CMAKE_SIZEOF_VOID_P EQUAL 8)
    set(SCL_BITS 64)
else()
    set(SCL_BITS 32)
endif()

if (SCL_BITS EQUAL 64)
    set(SCL_ARCH x86_64)
else()
    set(SCL_ARCH x86)
    set(CMAKE_ASM_FLAGS "${CMAKE_ASM_FLAGS} -m32")
endif()

configure_file(include/conf.h.in "${CMAKE_BINARY_DIR}/include/SCL/conf.h")

include_directories(include)
include_directories("${CMAKE_BINARY_DIR}/include")

file(GLOB SRC "src/*.c")
file(GLOB ARCH_SRC "src/${SCL_ARCH}/systemV/*.S")
list(APPEND SRC ${ARCH_SRC})

add_library(SCL SHARED ${SRC})
add_library(SCL-static STATIC ${SRC})
set_target_properties(SCL-static PROPERTIES OUTPUT_NAME SCL)

add_executable(example example/main.cpp)
target_link_libraries(example SCL)

install(TARGETS SCL SCL-static DESTINATION lib)
install(DIRECTORY include/SCL DESTINATION include)
install(FILES "${CMAKE_BINARY_DIR}/include/SCL/conf.h" DESTINATION include/SCL)
