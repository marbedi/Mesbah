// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'habit_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HabitEntityAdapter extends TypeAdapter<HabitEntity> {
  @override
  final int typeId = 1;

  @override
  HabitEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HabitEntity(
      id: fields[0] as String,
      title: fields[1] as String,
      desc: fields[2] as String,
      isPublic: fields[5] as bool,
      icon: fields[3] as int,
      categoryId: fields[4] as String,
      startDate: fields[8] as DateTime,
      endDate: fields[9] as DateTime,
      habitGoal: fields[6] == null ? const HabitGoal() : fields[6] as HabitGoal,
      period: fields[7] as Period,
      reminders:
          fields[10] == null ? [] : (fields[10] as List).cast<ReminderEntity>(),
    );
  }

  @override
  void write(BinaryWriter writer, HabitEntity obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.desc)
      ..writeByte(3)
      ..write(obj.icon)
      ..writeByte(4)
      ..write(obj.categoryId)
      ..writeByte(5)
      ..write(obj.isPublic)
      ..writeByte(6)
      ..write(obj.habitGoal)
      ..writeByte(7)
      ..write(obj.period)
      ..writeByte(8)
      ..write(obj.startDate)
      ..writeByte(9)
      ..write(obj.endDate)
      ..writeByte(10)
      ..write(obj.reminders);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HabitEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
