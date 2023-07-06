// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reminder.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ReminderEntityAdapter extends TypeAdapter<ReminderEntity> {
  @override
  final int typeId = 6;

  @override
  ReminderEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ReminderEntity(
      id: fields[1] as String,
      time: fields[2] as DateTime,
      days: (fields[3] as List).cast<int>(),
    );
  }

  @override
  void write(BinaryWriter writer, ReminderEntity obj) {
    writer
      ..writeByte(3)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.time)
      ..writeByte(3)
      ..write(obj.days);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ReminderEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
