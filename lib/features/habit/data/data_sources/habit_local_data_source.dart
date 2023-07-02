import 'package:habit_tracker_moshtari/features/habit/domain/entities/habit_entity.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../../common/usecases/usecase.dart';
import '../../domain/entities/my_habits_search_filter.dart';

abstract class HabitLocalDataSource {
  Future<Nothing> createHabit(HabitEntity habitEntity);
  Future<List<HabitEntity>> getAllHabits(MyHabitsSearchFilterEntity filter);
  Future<Nothing> editHabit(HabitEntity habitEntity);
  Future<Nothing> deleteHabit(String id);
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

    return list.toList();
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
}
