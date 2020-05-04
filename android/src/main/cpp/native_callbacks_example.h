//
// Created by M on 5/2/20.
//

#ifndef NATIVE_CALLBACKS_EXAMPLE_NATIVE_CALLBACKS_EXAMPLE_H
#define NATIVE_CALLBACKS_EXAMPLE_NATIVE_CALLBACKS_EXAMPLE_H
#include <CallbackManager.h>

#ifdef __cplusplus
extern "C" {
#endif
    void method_a(Dart_Port callbackPort);
    void method_b(Dart_Port callbackPort);
#ifdef __cplusplus
}
#endif
#endif //NATIVE_CALLBACKS_EXAMPLE_NATIVE_CALLBACKS_EXAMPLE_H
