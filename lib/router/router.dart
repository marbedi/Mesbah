import 'package:go_router/go_router.dart';
import 'package:habit_tracker_moshtari/features/auth/presentation/pages/sign_in_page.dart';
import 'package:habit_tracker_moshtari/features/habit/domain/entities/category_entity.dart';
import 'package:habit_tracker_moshtari/features/habit/domain/entities/habit_entity.dart';
import 'package:habit_tracker_moshtari/features/habit/presentation/pages/add_habits_list_page.dart';
import 'package:habit_tracker_moshtari/features/habit/presentation/pages/create_habit_page.dart';
import 'package:habit_tracker_moshtari/features/habit/presentation/pages/habit_info_page.dart';
import 'package:habit_tracker_moshtari/features/habit/presentation/pages/habit_sources_page.dart';
import 'package:habit_tracker_moshtari/features/home/presentation/pages/home_page.dart';
import 'package:habit_tracker_moshtari/features/onboarding/pages/onboarding_page.dart';

import '../main.dart';

// GoRouter configuration
final router = GoRouter(
  debugLogDiagnostics: true,
  routes: [
    GoRoute(
        path: '/',
        builder: (context, state) => const SplashScreen(),
        name: '/splash'),
    GoRoute(
      path: '/onboarding',
      builder: (context, state) => const OnBoardingPage(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/habits',
      builder: (context, state) => AddHabitsListPage(
        c: state.extra as CategoryEntity,
      ),
    ),
    GoRoute(
      path: '/create_habit',
      builder: (context, state) => CreateHabitPage(
        habit: state.extra as HabitEntity?,
      ),
    ),
    GoRoute(
      path: '/habit_info',
      builder: (context, state) => HabitInfoPage(
        habit: state.extra as HabitEntity,
      ),
    ),
    GoRoute(
      path: '/habit_sources',
      builder: (context, state) => HabitSourcesPage(
        c: state.extra as CategoryEntity,
      ),
    ),
    GoRoute(
      path: '/auth/sign_in',
      builder: (context, state) => const AuthSignInPage(),
    ),
  ],
);
