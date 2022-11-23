cmake_minimum_required(VERSION 3.14.2)
project(aapt)

# Enable asm
if(ANDROID_ABI STREQUAL "arm64-v8a" OR ANDROID_ABI STREQUAL "armeabi-v7a")
    enable_language(ASM)
elseif(ANDROID_ABI STREQUAL "x86_64" OR ANDROID_ABI STREQUAL "x86")
    enable_language(ASM_NASM)
else()
    message(FATAL_ERROR "Unsupported architecture: ${ANDROID_ABI}")
endif()

# Set global flags
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -fcolor-diagnostics -fPIC -std=c11")
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fcolor-diagnostics -fPIC -std=c++20")

# Disable warnings
add_compile_options(-Wno-attributes)

# Tools and version
set(SRC_PATH ${PROJECT_SOURCE_DIR}/src)
set(TOOLS_VERSION "33.0.3")
set(PROTOC_COMPILER "tools/protoc")

# Building
add_subdirectory(src/zopfli EXCLUDE_FROM_ALL)
add_subdirectory(src/fmtlib EXCLUDE_FROM_ALL)
add_subdirectory(src/googletest EXCLUDE_FROM_ALL)
add_subdirectory(cmake)
