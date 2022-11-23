add_library(libz STATIC
    ${SRC_PATH}/zlib/adler32.c
    ${SRC_PATH}/zlib/compress.c
    ${SRC_PATH}/zlib/cpu_features.c
    ${SRC_PATH}/zlib/crc32.c
    ${SRC_PATH}/zlib/deflate.c
    ${SRC_PATH}/zlib/gzclose.c
    ${SRC_PATH}/zlib/gzlib.c
    ${SRC_PATH}/zlib/gzread.c
    ${SRC_PATH}/zlib/gzwrite.c
    ${SRC_PATH}/zlib/infback.c
    ${SRC_PATH}/zlib/inffast.c
    ${SRC_PATH}/zlib/inflate.c
    ${SRC_PATH}/zlib/inftrees.c
    ${SRC_PATH}/zlib/trees.c
    ${SRC_PATH}/zlib/uncompr.c
    ${SRC_PATH}/zlib/zutil.c)

target_compile_definitions(libz PRIVATE
    -DHAVE_HIDDEN
    -DZLIB_CONST)
    
target_include_directories(libz PRIVATE ${SRC_PATH}/zlib)
