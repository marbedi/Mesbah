import 'package:mesbah/common/exceptions/exceptions.dart';

import 'package:dartz/dartz.dart';
import 'package:mesbah/features/habit/domain/repositories/habit_repository.dart';

import '../../../../common/usecases/usecase.dart';
import '../entities/habit_entity.dart';

class CreateHabitUseCase extends UseCase<Nothing, HabitEntity> {
  final HabitRepository repository;
  CreateHabitUseCase({required this.repository});
  @override
  Future<Either<Failure, Nothing>> call(HabitEntity param) async {
    return await repository.createHabit(param);
  }
}
