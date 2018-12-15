#import "EasygeolocationPlugin.h"
#import <easygeolocation/easygeolocation-Swift.h>

@implementation EasygeolocationPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftEasygeolocationPlugin registerWithRegistrar:registrar];
}
@end
