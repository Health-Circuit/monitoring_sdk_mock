import 'dart:math';

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

  Future<List<PairedDevice>> getPairedDevices2() async {
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

  Future<List<Map<String, dynamic>>> getPairedDevices() async {
    final random = Random();
    final deviceTypes = [
      'smartwatch',
      'AppleHealthKit',
      'GoogleFit',
      'BeatOne',
    ];
    final names = [
      'BeatOne 1',
      'BeatOne 2',
      'BeatOne 3',
      'GoogleFit 1',
      'GoogleFit 2',
      'GoogleFit 5',
      'AppleHealthKit 7',
      'AppleHealthKit 3',
      'AppleHealthKit 6',
    ];
    final variables = [
      'hr',
      'steps',
      'calories',
      'distance',
      'sleep time',
      'sleep quality',
      'blood pressure',
      'oxygen saturation',
    ];
    final jsonList = <Map<String, dynamic>>[];
    for (var i = 0; i < 5; i++) {
      final deviceType = deviceTypes[random.nextInt(deviceTypes.length)];
      final uuid = random.nextInt(100000).toString();
      final name = names[random.nextInt(names.length)];
      final variableList = <Map<String, dynamic>>[];
      for (var j = 0; j < 3; j++) {
        final variableName = variables[random.nextInt(variables.length)];
        final lastSynchronization = DateTime.now().millisecondsSinceEpoch;
        variableList.add({
          'name': variableName,
          'lastSynchronization': lastSynchronization,
        });
      }
      jsonList.add({
        'device': {
          'deviceType': deviceType,
          'uuid': uuid,
          'name': name,
        },
        'variables': variableList,
      });
    }
    await Future.delayed(const Duration(seconds: 1));
    return jsonList;
  }
}
