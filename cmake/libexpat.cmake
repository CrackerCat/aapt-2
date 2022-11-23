add_library(libexpat STATIC
    ${SRC_PATH}/expat/lib/xmlparse.c
    ${SRC_PATH}/expat/lib/xmlrole.c
    ${SRC_PATH}/expat/lib/xmltok.c)

target_compile_options(libexpat PRIVATE
    -fno-strict-aliasing
    -include stdio.h)
    
target_compile_definitions(libexpat PRIVATE
    -DHAVE_EXPAT_CONFIG_H)
    
target_include_directories(libexpat PRIVATE
    ${SRC_PATH}/expat/lib
    ${SRC_PATH}/expat)
