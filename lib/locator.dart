import 'package:get_it/get_it.dart';
import 'package:habit_tracker_moshtari/features/habit/data/data_sources/habit_local_data_source.dart';
import 'package:habit_tracker_moshtari/features/habit/data/repositories/habit_repository_impl.dart';
import 'package:habit_tracker_moshtari/features/habit/domain/entities/habit_entity.dart';
import 'package:habit_tracker_moshtari/features/habit/domain/repositories/habit_repository.dart';
import 'package:habit_tracker_moshtari/features/habit/domain/usecases/complete_habit_use_case.dart';
import 'package:habit_tracker_moshtari/features/habit/domain/usecases/create_habit_use_case.dart';
import 'package:habit_tracker_moshtari/features/habit/domain/usecases/delete_habit_use_case.dart';
import 'package:habit_tracker_moshtari/features/habit/domain/usecases/edit_habit_use_case.dart';
import 'package:habit_tracker_moshtari/features/habit/domain/usecases/get_all_habits_use_case.dart';
import 'package:habit_tracker_moshtari/features/habit/domain/usecases/get_habit_by_date.dart';
import 'package:habit_tracker_moshtari/features/habit/presentation/bloc/habit_bloc_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final locator = GetIt.instance;

Future<void> setup() async {
  final habitBox = await Hive.openBox<HabitEntity>('habitBox');

  locator.registerSingleton<Box<HabitEntity>>(habitBox);

  locator.registerSingleton<PagingController<int, HabitEntity>>(
      PagingController(firstPageKey: 1));
  final sharedPreferences = await SharedPreferences.getInstance();
<<<<<<< HEAD
  locator.registerSingleton<SharedPreferences>(sharedPreferences);

  final supabase = Supabase.instance;
  locator.registerSingleton<Supabase>(supabase);
=======
  sl.registerSingleton<SharedPreferences>(sharedPreferences);

  sl.registerSingleton<HabitLocalDataSource>(
      HabitLocalDataSourceImpl(habitBox: sl()));

  sl.registerSingleton<HabitRepository>(HabitRepositoryImpl(dataSource: sl()));

  sl.registerLazySingleton(() => CreateHabitUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetAllHabitsUseCase(repository: sl()));
  sl.registerLazySingleton(() => EditHabitUseCase(repository: sl()));
  sl.registerLazySingleton(() => DeleteHabitUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetHabitByDateUseCase(repository: sl()));
  sl.registerLazySingleton(() => CompleteHabitUseCase(repository: sl()));

  sl.registerFactory(
      () => HabitBloc(getHabitByDateUseCase: sl(), getAllHabitsUseCase: sl()));
>>>>>>> master
}
