import 'package:habit_tracker_moshtari/common/exceptions/exceptions.dart';
import 'package:dartz/dartz.dart';
import 'package:habit_tracker_moshtari/common/usecases/usecase.dart';
import 'package:habit_tracker_moshtari/features/habit/domain/repositories/habit_repository.dart';

class DeleteHabitUseCase extends UseCase<Nothing, String> {
  final HabitRepository repository;
  DeleteHabitUseCase({required this.repository});
  @override
  Future<Either<Failure, Nothing>> call(String param) async {
    return await repository.deleteHabit(param);
  }
}
