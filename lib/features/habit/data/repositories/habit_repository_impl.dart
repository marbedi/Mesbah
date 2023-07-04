import 'package:habit_tracker_moshtari/common/extensions/future.dart';
import 'package:habit_tracker_moshtari/common/usecases/usecase.dart';
import 'package:habit_tracker_moshtari/common/exceptions/exceptions.dart';
import 'package:dartz/dartz.dart';
import 'package:habit_tracker_moshtari/features/habit/data/data_sources/habit_local_data_source.dart';
import 'package:habit_tracker_moshtari/features/habit/domain/entities/habit_entity.dart';
import 'package:habit_tracker_moshtari/features/habit/domain/repositories/habit_repository.dart';
import 'package:habit_tracker_moshtari/features/habit/domain/usecases/complete_habit_use_case.dart';
import 'package:persian_datetime_picker/src/date/src/jalali/jalali_date.dart';

import '../../domain/entities/my_habits_search_filter.dart';

class HabitRepositoryImpl implements HabitRepository {
  final HabitLocalDataSource dataSource;
  HabitRepositoryImpl({required this.dataSource});
  @override
  Future<Either<Failure, Nothing>> createHabit(HabitEntity habit) async {
    return await dataSource.createHabit(habit).toEither();
  }

  @override
  Future<Either<Failure, List<HabitEntity>>> getAllHabits(
      MyHabitsSearchFilterEntity filter) async {
    return await dataSource.getAllHabits(filter).toEither();
  }

  @override
  Future<Either<Failure, Nothing>> editHabit(HabitEntity habit) async {
    return await dataSource.editHabit(habit).toEither();
  }

  @override
  Future<Either<Failure, Nothing>> deleteHabit(String id) async {
    return await dataSource.deleteHabit(id).toEither();
  }

  @override
  Future<Either<Failure, List<HabitEntity>>> getHabitsByDate(
      Jalali date) async {
    return await dataSource.getHabitsByDate(date).toEither();
  }

  @override
  Future<Either<Failure, Nothing>> complete(
      CompleteHabitUseCaseParams params) async {
    return await dataSource.complete(params).toEither();
  }
}
