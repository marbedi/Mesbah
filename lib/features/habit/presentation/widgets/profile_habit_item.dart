import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:mesbah/common/extensions/context.dart';
import 'package:mesbah/common/extensions/string.dart';
import 'package:mesbah/common/navigation/navigation_flow.dart';
import 'package:mesbah/common/utils/constants.dart';
import 'package:mesbah/common/widgets/custom_alert_dialog.dart';
import 'package:mesbah/features/habit/domain/entities/habit_entity.dart';
import 'package:mesbah/features/habit/domain/usecases/delete_habit_use_case.dart';
import 'package:mesbah/features/habit/presentation/pages/my_habits_llist_page.dart';

import '../../../../locator.dart';
import '../pages/todo_habit_list_page.dart';

class ProfileHabitItem extends StatelessWidget {
  const ProfileHabitItem({
    super.key,
    required this.habit,
  });

  final HabitEntity habit;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: context.colorScheme.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
                child: Constants.habitIcons[habit.icon]
                    .image(width: 20, height: 20)),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  habit.title,
                  style: context.textTheme.labelMedium,
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.sync,
                      color: Colors.grey[400],
                      size: 15,
                    ),
                    Text(
                      habit.habitGoal.goalCompleted
                          ? ' completed'.tr()
                          : ' ${habit.currentDayStep}/${habit.period.dayStep}  ${'day'.tr()}'
                              .toFarsiNumber(),
                      style: context.textTheme.labelMedium!
                          .copyWith(fontSize: 11, color: Colors.grey[400]),
                    )
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.star,
                      color: Colors.grey[400],
                      size: 15,
                    ),
                    Text(
                      " ${habit.score..toString().toFarsiNumber()} امتیاز",
                      style: context.textTheme.labelMedium!
                          .copyWith(fontSize: 11, color: Colors.grey[400]),
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
