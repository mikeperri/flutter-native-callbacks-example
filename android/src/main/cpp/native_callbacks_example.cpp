//
// Created by M on 5/2/20.
//

#include "native_callbacks_example.h"
#include <memory>
#include <thread>
#include <chrono>
#include <iostream>
#include <android/log.h>
#include <CallbackManager.h>


void method_a(Dart_Port callbackPort) {
    __android_log_print(ANDROID_LOG_INFO, "NATIVE_CALLBACKS_EXAMPLE", "Started method A");

    std::thread t([=]() {
        std::this_thread::sleep_for(std::chrono::seconds(1));

        int32_t value = 123;

        callbackToDartInt32(callbackPort, value);
        __android_log_print(ANDROID_LOG_INFO, "NATIVE_CALLBACKS_EXAMPLE", "Finished method A");
    });

    t.detach();
};

void method_b(Dart_Port callbackPort) {
    __android_log_print(ANDROID_LOG_INFO, "NATIVE_CALLBACKS_EXAMPLE", "Started method B");

    std::thread t([=](){
        std::this_thread::sleep_for(std::chrono::seconds(2));

        const int length = 2;
        char** values = new char* [length];

        values[0] = "abc";
        values[1] = "def";

        callbackToDartStrArray(callbackPort, length, values);

        delete []values;
        __android_log_print(ANDROID_LOG_INFO, "NATIVE_CALLBACKS_EXAMPLE", "Finished method B");
    });

    t.detach();
};
