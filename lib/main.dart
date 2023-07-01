import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get_it/get_it.dart';
import 'package:habit_tracker_moshtari/common/extensions/context.dart';
import 'package:habit_tracker_moshtari/common/navigation/navigation_flow.dart';
import 'package:habit_tracker_moshtari/configs/config.dart';
import 'package:habit_tracker_moshtari/features/habit/domain/entities/habit_entity.dart';
import 'package:habit_tracker_moshtari/helper/alram_manager.dart';
import 'package:habit_tracker_moshtari/router/router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'common/gen/assets.gen.dart';
import 'common/widgets/loading_widget.dart';
import 'locator.dart';
import 'package:timezone/data/latest.dart' as tzl;
import 'package:timezone/standalone.dart' as tz;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(HabitEntityAdapter());

  // tzl.initializeTimeZones();
  // print(tz.TZDateTime.now(tz.getLocation('Asia/Tehran')));
  // AlarmManager().scheduleDailyAlarm();
  await EasyLocalization.ensureInitialized();
  await setup();
  runApp(EasyLocalization(
      supportedLocales: const [Locale('fa', 'IR')],
      path: 'assets/translations',
      fallbackLocale: const Locale('fa', 'IR'),
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: config['theme'],
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      routerConfig: router,
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    init();
    super.initState();
  }

  void init() async {
    if (!GetIt.I.isRegistered<SharedPreferences>()) {
      await setup();
    }
    final shared = sl<SharedPreferences>();
    final firstLogin = shared.getBool('firstLogin') ?? true;
    await Future.delayed(const Duration(milliseconds: 1000));
    if (firstLogin) {
      NavigationFlow.toOnBoarding();
    } else {
      NavigationFlow.toHome();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Spacer(),
          Center(
            child: Hero(
              tag: 'logo',
              child: Assets.images.logo
                  .image(height: 250, width: 250)
                  .animate()
                  .fadeIn(),
            ),
          ),
          const Spacer(),
          LoadingWidget(
            color: context.colorScheme.primary,
          )
        ],
      ),
    );
  }
}
