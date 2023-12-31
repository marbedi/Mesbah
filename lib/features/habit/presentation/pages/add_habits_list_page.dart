import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mesbah/common/extensions/context.dart';
import 'package:mesbah/common/navigation/navigation_flow.dart';
import 'package:mesbah/common/utils/constants.dart';
import 'package:mesbah/features/habit/domain/entities/category_entity.dart';

import '../widgets/habit_item.dart';

class AddHabitsListPage extends StatelessWidget {
  const AddHabitsListPage({super.key, required this.c});
  final CategoryEntity c;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: IconButton(
              splashRadius: 20,
              onPressed: () {
                NavigationFlow.back();
              },
              icon: Icon(
                Icons.arrow_back,
                color: context.colorScheme.onBackground,
              )),
          actions: [
            Padding(
              padding: const EdgeInsets.only(
                left: 8.0,
                top: 5,
                bottom: 5,
              ),
              child: InkWell(
                onTap: () {
                  NavigationFlow.toHabitSources(c);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.source_rounded,
                      color: context.colorScheme.onBackground,
                      size: 20,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      'sources'.tr(),
                      style: context.textTheme.labelMedium,
                    )
                  ],
                ),
              ),
            ),
          ],
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: Text(
            'habits'.tr(),
            style: context.textTheme.labelMedium,
          ),
        ),
        body: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            itemCount: Constants.defaultHabits
                .where((element) => element.categoryId == c.id)
                .length,
            itemBuilder: (context, index) {
              final habit = Constants.defaultHabits
                  .where((element) => element.categoryId == c.id)
                  .toList()[index];
              return HabitItem(index: index, habit: habit);
            }));
  }
}
