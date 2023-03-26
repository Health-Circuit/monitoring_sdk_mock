import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'monitoring_mock_method_channel.dart';

abstract class MonitoringMockPlatform extends PlatformInterface {
  /// Constructs a MonitoringMockPlatform.
  MonitoringMockPlatform() : super(token: _token);

  static final Object _token = Object();

  static MonitoringMockPlatform _instance = MethodChannelMonitoringMock();

  /// The default instance of [MonitoringMockPlatform] to use.
  ///
  /// Defaults to [MethodChannelMonitoringMock].
  static MonitoringMockPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [MonitoringMockPlatform] when
  /// they register themselves.
  static set instance(MonitoringMockPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<int> getDeviceBattery(String deviceId) {
    throw UnimplementedError('getDeviceBattery() has not been implemented.');
  }
}
