import 'package:mesbah/common/exceptions/exceptions.dart';
import 'package:dartz/dartz.dart';
import 'package:mesbah/common/usecases/usecase.dart';

import '../repositories/habit_repository.dart';

class CompleteHabitUseCase
    extends UseCase<Nothing, CompleteHabitUseCaseParams> {
  final HabitRepository repository;
  CompleteHabitUseCase({required this.repository});
  @override
  Future<Either<Failure, Nothing>> call(
      CompleteHabitUseCaseParams param) async {
    return await repository.complete(param);
  }
}

class CompleteHabitUseCaseParams {
  final String id;
  final int? value;
  CompleteHabitUseCaseParams({required this.id, this.value});
}
