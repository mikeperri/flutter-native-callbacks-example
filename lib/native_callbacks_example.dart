import 'dart:async';
import 'dart:ffi';
import 'dart:io';
import 'package:isolate/ports.dart';

final DynamicLibrary nativeLib = Platform.isAndroid
  ? DynamicLibrary.open('libandroid_native_callbacks_example.so')
  : DynamicLibrary.executable();

final nRegisterPostCObject = nativeLib.lookupFunction<
  Void Function(
    Pointer<NativeFunction<Int8 Function(Int64, Pointer<Dart_CObject>)>>
      functionPointer),
  void Function(
    Pointer<NativeFunction<Int8 Function(Int64, Pointer<Dart_CObject>)>>
      functionPointer)>('RegisterDart_PostCObject');

final nMethodA = nativeLib
  .lookupFunction<Void Function(Int64), void Function(int)>('method_a');

final nMethodB = nativeLib
  .lookupFunction<Void Function(Int64), void Function(int)>('method_b');

class NativeCallbacksExample {
  // Must be called once, before any other method
  static void doSetup() {
    nRegisterPostCObject(NativeApi.postCObject);
  }

  static Future<int> methodA() async {
    return singleResponseFuture((port) => nMethodA(port.nativePort));
  }

  static Future<List<String>> methodB() async {
    final future = singleResponseFuture<List<dynamic>>((port) => nMethodB(port.nativePort));
    return future.then((List<dynamic> list) {
      return list.cast<String>();
    });
  }
}
