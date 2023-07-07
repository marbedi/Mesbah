import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:habit_tracker_moshtari/common/extensions/context.dart';
import 'package:habit_tracker_moshtari/common/extensions/string.dart';
import 'package:habit_tracker_moshtari/common/navigation/navigation_flow.dart';
import 'package:habit_tracker_moshtari/common/utils/constants.dart';
import 'package:habit_tracker_moshtari/common/widgets/custom_alert_dialog.dart';
import 'package:habit_tracker_moshtari/features/habit/domain/entities/habit_entity.dart';
import 'package:habit_tracker_moshtari/features/habit/domain/usecases/delete_habit_use_case.dart';
import 'package:habit_tracker_moshtari/features/habit/presentation/pages/my_habits_llist_page.dart';

import '../../../../locator.dart';
import '../pages/todo_habit_list_page.dart';

class MyHabitItem extends StatelessWidget {
  const MyHabitItem({super.key, required this.habit, required this.onTap});

  final HabitEntity habit;
  final Function() onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Slidable(
        key: ValueKey(habit.id),
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          extentRatio: 0.35,
          children: [
            IconButton(
                splashRadius: 20,
                onPressed: () async {
                  final result = await NavigationFlow.toCreateHabit(habit);
                  if (result != null && result) {
                    myHabitsListKey.currentState?.refresh();
                    todoHabitsList.currentState?.refresh();
                  }
                },
                icon: const Icon(
                  Icons.edit,
                  size: 25,
                )),
            const SizedBox(
              width: 10,
            ),
            IconButton(
                splashRadius: 20,
                onPressed: () async {
                  final delete = await showCustomAlertDialog(
                      context,
                      'delete_habit_dialog_title'.tr(),
                      'delete_habit_dialog_message'.tr());
                  if (delete) {
                    final either =
                        await locator<DeleteHabitUseCase>()(habit.id);
                    either.fold(
                        (l) =>
                            context.showMessage(l.message, SnackBarType.error),
                        (r) => myHabitsListKey.currentState?.refresh());
                  }
                },
                icon: const Icon(
                  Icons.delete,
                  color: Colors.red,
                )),
          ],
        ),
        child: Container(
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
                              ? 'completed'.tr()
                              : '${habit.currentDayStep}/${habit.period.dayStep}  ${'day'.tr()}'
                                  .toFarsiNumber(),
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
        ),
      ),
    );
  }
}
