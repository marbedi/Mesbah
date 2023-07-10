import 'package:mesbah/common/exceptions/exceptions.dart';
import 'package:dartz/dartz.dart';
import 'package:mesbah/common/usecases/usecase.dart';
import 'package:mesbah/features/habit/domain/repositories/habit_repository.dart';

class DeleteHabitUseCase extends UseCase<Nothing, String> {
  final HabitRepository repository;
  DeleteHabitUseCase({required this.repository});
  @override
  Future<Either<Failure, Nothing>> call(String param) async {
    return await repository.deleteHabit(param);
  }
}
