import 'package:habit_tracker_moshtari/common/extensions/date.dart';
import 'package:habit_tracker_moshtari/features/habit/domain/entities/habit_entity.dart';
import 'package:habit_tracker_moshtari/features/habit/domain/usecases/complete_habit_use_case.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

import '../../../../common/usecases/usecase.dart';
import '../../domain/entities/my_habits_search_filter.dart';

abstract class HabitLocalDataSource {
  Future<Nothing> createHabit(HabitEntity habitEntity);
  Future<List<HabitEntity>> getAllHabits(MyHabitsSearchFilterEntity filter);
  Future<List<HabitEntity>> getHabitsByDate(Jalali date);
  Future<Nothing> editHabit(HabitEntity habitEntity);
  Future<Nothing> deleteHabit(String id);
  Future<Nothing> complete(CompleteHabitUseCaseParams params);
}

class HabitLocalDataSourceImpl implements HabitLocalDataSource {
  final Box<HabitEntity> habitBox;
  HabitLocalDataSourceImpl({required this.habitBox});
  @override
  Future<Nothing> createHabit(HabitEntity habitEntity) async {
    await habitBox.add(habitEntity);

    return Nothing();
  }

  @override
  Future<List<HabitEntity>> getAllHabits(
      MyHabitsSearchFilterEntity filter) async {
    var list = habitBox.values.toList();

    if (filter.searchText != null && filter.searchText!.isNotEmpty) {
      list = list
          .where((element) => element.title.contains(filter.searchText!))
          .toList();
    }
    if (filter.selectedCategory.isNotEmpty) {
      list = list
          .where((e) =>
              filter.selectedCategory.any((element) => element == e.categoryId))
          .toList();
    }
    if (filter.selectedStatus != 0) {
      if (filter.selectedStatus == 2) {
        list = list.where((element) => element.completed).toList();
      } else if (filter.selectedStatus == 1) {
        list = list.where((element) => !element.completed).toList();
      }
    }

    return list
        .map((e) => e.copyWith(
            currentDayStep: e.completionDates
                .where((element) => element.isToday())
                .toList()
                .length))
        .toList();
  }

  @override
  Future<Nothing> editHabit(HabitEntity habitEntity) async {
    final list = habitBox.values.toList();
    final index = list.indexWhere((element) => element.id == habitEntity.id);
    if (index != -1) {
      habitBox.putAt(index, habitEntity);
    }
    return Nothing();
  }

  @override
  Future<Nothing> deleteHabit(String id) async {
    final list = habitBox.values.toList();
    final index = list.indexWhere((element) => element.id == id);
    if (index != -1) {
      habitBox.deleteAt(index);
    }
    return Nothing();
  }

  @override
  Future<List<HabitEntity>> getHabitsByDate(Jalali date) async {
    final allHabits = habitBox.values.toList();
    List<HabitEntity> habits = [];

    for (var habit in allHabits) {
      habit = habit.copyWith(
          currentDayStep: habit.completionDates
              .where((element) => element.isToday(date.toDateTime()))
              .toList()
              .length);
      if (date.toDateTime().isBetween(habit.startDate, habit.endDate)! &&
          !habit.completed) {
        if (habit.period.periodType == PeriodType.everyDay) {
          habits.add(habit);
        }
        if (habit.period.periodType == PeriodType.aFewDaysPerWeek) {
          if (habit.period.weekDays!
              .any((element) => element == date.weekDay)) {
            habits.add(habit);
          }
        }

        if (habit.period.periodType == PeriodType.aFewDaysPerMonth) {
          if (habit.period.monthDays!.any((element) => element == date.day)) {
            habits.add(habit);
          }
        }
      }
    }
    return habits;
  }

  @override
  Future<Nothing> complete(CompleteHabitUseCaseParams params) async {
    final list = habitBox.values.toList();
    final index = list.indexWhere((element) => element.id == params.id);
    final habit = habitBox.values.toList()[index];
    if (index != -1) {
      if (habit.completionDates
                  .where((element) => element.isToday())
                  .toList()
                  .length >=
              habit.period.dayStep ||
          habit.habitGoal.goalCompleted) {
        return Nothing();
      }
      HabitEntity updatedHabit = habit.copyWith(
          completionDates: [...habit.completionDates, DateTime.now()]);

      if (habit.habitGoal.goalType == GoalType.integer &&
          params.value != null) {
        updatedHabit = updatedHabit.copyWith(
            habitGoal: updatedHabit.habitGoal.copyWith(
                currentStep:
                    updatedHabit.habitGoal.currentStep + params.value!));
      }
      habitBox.putAt(index, updatedHabit);
    }
    return Nothing();
  }
}
