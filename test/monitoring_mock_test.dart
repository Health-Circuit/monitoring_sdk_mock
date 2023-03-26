import 'package:flutter_test/flutter_test.dart';
import 'package:monitoring_mock/monitoring_mock.dart';
import 'package:monitoring_mock/monitoring_mock_platform_interface.dart';
import 'package:monitoring_mock/monitoring_mock_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockMonitoringMockPlatform
    with MockPlatformInterfaceMixin
    implements MonitoringMockPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final MonitoringMockPlatform initialPlatform = MonitoringMockPlatform.instance;

  test('$MethodChannelMonitoringMock is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelMonitoringMock>());
  });

  test('getPlatformVersion', () async {
    MonitoringMock monitoringMockPlugin = MonitoringMock();
    MockMonitoringMockPlatform fakePlatform = MockMonitoringMockPlatform();
    MonitoringMockPlatform.instance = fakePlatform;

    expect(await monitoringMockPlugin.getPlatformVersion(), '42');
  });
}
