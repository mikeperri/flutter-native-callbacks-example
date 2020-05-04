//
//  CallbackManager.cpp
//  native_callbacks_example
//
//  Created by M on 5/1/20.
//

#include <stdlib.h>
#include "CallbackManager.h"

Dart_PostCObjectType dartPostCObject = NULL;

void RegisterDart_PostCObject(Dart_PostCObjectType _dartPostCObject) {
    dartPostCObject = _dartPostCObject;
}

void callbackToDartInt32(Dart_Port callbackPort, int32_t value) {
    Dart_CObject dart_object;
    dart_object.type = Dart_CObject_kInt32;
    dart_object.value.as_int32 = value;
    
    bool result = dartPostCObject(callbackPort, &dart_object);
    if (!result) {
        printf("call from native to Dart failed, result was: %d\n", result);
    }
}

void callbackToDartStrArray(Dart_Port callbackPort, int length, char** values) {
    Dart_CObject **valueObjects = new Dart_CObject *[length];
    int i;
    for (i = 0; i < length; i++) {
        Dart_CObject *valueObject = new Dart_CObject;
        valueObject->type = Dart_CObject_kString;
        valueObject->value.as_string = values[i];
        
        valueObjects[i] = valueObject;
    }
    
    Dart_CObject dart_object;
    dart_object.type = Dart_CObject_kArray;
    dart_object.value.as_array.length = length;
    dart_object.value.as_array.values = valueObjects;
    
    bool result = dartPostCObject(callbackPort, &dart_object);
    if (!result) {
        printf("call from native to Dart failed, result was: %d\n", result);
    }

    for (i = 0; i < length; i++) {
        delete valueObjects[i];
    }
    delete[] valueObjects;
}
