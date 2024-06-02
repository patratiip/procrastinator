// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'last_entry_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class EntryAdapter extends TypeAdapter<Entry> {
  @override
  final int typeId = 2;

  @override
  Entry read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Entry(
      visitID: fields[0] as String?,
      date: fields[1] as DateTime?,
      user: fields[2] as String?,
      schoolVisit: fields[3] as bool?,
      homeOffice: fields[4] as bool?,
      krank: fields[5] as bool?,
      fehl: fields[6] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, Entry obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.visitID)
      ..writeByte(1)
      ..write(obj.date)
      ..writeByte(2)
      ..write(obj.user)
      ..writeByte(3)
      ..write(obj.schoolVisit)
      ..writeByte(4)
      ..write(obj.homeOffice)
      ..writeByte(5)
      ..write(obj.krank)
      ..writeByte(6)
      ..write(obj.fehl);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EntryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
