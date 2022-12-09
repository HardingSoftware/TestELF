
ScriptPath=$(cd "$(dirname "$0")";pwd)

BUILD_TYPE=Debug
BUILD_DIR=build-android-${BUILD_TYPE}

CMAKE_ARGS_COMMON="-DCMAKE_BUILD_TYPE=$BUILD_TYPE -DCMAKE_CONFIGURATION_TYPES=$BUILD_TYPE" 
# CMAKE_ARGS_COMMON="${CMAKE_ARGS_COMMON} -G Unix Makefiles" 
CMAKE_ARGS_COMMON="${CMAKE_ARGS_COMMON}    \
    -DCMAKE_ANDROID_NDK_TOOLCHAIN_VERSION=clang \
    -DANDROID_ABI="arm64-v8a" \
    -DANDROID_ARM_NEON=ON \
    -DANDROID_TOOLCHAIN=clang "

ANDROID_NDK=/Users/harding/MyLibrary/android-ndk-r20b
CMAKE_ARGS_SDK1="${CMAKE_ARGS_COMMON}    \
    -DCMAKE_TOOLCHAIN_FILE=$ANDROID_NDK/build/cmake/android.toolchain.cmake \
    -DANDROID_STL=c++_static \
    -DANDROID_PLATFORM=android-19 \
    -DANDROID_NDK=$ANDROID_NDK"

ANDROID_NDK=/Users/harding/MyLibrary/android-ndk-r21b
CMAKE_ARGS_SDK2="${CMAKE_ARGS_COMMON}    \
    -DCMAKE_TOOLCHAIN_FILE=$ANDROID_NDK/build/cmake/android.toolchain.cmake \
    -DANDROID_STL=c++_shared \
    -DANDROID_PLATFORM=android-21 \
    -DANDROID_NDK=$ANDROID_NDK"

ANDROID_NDK=/Users/harding/MyLibrary/android-ndk-r16b
CMAKE_ARGS_APP="${CMAKE_ARGS_COMMON}    \
    -DCMAKE_TOOLCHAIN_FILE=$ANDROID_NDK/build/cmake/android.toolchain.cmake \
    -DANDROID_STL=c++_shared \
    -DANDROID_PLATFORM=android-23 \
    -DANDROID_NDK=$ANDROID_NDK"

# SDK1

cd ${ScriptPath}/SDK1

mkdir -p ${BUILD_DIR}
cd ${BUILD_DIR}

cmake .. ${CMAKE_ARGS_SDK1}
cmake --build . --target SDK1 -j 4

# SDK2

cd ${ScriptPath}/SDK2

mkdir -p ${BUILD_DIR}
cd ${BUILD_DIR}

cmake .. ${CMAKE_ARGS_SDK2}
cmake --build . --target SDK2 -j 4

# App

cp ${ScriptPath}/SDK1/libSDK1.h ${ScriptPath}/App/3rd 
cp ${ScriptPath}/SDK1/$BUILD_DIR/*SDK1* ${ScriptPath}/App/3rd 

cp ${ScriptPath}/SDK2/libSDK2.h ${ScriptPath}/App/3rd 
cp ${ScriptPath}/SDK2/$BUILD_DIR/*SDK2* ${ScriptPath}/App/3rd 

cd ${ScriptPath}/App

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