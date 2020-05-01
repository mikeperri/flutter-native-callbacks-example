import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:native_callbacks_example/native_callbacks_example.dart';

void main() {
  const MethodChannel channel = MethodChannel('native_callbacks_example');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await NativeCallbacksExample.platformVersion, '42');
  });
}
