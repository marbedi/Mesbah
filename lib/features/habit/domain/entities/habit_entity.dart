import 'package:easy_localization/easy_localization.dart';
import 'package:habit_tracker_moshtari/features/habit/domain/entities/reminder.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'habit_entity.g.dart';

@HiveType(typeId: 1)
class HabitEntity extends HiveObject {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final String desc;
  @HiveField(3)
  final int icon;
  @HiveField(4)
  final int categoryId;
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
  @HiveField(11)
  final bool completed;
  HabitEntity(
      {required this.id,
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
      this.completed = false});

  HabitEntity copyWith({
    String? id,
    String? title,
    String? desc,
    int? icon,
    int? categoryId,
    bool? isPublic,
    HabitGoal? habitGoal,
    Period? period,
    DateTime? startDate,
    DateTime? endDate,
    List<ReminderEntity>? reminders,
    bool? completed,
  }) {
    return HabitEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      desc: desc ?? this.desc,
      icon: icon ?? this.icon,
      categoryId: categoryId ?? this.categoryId,
      isPublic: isPublic ?? this.isPublic,
      habitGoal: habitGoal ?? this.habitGoal,
      period: period ?? this.period,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      reminders: reminders ?? this.reminders,
      completed: completed ?? this.completed,
    );
  }
}

@HiveType(typeId: 5)
enum PeriodType {
  @HiveField(1)
  everyDay,
  @HiveField(2)
  aFewDaysPerWeek,
  @HiveField(3)
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

@HiveType(typeId: 2)
class HabitGoal {
  @HiveField(1)
  final GoalType goalType;
  @HiveField(2)
  final int totalStep;
  @HiveField(3)
  final String? unit;
  @HiveField(4)
  final int currentStep;
  const HabitGoal(
      {this.goalType = GoalType.binary,
      this.totalStep = 1,
      this.unit,
      this.currentStep = 0});

  HabitGoal copyWith({
    GoalType? goalType,
    int? totalStep,
    String? unit,
    int? currentStep,
  }) {
    return HabitGoal(
      goalType: goalType ?? this.goalType,
      totalStep: totalStep ?? this.totalStep,
      unit: unit ?? this.unit,
      currentStep: currentStep ?? this.currentStep,
    );
  }
}

@HiveType(typeId: 3)
class Period {
  @HiveField(1)
  final PeriodType periodType;
  @HiveField(2)
  final List<int>? weekDays;
  @HiveField(3)
  final List<int>? monthDays;
  @HiveField(4)
  final int dayStep;
  @HiveField(5)
  final int currentDayStep;
  Period({
    required this.periodType,
    this.weekDays,
    this.monthDays,
    this.dayStep = 1,
    this.currentDayStep = 0,
  });
  Period copyWith({
    PeriodType? periodType,
    List<int>? weekDays,
    List<int>? monthDays,
    int? dayStep,
    int? currentDayStep,
  }) =>
      Period(
        periodType: periodType ?? this.periodType,
        weekDays: weekDays ?? this.weekDays,
        monthDays: monthDays ?? this.monthDays,
        dayStep: dayStep ?? this.dayStep,
        currentDayStep: currentDayStep ?? this.currentDayStep,
      );
}

@HiveType(typeId: 4)
enum GoalType {
  @HiveField(1)
  binary,
  @HiveField(2)
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
  categoryId: 0,
);
