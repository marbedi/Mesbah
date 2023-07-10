import 'package:habit_tracker_moshtari/features/habit/domain/entities/habit_entity.dart';

abstract class HabitRemoteDataSource {
  Future<List<HabitEntity>> getAllHabits();
}
