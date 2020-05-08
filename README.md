# native_callbacks_example

Example Flutter plugin that calls native code directly via FFI (no MethodChannels) and gets async callbacks.

As of May 2020, you need to be on the dev channel of Flutter for this to work.

## Why
The main motivation for this is to call directly into native NDK code on Android from Dart and get an async result. Also, on any platform, using FFI should involve less performance overhead.

For example, say you were building a music app, and it needs to call Swift on the iOS side and C++ on the Android side for real-time audio operations. You wouldn't want to use PlatformChannels because of the added latency, and also because on Android you don't need to go through the JVM.

## How

### Plugin
The Flutter plugin can be found at lib/native_callbacks_example.dart.

Before doing anything else, you need to call `NativeCallbacksExample.doSetup()`. This gives the native code a reference to Dart_PostCObject, which it will use to send data back to Dart ports.

It has two async methods:
- `NativeCallbacksExample.methodA()`, which returns a `Future<int>`
- `NativeCallbacksExample.methodB()`, which returns a `Future<List<String>>`

Internally, the Dart methods use `singleResponseFuture` from the `isolate` library to create a Dart port and pass it to the native side on each function call, then await the next message received by that port.

On Android, these methods will call the CPP files in /android/src/main/cpp/native_callbacks_example.cpp. (Note the changes in the C

On iOS, it will call the Swift file at /ios/Classes/SwiftNativeCallbacksExamplePlugin.swift.

For both platforms, the shared 'CallbackManager' is in /ios/Classes/Shared. It contains some C helpers to call Dart, and it holds the reference to Dart_PostCObject. (Note the line in the podspec file that adds a reference to these headers as USER_HEADER_SEARCH_PATHS.)

### Example app
The example app can be found at example/lib/main.dart.
