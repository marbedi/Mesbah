import 'package:easy_localization/easy_localization.dart';
import 'package:habit_tracker_moshtari/features/habit/domain/entities/reminder.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'habit_entity.g.dart';

@HiveType(typeId: 1)
class HabitEntity {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final String desc;
  @HiveField(3)
  final int icon;
  @HiveField(4)
  final String categoryId;
  @HiveField(5)
  final bool isPublic;
  @HiveField(6, defaultValue: HabitGoal())
  final HabitGoal habitGoal;
  @HiveField(7)
  final Period period;
  @HiveField(8)
  final DateTime startDate;
  @HiveField(9)
  final DateTime endDate;
  @HiveField(10, defaultValue: [])
  final List<ReminderEntity> reminders;
  HabitEntity({
    required this.id,
    required this.title,
    required this.desc,
    required this.isPublic,
    required this.icon,
    required this.categoryId,
    required this.startDate,
    required this.endDate,
    this.habitGoal = const HabitGoal(),
    required this.period,
    this.reminders = const [],
  });
}

enum PeriodType {
  everyDay,
  aFewDaysPerWeek,
  aFewDaysPerMonth,
}

extension PeriodToText on PeriodType {
  String get toText {
    switch (this) {
      case PeriodType.everyDay:
        return 'in_a_day'.tr();
      case PeriodType.aFewDaysPerWeek:
        return 'in_a_week'.tr();
      case PeriodType.aFewDaysPerMonth:
        return 'in_a_month'.tr();
    }
  }
}

class HabitGoal {
  final GoalType goalType;
  final int totalStep;
  final String? unit;
  final int currentStep;
  const HabitGoal(
      {this.goalType = GoalType.binary,
      this.totalStep = 1,
      this.unit,
      this.currentStep = 0});
}

class Period {
  final PeriodType periodType;
  final List<int>? weekDays;
  final List<int>? monthDays;
  final int dayStep;
  Period({
    required this.periodType,
    this.weekDays,
    this.monthDays,
    this.dayStep = 1,
  });
}

enum GoalType {
  binary,
  integer,
}

final fakeHabit = HabitEntity(
  id: '1',
  endDate: DateTime.now().add(Duration(days: 30)),
  startDate: DateTime.now(),
  icon: 1,
  isPublic: true,
  title: 'قرآن خواندن',
  desc: 'توضیحات قران خواندن',
  period: Period(periodType: PeriodType.everyDay),
  categoryId: '2',
);
