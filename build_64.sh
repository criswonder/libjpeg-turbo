#!/bin/bash
#ndk所在目录
# NDK_PATH=/Users/hongyun/source/cpp/ffmpeg/android-ndk-r17c
# NDK_PATH=/Users/hongyun/source/cpp/ffmpeg/android-ndk-r14b
NDK_PATH=/Users/hongyun/source/cpp/ffmpeg/android-ndk-r16b
ASM_NASM=/usr/local/bin/nasm
#编译环境这里是 macOS
BUILD_PLATFORM=darwin-x86_64
#编译工具链版本
TOOLCHAIN_VERSION=4.9
#最低兼容
ANDROID_VERSION=21
 
#添加cmake环境变量 这里是android sdk中的
export PATH="$ANDROID_HOME/cmake/3.10.2.4988404/bin":"$PATH"
#源码目录 这里是当前脚本所在目录
MY_SOURCE_DIR=$(pwd)
# 生成目标文件目录
PREFIX=$(pwd)/android
 # 目标平台
HOST=aarch64-linux-android
SYSROOT=${NDK_PATH}/platforms/android-${ANDROID_VERSION}/arch-arm64
# armera-v7平台
export CFLAGS="-D__ANDROID_API__=${ANDROID_VERSION} --sysroot=${SYSROOT} \
  -isystem ${NDK_PATH}/sysroot/usr/include \
  -isystem ${NDK_PATH}/sysroot/usr/include/${HOST}"
export LDFLAGS=-pie
TOOLCHAIN=${NDK_PATH}/toolchains/${HOST}-${TOOLCHAIN_VERSION}/prebuilt/${BUILD_PLATFORM}
 
cat <<EOF >toolchain.cmake
set(CMAKE_SYSTEM_NAME Linux)
set(CMAKE_SYSTEM_PROCESSOR arm)
set(CMAKE_C_COMPILER ${TOOLCHAIN}/bin/${HOST}-gcc)
set(CMAKE_FIND_ROOT_PATH ${TOOLCHAIN}/${HOST})
set(CMAKE_ASM_NASM_COMPILER ${NDK_PATH})
EOF
 
cmake -G"Unix Makefiles" -DCMAKE_TOOLCHAIN_FILE=toolchain.cmake \
    -DCMAKE_POSITION_INDEPENDENT_CODE=1 \
    -DCMAKE_INSTALL_PREFIX=${PREFIX} \
    ${MY_SOURCE_DIR}

make clean
make
make install