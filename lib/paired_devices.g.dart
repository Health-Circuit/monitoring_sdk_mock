// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paired_devices.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PairedDeviceAdapter extends TypeAdapter<PairedDevice> {
  @override
  final int typeId = 1;

  @override
  PairedDevice read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PairedDevice(
      uuid: fields[0] as Uuid?,
      deviceType: fields[1] as String?,
      name: fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, PairedDevice obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.uuid)
      ..writeByte(1)
      ..write(obj.deviceType)
      ..writeByte(2)
      ..write(obj.name);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PairedDeviceAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
