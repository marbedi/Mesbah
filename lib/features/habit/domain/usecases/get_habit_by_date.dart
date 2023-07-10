import 'package:mesbah/common/exceptions/exceptions.dart';
import 'package:dartz/dartz.dart';
import 'package:mesbah/common/usecases/usecase.dart';
import 'package:mesbah/features/habit/domain/entities/habit_entity.dart';
import 'package:mesbah/features/habit/domain/repositories/habit_repository.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

class GetHabitByDateUseCase extends UseCase<List<HabitEntity>, Jalali> {
  final HabitRepository repository;
  GetHabitByDateUseCase({required this.repository});
  @override
  Future<Either<Failure, List<HabitEntity>>> call(Jalali param) async {
    return repository.getHabitsByDate(param);
  }
}
