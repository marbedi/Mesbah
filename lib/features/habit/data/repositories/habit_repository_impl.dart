import 'package:habit_tracker_moshtari/common/extensions/future.dart';
import 'package:habit_tracker_moshtari/common/usecases/usecase.dart';
import 'package:habit_tracker_moshtari/common/exceptions/exceptions.dart';
import 'package:dartz/dartz.dart';
import 'package:habit_tracker_moshtari/features/habit/data/data_sources/habit_local_data_source.dart';
import 'package:habit_tracker_moshtari/features/habit/domain/entities/habit_entity.dart';
import 'package:habit_tracker_moshtari/features/habit/domain/repositories/habit_repository.dart';

class HabitRepositoryImpl implements HabitRepository {
  final HabitLocalDataSource dataSource;
  HabitRepositoryImpl({required this.dataSource});
  @override
  Future<Either<Failure, Nothing>> createHabit(HabitEntity habit) async {
    return await dataSource.createHabit(habit).toEither();
  }
}
