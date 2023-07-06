import 'package:dartz/dartz.dart';

import '../../../../common/exceptions/exceptions.dart';
import '../../../../common/usecases/usecase.dart';
import '../entities/habit_entity.dart';
import '../repositories/habit_repository.dart';

class EditHabitUseCase extends UseCase<Nothing, HabitEntity> {
  final HabitRepository repository;
  EditHabitUseCase({required this.repository});
  @override
  Future<Either<Failure, Nothing>> call(HabitEntity param) async {
    return await repository.editHabit(param);
  }
}
