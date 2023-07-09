import 'package:flutter_bloc/flutter_bloc.dart';
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

import '../features/auth/domain/entities/user_entity.dart';
import '../features/auth/presentation/bloc/auth_bloc.dart';
import '../features/profile/presentation/pages/profile_page.dart';
import '../features/auth/presentation/pages/sign_up_page.dart';
import '../locator.dart';
import '../main.dart';

// GoRouter configuration
final router = GoRouter(
  debugLogDiagnostics: true,
  // initialLocation: "/auth/sign_in",
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
      path: "/auth_sign_in",
      builder: (context, state) => BlocProvider<AuthBloc>(
        create: (context) => AuthBloc(
          signInWithEmailUseCase: locator(),
        ),
        child: const AuthSignInPage(),
      ),
    ),
    GoRoute(
      path: '/auth_sign_up',
      builder: (context, state) => BlocProvider<AuthBloc>(
        create: (context) => AuthBloc(signUpWithEmailUseCase: locator()),
        child: const AuthSignUpPage(),
      ),
    ),
    GoRoute(
      path: '/profile',
      builder: (context, state) => ProfilePage(
        userEntity: state.extra as UserEntity,
      ),
    ),
  ],
);
