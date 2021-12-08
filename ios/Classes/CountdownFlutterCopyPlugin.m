#import "CountdownFlutterCopyPlugin.h"
#if __has_include(<countdown_flutter_copy/countdown_flutter_copy-Swift.h>)
#import <countdown_flutter_copy/countdown_flutter_copy-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "countdown_flutter_copy-Swift.h"
#endif

@implementation CountdownFlutterCopyPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftCountdownFlutterCopyPlugin registerWithRegistrar:registrar];
}
@end
