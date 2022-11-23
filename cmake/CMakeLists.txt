add_library(protobuf STATIC IMPORTED)
set_target_properties(protobuf PROPERTIES IMPORTED_LOCATION ${SRC_PATH}/protobuf/lib/${ANDROID_ABI}/libprotobuf.a)

# Deps extra
include(libpng.cmake)
include(libz.cmake)
include(libexpat.cmake)

# Deps
include(libbase.cmake)
include(libcutils.cmake)
include(libutils.cmake)
include(liblog.cmake)
include(libziparchive.cmake)
include(libandroidfw.cmake)
include(libincfs.cmake)

# Tools
include(aapt.cmake)
include(aapt2.cmake)
include(aidl.cmake)
include(zipalign.cmake)
