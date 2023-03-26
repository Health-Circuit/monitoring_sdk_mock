import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:monitoring_mock/monitoring_mock_method_channel.dart';

void main() {
  MethodChannelMonitoringMock platform = MethodChannelMonitoringMock();
  const MethodChannel channel = MethodChannel('monitoring_mock');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}
