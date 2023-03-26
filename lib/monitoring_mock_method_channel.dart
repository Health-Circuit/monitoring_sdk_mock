import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'monitoring_mock_platform_interface.dart';

/// An implementation of [MonitoringMockPlatform] that uses method channels.
class MethodChannelMonitoringMock extends MonitoringMockPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('monitoring_mock');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  /// getDeviceBattery, Battery level of the paired device identified by deviceId
  /// in the mockup this will be the mobile phone battery level
  @override
  Future<int> getDeviceBattery(String deviceId) async {
    final int deviceBattery = await methodChannel.invokeMethod('getDeviceBattery', deviceId);
    return deviceBattery ;
  }

}
