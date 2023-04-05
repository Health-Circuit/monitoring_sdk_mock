import 'dart:math';

import 'package:hive_flutter/adapters.dart';
import 'package:monitoring_mock/paired_devices.dart';
import 'package:uuid/uuid.dart';

import 'monitoring_mock_platform_interface.dart';

class MonitoringMock {
  List<Map<String, dynamic>> pairedDevices = [];
  List<Map<String, dynamic>> discoveredDevices = [];
  List<Map<String, dynamic>> pairedData = [];
  final random = Random();
  final deviceTypes = [
    'BEAT_ONE',
  ];
  final names = [
    'BeatOne 1',
    'BeatOne 2',
    'BeatOne 3',
  ];
  final variables = [
    'hr',
    'steps',
    'sleep',
  ];

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

  Future<void> pair(
      String deviceType, List<String> variables, String deviceId) async {
    var result =
        discoveredDevices.firstWhere((element) => element['uuid'] == deviceId);
    final lastSynchronization = DateTime.now().millisecondsSinceEpoch;
    pairedDevices.add({
      "device": result,
      "variables": variables
          .map((variable) =>
              {"name": variable, "lastSynchronization": lastSynchronization})
          .toList(),
    });
    discoveredDevices.remove(result);
  }

  Future<List<Map<String, dynamic>>> getPairedDevices() async {
    if (pairedDevices.isNotEmpty) {
      return pairedDevices;
    }
    final jsonList = <Map<String, dynamic>>[];
    for (var i = 0; i < 1; i++) {
      final deviceType = deviceTypes[random.nextInt(deviceTypes.length)];
      final uuid = random.nextInt(100000).toString();
      final name = names[random.nextInt(names.length)];
      final variableList = <Map<String, dynamic>>[];
      for (var j = 0; j < variables.length; j++) {
        final variableName = variables[j];
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
    pairedDevices = jsonList;
    return jsonList;
  }

  Future<List<Map<String, dynamic>>> discover(String deviceType) async {
    final jsonList = <Map<String, dynamic>>[];
    for (var i = 0; i < 4; i++) {
      final deviceType = deviceTypes[random.nextInt(deviceTypes.length)];
      final uuid = random.nextInt(100000).toString();
      final name = names[random.nextInt(names.length)];
      jsonList.add({
        'deviceType': deviceType,
        'uuid': uuid,
        'name': name,
      });
    }
    await Future.delayed(const Duration(seconds: 1));
    discoveredDevices = jsonList;
    return jsonList;
  }

  Future<void> synchronize() async {
    final data = <Map<String, dynamic>>[];
    for (Map<String, dynamic> device in pairedDevices) {
      for (Map<String, dynamic> variable in device['variables']) {
        data.add({
          "device": {
            "deviceType": device['device']['deviceType'],
            "uuid": device['device']['uuid'],
            "name": device['device']['name'],
          },
          "timestamp": variable['lastSynchronization'],
          "type": variable['name'],
          "value": random.nextInt(10000),
          "value2": ""
        });
      }
    }
    await Future.delayed(const Duration(seconds: 1));
    pairedData = data;
  }

  Future<List<Map<String, dynamic>>> query(
      String variable, int? from, int? to) async {
    await Future.delayed(const Duration(seconds: 1));
    return pairedData
        .where((element) => element['device']['deviceType'] == variable
            //&&(from == null || element['timestamp'] >= from) &&
            //(to == null || element['timestamp'] <= to)
            )
        .toList();
  }
}
