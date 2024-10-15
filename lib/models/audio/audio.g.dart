// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'audio.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AudioAdapter extends TypeAdapter<Audio> {
  @override
  final int typeId = 5;

  @override
  Audio read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Audio(
      id: fields[0] as String,
      title: fields[1] as String,
      audioUrl: fields[2] as String,
      description: fields[3] as String,
      index: fields[4] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Audio obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.audioUrl)
      ..writeByte(3)
      ..write(obj.description)
      ..writeByte(4)
      ..write(obj.index);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AudioAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
