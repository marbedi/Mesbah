import 'package:dartz/dartz.dart';
import 'package:mesbah/common/exceptions/exceptions.dart';
import 'package:mesbah/features/habit/domain/entities/habit_entity.dart';
import 'package:mesbah/features/habit/domain/usecases/complete_habit_use_case.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

import '../../../../common/usecases/usecase.dart';
import '../entities/my_habits_search_filter.dart';

abstract class HabitRepository {
  Future<Either<Failure, Nothing>> createHabit(HabitEntity habit);
  Future<Either<Failure, List<HabitEntity>>> getAllHabits(
      MyHabitsSearchFilterEntity filter);
  Future<Either<Failure, List<HabitEntity>>> getHabitsByDate(Jalali date);
  Future<Either<Failure, Nothing>> editHabit(HabitEntity habit);
  Future<Either<Failure, Nothing>> deleteHabit(String id);
  Future<Either<Failure, Nothing>> complete(CompleteHabitUseCaseParams params);
}
