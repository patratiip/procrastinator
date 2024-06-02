// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lection_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LectionAdapter extends TypeAdapter<Lection> {
  @override
  final int typeId = 3;

  @override
  Lection read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Lection(
      theme: fields[0] as String?,
      trainer: fields[1] as String?,
      date: fields[2] as DateTime?,
      dayOfWeek: fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Lection obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.theme)
      ..writeByte(1)
      ..write(obj.trainer)
      ..writeByte(2)
      ..write(obj.date)
      ..writeByte(3)
      ..write(obj.dayOfWeek);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LectionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
