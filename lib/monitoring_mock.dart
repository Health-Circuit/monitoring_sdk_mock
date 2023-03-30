import 'package:hive_flutter/adapters.dart';
import 'package:monitoring_mock/paired_devices.dart';
import 'package:uuid/uuid.dart';

import 'monitoring_mock_platform_interface.dart';

class MonitoringMock {
  Future<void> initPlugin() async {
    await Hive.initFlutter();
    await Hive.openBox("pairedDevicesBox");

    Hive.registerAdapter(PairedDeviceAdapter());
  }

  Future<String?> getPlatformVersion() {
    return MonitoringMockPlatform.instance.getPlatformVersion();
  }

  Future<List<PairedDevice>> getPairedDevices() async {
    var box = Hive.box("pairedDevicesBox");
    final items = box.values;
    final List<PairedDevice> pairedDevices = items.toList().map((dynamic item) {
      final List<dynamic> fields = item as List<dynamic>;
      return PairedDevice.m(
          fields[0] as Uuid, fields[1] as String, fields[2] as String);
    }).toList();
    return pairedDevices;
  }

  Future<int> getDeviceBattery(String deviceId) {
    return MonitoringMockPlatform.instance.getDeviceBattery(deviceId);
  }
}
