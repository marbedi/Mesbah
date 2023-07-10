import 'package:get_it/get_it.dart';
import 'package:habit_tracker_moshtari/features/auth/data/data_source/auth_remote_data_source.dart';
import 'package:habit_tracker_moshtari/features/auth/domain/repositories/auth_repository.dart';
import 'package:habit_tracker_moshtari/features/auth/domain/usecases/sign_in_with_email_use_case.dart';
import 'package:habit_tracker_moshtari/features/auth/presentation/bloc/auth_bloc.dart';
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

import 'features/auth/data/repositories/auth_repository_impl.dart';
import 'features/auth/domain/usecases/get_user_data_use_case.dart';
import 'features/auth/domain/usecases/sign_up_with_email_use_case.dart';

final locator = GetIt.instance;

Future<void> setup() async {
  final habitBox = await Hive.openBox<HabitEntity>('habitBox');
  final supabase = Supabase.instance;

  locator.registerSingleton<Box<HabitEntity>>(habitBox);
  locator.registerSingleton<Supabase>(supabase);

  locator.registerSingleton<PagingController<int, HabitEntity>>(
      PagingController(firstPageKey: 1));
  final sharedPreferences = await SharedPreferences.getInstance();
  locator.registerSingleton<SharedPreferences>(sharedPreferences);

  locator.registerSingleton<HabitLocalDataSource>(
      HabitLocalDataSourceImpl(habitBox: locator()));
  locator.registerSingleton<AuthRemoteDataSource>(
      AuthRemoteDataSourceImpl(supabase: locator()));

  locator.registerSingleton<HabitRepository>(
      HabitRepositoryImpl(dataSource: locator()));
  locator.registerSingleton<AuthRepository>(
      AuthRepositoryImpl(dataSource: locator()));

  locator
      .registerLazySingleton(() => CreateHabitUseCase(repository: locator()));
  locator
      .registerLazySingleton(() => GetAllHabitsUseCase(repository: locator()));
  locator.registerLazySingleton(() => EditHabitUseCase(repository: locator()));
  locator
      .registerLazySingleton(() => DeleteHabitUseCase(repository: locator()));
  locator.registerLazySingleton(
      () => GetHabitByDateUseCase(repository: locator()));

  locator
      .registerLazySingleton(() => CompleteHabitUseCase(repository: locator()));
  locator.registerLazySingleton(
      () => SignInWithEmailUseCase(repository: locator()));
  locator.registerLazySingleton(
      () => SignUpWithEmailUseCase(repository: locator()));
  locator
      .registerLazySingleton(() => GetUserDataUseCase(repository: locator()));

  locator.registerFactory(() => HabitBloc(
      getHabitByDateUseCase: locator(), getAllHabitsUseCase: locator()));
  locator.registerFactory(() => AuthBloc(
      signInWithEmailUseCase: locator(),
      signUpWithEmailUseCase: locator(),
      getUserDataUseCase: locator()));
}
