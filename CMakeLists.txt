cmake_minimum_required(VERSION 3.0)
project(SCL)

set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)

set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -fcolor-diagnostics")

include_directories(include)
enable_language(ASM)
file(GLOB_RECURSE SRC "src/*.c" "src/*.S")
message(STATUS "${SRC}")
add_library(scl SHARED ${SRC})
add_library(scl-static STATIC ${SRC})

add_executable(example example/main.c)
target_link_libraries(example scl)
