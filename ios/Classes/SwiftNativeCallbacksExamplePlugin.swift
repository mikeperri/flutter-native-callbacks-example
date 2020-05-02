import Flutter
import UIKit

public class SwiftNativeCallbacksExamplePlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "native_callbacks_example", binaryMessenger: registrar.messenger())
    let instance = SwiftNativeCallbacksExamplePlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    result("iOS " + UIDevice.current.systemVersion)
  }
}

func swiftCallbackToDartStrArray(callbackPort: Dart_Port, values: [String]) -> Void {
    withArrayOfCStrings(values) { (cStrings: [UnsafeMutablePointer<CChar>?]) in
        var cStringsVariable = cStrings
        
        callbackToDartStrArray(
           callbackPort,
           Int32(values.count),
           &cStringsVariable
        )
    }
}

@_cdecl("method_a")
func methodA(callbackPort: Dart_Port) {
    print("Started method A")
    let number = Int32(123)

    DispatchQueue.global(qos: .background).asyncAfter(deadline: .now() + 1) {
        callbackToDartInt32(
            callbackPort,
            number
        )
        print("Finished method A")
    }
}

@_cdecl("method_b")
func methodB(callbackPort: Dart_Port) {
    print("Started method B")
    let strings = ["abc", "def"]

    DispatchQueue.global(qos: .background).asyncAfter(deadline: .now() + 2) {
        swiftCallbackToDartStrArray(
            callbackPort: callbackPort,
            values: strings
        )
        print("Finished method B")
    }
}
