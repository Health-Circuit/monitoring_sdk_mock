
import 'monitoring_mock_platform_interface.dart';

class MonitoringMock {
  Future<String?> getPlatformVersion() {
    return MonitoringMockPlatform.instance.getPlatformVersion();
  }

  Future<int> getDeviceBattery(String deviceId) {
    return MonitoringMockPlatform.instance.getDeviceBattery(deviceId);
  }
}
