import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'paired_devices.g.dart';

@HiveType(typeId: 1)
class PairedDevice {
  PairedDevice({this.uuid, this.deviceType, this.name});
  PairedDevice.m(this.uuid, this.deviceType, this.name);
  @HiveField(0)
  Uuid? uuid;

  @HiveField(1)
  String? deviceType;

  @HiveField(2)
  String? name;
}