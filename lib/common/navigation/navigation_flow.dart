import 'package:habit_tracker_moshtari/features/habit/domain/entities/category_entity.dart';
import 'package:habit_tracker_moshtari/features/habit/domain/entities/habit_entity.dart';

import '../../router/router.dart';

class NavigationFlow {
  static back([r]) {
    router.pop(r);
  }

  static toOnBoarding() {
    router.pushReplacement('/onboarding');
  }

  static toHome() {
    router.pushReplacement('/home');
  }

  static toHabitsListPage(CategoryEntity c) {
    router.push('/habits', extra: c);
  }

  static toCreateHabit([HabitEntity? habit]) async {
    return await router.push('/create_habit', extra: habit);
  }

  static toHabitInfo(HabitEntity habit) async {
    return await router.push('/habit_info', extra: habit);
  }

  static toHabitSources(CategoryEntity c) async {
    return await router.push('/habit_sources', extra: c);
  }
}
