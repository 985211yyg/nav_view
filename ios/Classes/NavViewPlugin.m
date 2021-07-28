#import "NavViewPlugin.h"
#import <AMapFoundationKit/AMapFoundationKit.h>
#if __has_include(<nav_view/nav_view-Swift.h>)
#import <nav_view/nav_view-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "nav_view-Swift.h"
#endif

@implementation NavViewPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
    [AMapServices sharedServices].apiKey = @"99c8c6e43433f2d24e0874cb514d93e7";
    [SwiftFlutterMapPlugin registerWithRegistrar:registrar];
}
@end
