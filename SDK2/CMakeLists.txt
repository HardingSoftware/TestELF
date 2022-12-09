cmake_minimum_required(VERSION 3.6.0 FATAL_ERROR)

project(SDK2)

#----------------------------------------------------------------------------------------
# Get the architecture for Android build
function(GetAndroidArchitecture ABI ARCH)
    if(ABI STREQUAL armeabi-v7a)
        set(${ARCH} arm PARENT_SCOPE)
    elseif(ABI STREQUAL arm64-v8a)
        set(${ARCH} aarch64 PARENT_SCOPE)
    elseif(ABI STREQUAL x86)
        set(${ARCH} i686 PARENT_SCOPE)
    elseif(ABI STREQUAL x86_64)
        set(${ARCH} x86_64 PARENT_SCOPE)
    else()
        message(FATAL_ERROR "Unsupported ABI")
    endif()
endfunction()

if(CMAKE_BUILD_TYPE STREQUAL "Debug" AND NOT BUILD_WITHOUT_ASAN)
    # Enable address sanitizer on GCC/clang
    add_compile_options(-fsanitize=address -fno-omit-frame-pointer)
    set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -fsanitize=address")
    set(CMAKE_MODULE_LINKER_FLAGS "${CMAKE_MODULE_LINKER_FLAGS} -fsanitize=address")
    set(CMAKE_SHARED_LINKER_FLAGS "${CMAKE_SHARED_LINKER_FLAGS} -fsanitize=address")

    if(CMAKE_GENERATOR MATCHES Xcode)
        # Also enable address sanitizer in Xcode scheme
        if(${CMAKE_VERSION} VERSION_GREATER "3.13.0")
            # CMake version > 3.13 is REQUIRED for supporting Xcode scheme
            set(CMAKE_XCODE_GENERATE_SCHEME ON)
            set(CMAKE_XCODE_SCHEME_ADDRESS_SANITIZER ON)
            set(CMAKE_XCODE_SCHEME_ADDRESS_SANITIZER_USE_AFTER_RETURN ON)
        endif()
    elseif(ANDROID)
        # Reference: https://developer.android.com/ndk/guides/asan

        if(ANDROID_STL STREQUAL "c++_shared")
            message(WARNING "Better use c++_shared for address sanitizer")
        endif()

        GetAndroidArchitecture(${ANDROID_ABI} ANDROID_ARCH)

        # e.g., ${ANDROID_TOOLCHAIN_ROOT}/libclang_rt.asan-aarch64-android.so
        file(GLOB_RECURSE ANDROID_ASAN_SO
            ${ANDROID_TOOLCHAIN_ROOT}/*.asan*${ANDROID_ARCH}*-android.so)

        # We MUST also link with AndroidASanLib in order to enable address sanitizer
        if(ANDROID_ASAN_SO)
            add_library(AndroidASanLib SHARED IMPORTED)
            set_property(TARGET
                AndroidASanLib PROPERTY IMPORTED_LOCATION ${ANDROID_ASAN_SO})
        endif()
    endif()
endif()

add_library(SDK2 SHARED libSDK2.cpp)