cmake_minimum_required(VERSION 3.6)

set (CALLBACK_MANAGER_DIR ../ios/Classes/Shared)

add_library(
    android_native_callbacks_example
    SHARED
    ${CALLBACK_MANAGER_DIR}/CallbackManager.h
    ${CALLBACK_MANAGER_DIR}/CallbackManager.cpp
    ./src/main/cpp/native_callbacks_example.cpp)

target_include_directories(android_native_callbacks_example PUBLIC ${CALLBACK_MANAGER_DIR})

find_library( # Sets the name of the path variable.
          android-lib

          # Specifies the name of the NDK library that
          # you want CMake to locate.
          android )

target_link_libraries(android_native_callbacks_example log)
target_link_libraries(android_native_callbacks_example ${android-lib})
