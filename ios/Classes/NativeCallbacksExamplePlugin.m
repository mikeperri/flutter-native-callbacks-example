#import "./Shared/CallbackManager.h"

#import "NativeCallbacksExamplePlugin.h"
#if __has_include(<native_callbacks_example/native_callbacks_example-Swift.h>)
#import <native_callbacks_example/native_callbacks_example-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "native_callbacks_example-Swift.h"
#endif

@implementation NativeCallbacksExamplePlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftNativeCallbacksExamplePlugin registerWithRegistrar:registrar];
}
@end
