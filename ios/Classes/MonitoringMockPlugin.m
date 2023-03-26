#import "MonitoringMockPlugin.h"

@implementation MonitoringMockPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:@"monitoring_mock"
            binaryMessenger:[registrar messenger]];
  MonitoringMockPlugin* instance = [[MonitoringMockPlugin alloc] init];
  [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
  if ([@"getPlatformVersion" isEqualToString:call.method]) {
    result([@"iOS " stringByAppendingString:[[UIDevice currentDevice] systemVersion]]);
  } else if ([@"getDeviceBattery" isEqualToString:call.method]) {
    result(@(80));
  }
  else {
    result(FlutterMethodNotImplemented);
  }
}

@end
