import 'package:mesbah/features/habit/domain/entities/habit_entity.dart';

abstract class HabitRemoteDataSource {
  Future<List<HabitEntity>> getAllHabits();
}
