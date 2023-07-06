import 'package:habit_tracker_moshtari/common/exceptions/exceptions.dart';
import 'package:dartz/dartz.dart';
import 'package:habit_tracker_moshtari/common/usecases/usecase.dart';
import 'package:habit_tracker_moshtari/features/habit/domain/entities/habit_entity.dart';
import 'package:habit_tracker_moshtari/features/habit/domain/repositories/habit_repository.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

class GetHabitByDateUseCase extends UseCase<List<HabitEntity>, Jalali> {
  final HabitRepository repository;
  GetHabitByDateUseCase({required this.repository});
  @override
  Future<Either<Failure, List<HabitEntity>>> call(Jalali param) async {
    return repository.getHabitsByDate(param);
  }
}
