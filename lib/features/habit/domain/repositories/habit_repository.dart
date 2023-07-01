import 'package:dartz/dartz.dart';
import 'package:habit_tracker_moshtari/common/exceptions/exceptions.dart';
import 'package:habit_tracker_moshtari/features/habit/domain/entities/habit_entity.dart';

import '../../../../common/usecases/usecase.dart';

abstract class HabitRepository {
  Future<Either<Failure, Nothing>> createHabit(HabitEntity habit);
}
