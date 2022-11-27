#!/com/termux/files/usr/bin/bash

if [[ -z "${NDK_PATH}" ]]; then
    echo "Please specify the Android NDK environment variable \"NDK_PATH\"."
    exit 1
fi

NDK_TOOLCHAIN="${NDK_PATH}/toolchains/llvm/prebuilt/linux-x86_64"
NDK_TOOLCHAIN_FILE="${NDK_PATH}/build/cmake/android.toolchain.cmake"

root="$(pwd)"
api="24"
stl="c++_static"

declare -a abis=("arm64-v8a" "armeabi-v7a" "x86_64" "x86")
for i in ${!abis[@]}; do
abi="${abis[$i]}"
build_dir="build"
binary_dir="$root/$build_dir/cmake"
out_dir="$root/output/$abi"

rm -rf ${build_dir} || exit 1

cmake -GNinja \
    -B "${build_dir}" \
    -DANDROID_NDK=${NDK_PATH} \
    -DCMAKE_TOOLCHAIN_FILE=${NDK_TOOLCHAIN_FILE} \
    -DANDROID_PLATFORM="android-$api" \
    -DCMAKE_ANDROID_ARCH_ABI="$abi" \
    -DANDROID_ABI="$abi" \
    -DCMAKE_SYSTEM_NAME="Android" \
    -DCMAKE_BUILD_TYPE="Release" \
    -DANDROID_STL="$stl" \
    || exit 1
    
ninja -C ${build_dir} -j8 || exit 1

"$NDK_TOOLCHAIN/bin/llvm-strip" --strip-all "$binary_dir/aapt"
"$NDK_TOOLCHAIN/bin/llvm-strip" --strip-all "$binary_dir/aapt2"
"$NDK_TOOLCHAIN/bin/llvm-strip" --strip-all "$binary_dir/aidl"
"$NDK_TOOLCHAIN/bin/llvm-strip" --strip-all "$binary_dir/zipalign"

termux-elf-cleaner --api-level "$api" "$binary_dir/aapt"
termux-elf-cleaner --api-level "$api" "$binary_dir/aapt2"
termux-elf-cleaner --api-level "$api" "$binary_dir/aidl"
termux-elf-cleaner --api-level "$api" "$binary_dir/zipalign"

mkdir -p "$out_dir"
mv "$binary_dir/aapt" "$out_dir"
mv "$binary_dir/aapt2" "$out_dir"
mv "$binary_dir/aidl" "$out_dir"
mv "$binary_dir/zipalign" "$out_dir"
done
