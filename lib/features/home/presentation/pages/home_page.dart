import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_tracker_moshtari/common/extensions/context.dart';
import 'package:habit_tracker_moshtari/features/habit/presentation/bloc/habit_bloc_bloc.dart';
import 'package:habit_tracker_moshtari/features/habit/presentation/pages/category_list_page.dart';

import '../../../../locator.dart';
import '../../../habit/presentation/pages/todo_habit_list_page.dart';
import '../../../habit/presentation/pages/my_habits_llist_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;
  final _pageController = PageController(initialPage: 0);
  Color getNavItemColor(BuildContext context, int currentIndex, int itemIndex) {
    final colorScheme = Theme.of(context).colorScheme;
    return currentIndex == itemIndex
        ? colorScheme.primary
        : colorScheme.onBackground;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: CurvedNavigationBar(
          index: currentIndex,
          //color: context.colorScheme.primary.withOpacity(0.1),
          backgroundColor: context.theme.scaffoldBackgroundColor,
          items: <Widget>[
            Icon(
              Icons.home,
              size: 30,
              color: getNavItemColor(context, currentIndex, 0),
            ),
            Icon(
              Icons.list,
              size: 30,
              color: getNavItemColor(context, currentIndex, 1),
            ),
            Icon(
              Icons.rebase_edit,
              size: 25,
              color: getNavItemColor(context, currentIndex, 2),
            ),
          ],
          onTap: (index) {
            setState(() {
              currentIndex = index;
              _pageController.animateToPage(index,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.ease);
            });
          },
        ),
        body: PageView(
          //   physics: NeverScrollableScrollPhysics(),
          controller: _pageController,
          onPageChanged: (i) {
            setState(() {
              currentIndex = i;
            });
          },
          children: [
            BlocProvider<HabitBloc>(
              create: (context) => sl(),
              child: const TodoHabitListPage(),
            ),
            const CategoryListPage(),
            const MyHabitsListPage()
          ],
        ));
  }
}
