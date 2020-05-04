# native_callbacks_example

Example Flutter plugin that calls native code directly via FFI (no MethodChannels) and gets async callbacks.

As of May 2020, you need to be on the dev channel of Flutter for this to work.

## Why
The main motivation for this is to call directly into native NDK code on Android from Dart and get an async result. Also, on any platform, using FFI should involve less performance overhead.

For example, say you were building a music app, and it needs to call Swift on the iOS side and C++ on the Android side for real-time audio operations. You wouldn't want to use PlatformChannels because of the added latency, and also because on Android you don't need to go through the JVM.
