#import "FlutterBarometerPlugin.h"
#if __has_include(<flutter_barometer/flutter_barometer-Swift.h>)
#import <flutter_barometer/flutter_barometer-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "flutter_barometer-Swift.h"
#endif

@implementation FlutterBarometerPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFlutterBarometerPlugin registerWithRegistrar:registrar];
}
@end
