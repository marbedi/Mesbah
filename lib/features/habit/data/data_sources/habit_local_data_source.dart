import 'package:habit_tracker_moshtari/features/habit/domain/entities/habit_entity.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../../common/usecases/usecase.dart';

abstract class HabitLocalDataSource {
  Future<Nothing> createHabit(HabitEntity habitEntity);
}

class HabitLocalDataSourceImpl implements HabitLocalDataSource {
  final Box<HabitEntity> habitBox;
  HabitLocalDataSourceImpl({required this.habitBox});
  @override
  Future<Nothing> createHabit(HabitEntity habitEntity) async {
    await habitBox.add(habitEntity);
    print(habitBox.values);
    return Nothing();
  }
}
