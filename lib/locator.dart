import 'package:get_it/get_it.dart';
import 'package:habit_tracker_moshtari/features/habit/domain/entities/habit_entity.dart';
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
  locator.registerSingleton<SharedPreferences>(sharedPreferences);

  final supabase = Supabase.instance;
  locator.registerSingleton<Supabase>(supabase);
}
