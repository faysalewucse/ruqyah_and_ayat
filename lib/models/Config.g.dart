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
      ayatDataVersion: fields[3] as String,
      categoryDataVersion: fields[4] as String,
      ruqyahDataVersion: fields[5] as String,
      hijamaDataVersion: fields[6] as String,
      nirapottarDataVersion: fields[7] as String,
      masnunDuaDataVersion: fields[8] as String,
      masnunDuaCategoryDataVersion: fields[9] as String,
      audioDataVersion: fields[10] as String,
      masayelDataVersion: fields[11] as String,
      bibidhDataVersion: fields[12] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Config obj) {
    writer
      ..writeByte(13)
      ..writeByte(0)
      ..write(obj.appVersion)
      ..writeByte(1)
      ..write(obj.releaseNotes)
      ..writeByte(2)
      ..write(obj.dataVersion)
      ..writeByte(3)
      ..write(obj.ayatDataVersion)
      ..writeByte(4)
      ..write(obj.categoryDataVersion)
      ..writeByte(5)
      ..write(obj.ruqyahDataVersion)
      ..writeByte(6)
      ..write(obj.hijamaDataVersion)
      ..writeByte(7)
      ..write(obj.nirapottarDataVersion)
      ..writeByte(8)
      ..write(obj.masnunDuaDataVersion)
      ..writeByte(9)
      ..write(obj.masnunDuaCategoryDataVersion)
      ..writeByte(10)
      ..write(obj.audioDataVersion)
      ..writeByte(11)
      ..write(obj.masayelDataVersion)
      ..writeByte(12)
      ..write(obj.bibidhDataVersion);
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
