// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'masnun_dua.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MasnunDuaAdapter extends TypeAdapter<MasnunDua> {
  @override
  final int typeId = 4;

  @override
  MasnunDua read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MasnunDua(
      id: fields[0] as String,
      category: fields[8] as String,
      title: fields[1] as String,
      content: fields[2] as String,
      author: fields[3] as String,
      tags: (fields[4] as List).cast<String>(),
      index: fields[5] as int,
    );
  }

  @override
  void write(BinaryWriter writer, MasnunDua obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.content)
      ..writeByte(3)
      ..write(obj.author)
      ..writeByte(4)
      ..write(obj.tags)
      ..writeByte(5)
      ..write(obj.index)
      ..writeByte(8)
      ..write(obj.category);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MasnunDuaAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
