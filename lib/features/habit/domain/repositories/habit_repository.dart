import 'package:dartz/dartz.dart';
import 'package:habit_tracker_moshtari/common/exceptions/exceptions.dart';
import 'package:habit_tracker_moshtari/features/habit/domain/entities/habit_entity.dart';

import '../../../../common/usecases/usecase.dart';
import '../entities/my_habits_search_filter.dart';

abstract class HabitRepository {
  Future<Either<Failure, Nothing>> createHabit(HabitEntity habit);
  Future<Either<Failure, List<HabitEntity>>> getAllHabits(
      MyHabitsSearchFilterEntity filter);
  Future<Either<Failure, Nothing>> editHabit(HabitEntity habit);
  Future<Either<Failure, Nothing>> deleteHabit(String id);
}
