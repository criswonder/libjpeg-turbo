# Set these variables to suit your needs
NDK_PATH=/Users/hongyun/source/cpp/ffmpeg/android-ndk-r14b
TOOLCHAIN=gcc
ANDROID_VERSION=21
MY_SOURCE_DIR=$(pwd)

rm -rf build
mkdir build
cd build
cmake -G"Unix Makefiles" \
  -DANDROID_ABI=armv7-a \
  -DANDROID_PLATFORM=android-${ANDROID_VERSION} \
  -DANDROID_TOOLCHAIN=${TOOLCHAIN} \
  -DCMAKE_TOOLCHAIN_FILE=${NDK_PATH}/build/cmake/android.toolchain.cmake \
  ${MY_SOURCE_DIR}

make clean
make 
make install