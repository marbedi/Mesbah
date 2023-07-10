import 'package:mesbah/common/exceptions/exceptions.dart';
import 'package:dartz/dartz.dart';
import 'package:mesbah/features/habit/domain/entities/habit_entity.dart';
import 'package:mesbah/features/habit/domain/repositories/habit_repository.dart';

import '../../../../common/usecases/usecase.dart';
import '../entities/my_habits_search_filter.dart';

class GetAllHabitsUseCase
    extends UseCase<List<HabitEntity>, MyHabitsSearchFilterEntity> {
  final HabitRepository repository;
  GetAllHabitsUseCase({required this.repository});
  @override
  Future<Either<Failure, List<HabitEntity>>> call(
      MyHabitsSearchFilterEntity param) async {
    return repository.getAllHabits(param);
  }
}
