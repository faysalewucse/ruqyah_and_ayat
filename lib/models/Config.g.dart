// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Config.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ConfigAdapter extends TypeAdapter<Config> {
  @override
  final int typeId = 3;

  @override
  Config read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Config(
      appVersion: fields[0] as String,
      releaseNotes: fields[1] as String,
      dataVersion: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Config obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.appVersion)
      ..writeByte(1)
      ..write(obj.releaseNotes)
      ..writeByte(2)
      ..write(obj.dataVersion);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ConfigAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
