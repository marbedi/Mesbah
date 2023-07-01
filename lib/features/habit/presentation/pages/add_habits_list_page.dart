import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:habit_tracker_moshtari/common/extensions/context.dart';
import 'package:habit_tracker_moshtari/common/extensions/string.dart';
import 'package:habit_tracker_moshtari/common/navigation/navigation_flow.dart';
import 'package:habit_tracker_moshtari/features/habit/domain/entities/category_entity.dart';

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
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: Text(
            'habits'.tr(),
            style: context.textTheme.labelMedium,
          ),
        ),
        body: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            itemBuilder: (context, index) {
              return HabitItem(
                index: index,
              );
            }));
  }
}
