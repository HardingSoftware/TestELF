if [ -z "$ANDROID_NDK" ]; then
    # ANDROID_NDK should be set to: xxx/ndk-bundle, or xxx/android-ndk-r15c
    echo "Error: Environment variable ANDROID_NDK is not set"
    exit 1
fi

if [ -d "$ANDROID_NDK" ]; then
    echo "Using Android NDK at $ANDROID_NDK"
fi

ScriptPath=$(cd "$(dirname "$0")";pwd)

BUILD_TYPE=Debug
BUILD_DIR=build-android-${BUILD_TYPE}

CMAKE_ARGS_COMMON="-DCMAKE_BUILD_TYPE=$BUILD_TYPE -DCMAKE_CONFIGURATION_TYPES=$BUILD_TYPE" 
CMAKE_ARGS_COMMON="${CMAKE_ARGS_COMMON}    \
    -DCMAKE_ANDROID_NDK_TOOLCHAIN_VERSION=clang \
    -DCMAKE_VERBOSE_MAKEFILE=ON \
    -DANDROID_ABI="arm64-v8a" \
    -DANDROID_ARM_NEON=ON \
    -DBUILD_WITHOUT_ASAN=ON \
    -DANDROID_TOOLCHAIN=clang \ 
    -DCMAKE_TOOLCHAIN_FILE=$ANDROID_NDK/build/cmake/android.toolchain.cmake \
    -DANDROID_STL=c++_shared \
    -DANDROID_PLATFORM=android-23 \
    -DANDROID_NDK=$ANDROID_NDK"

mkdir -p ${BUILD_DIR}
cd ${BUILD_DIR}

cmake .. ${CMAKE_ARGS_APP}
cmake --build . --target TestELF -j 4

# Run

cd ${ScriptPath}/App
adb push ${BUILD_DIR}/TestELF /data/local/tmp
adb push 3rd/lib*.so /data/local/tmp

adb shell "cd /data/local/tmp && export LD_LIBRARY_PATH=. && ./TestELF"


# ./$BUILD_TYPE/TestELF