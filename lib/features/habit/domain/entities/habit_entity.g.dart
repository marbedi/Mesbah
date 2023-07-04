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
      categoryId: fields[4] as int,
      startDate: fields[8] as DateTime,
      endDate: fields[9] as DateTime,
      habitGoal: fields[6] == null ? const HabitGoal() : fields[6] as HabitGoal,
      period: fields[7] as Period,
      reminders:
          fields[10] == null ? [] : (fields[10] as List).cast<ReminderEntity>(),
      completionDates: (fields[12] as List).cast<DateTime>(),
      completed: fields[11] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, HabitEntity obj) {
    writer
      ..writeByte(13)
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
      ..write(obj.reminders)
      ..writeByte(11)
      ..write(obj.completed)
      ..writeByte(12)
      ..write(obj.completionDates);
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

class HabitGoalAdapter extends TypeAdapter<HabitGoal> {
  @override
  final int typeId = 2;

  @override
  HabitGoal read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HabitGoal(
      goalType: fields[1] as GoalType,
      totalStep: fields[2] as int,
      unit: fields[3] as String?,
      currentStep: fields[4] as int,
    );
  }

  @override
  void write(BinaryWriter writer, HabitGoal obj) {
    writer
      ..writeByte(4)
      ..writeByte(1)
      ..write(obj.goalType)
      ..writeByte(2)
      ..write(obj.totalStep)
      ..writeByte(3)
      ..write(obj.unit)
      ..writeByte(4)
      ..write(obj.currentStep);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HabitGoalAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class PeriodAdapter extends TypeAdapter<Period> {
  @override
  final int typeId = 3;

  @override
  Period read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Period(
      periodType: fields[1] as PeriodType,
      weekDays: (fields[2] as List?)?.cast<int>(),
      monthDays: (fields[3] as List?)?.cast<int>(),
      dayStep: fields[4] as int,
      currentDayStep: fields[5] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Period obj) {
    writer
      ..writeByte(5)
      ..writeByte(1)
      ..write(obj.periodType)
      ..writeByte(2)
      ..write(obj.weekDays)
      ..writeByte(3)
      ..write(obj.monthDays)
      ..writeByte(4)
      ..write(obj.dayStep)
      ..writeByte(5)
      ..write(obj.currentDayStep);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PeriodAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class PeriodTypeAdapter extends TypeAdapter<PeriodType> {
  @override
  final int typeId = 5;

  @override
  PeriodType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 1:
        return PeriodType.everyDay;
      case 2:
        return PeriodType.aFewDaysPerWeek;
      case 3:
        return PeriodType.aFewDaysPerMonth;
      default:
        return PeriodType.everyDay;
    }
  }

  @override
  void write(BinaryWriter writer, PeriodType obj) {
    switch (obj) {
      case PeriodType.everyDay:
        writer.writeByte(1);
        break;
      case PeriodType.aFewDaysPerWeek:
        writer.writeByte(2);
        break;
      case PeriodType.aFewDaysPerMonth:
        writer.writeByte(3);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PeriodTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class GoalTypeAdapter extends TypeAdapter<GoalType> {
  @override
  final int typeId = 4;

  @override
  GoalType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 1:
        return GoalType.binary;
      case 2:
        return GoalType.integer;
      default:
        return GoalType.binary;
    }
  }

  @override
  void write(BinaryWriter writer, GoalType obj) {
    switch (obj) {
      case GoalType.binary:
        writer.writeByte(1);
        break;
      case GoalType.integer:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GoalTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
