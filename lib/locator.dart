import 'package:get_it/get_it.dart';
import 'package:habit_tracker_moshtari/features/habit/domain/entities/habit_entity.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> setup() async {
  final habitBox = await Hive.openBox<HabitEntity>('habitBox');

  sl.registerSingleton<Box<HabitEntity>>(habitBox);

  sl.registerSingleton<PagingController<int, HabitEntity>>(
      PagingController(firstPageKey: 1));
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerSingleton<SharedPreferences>(sharedPreferences);
}
