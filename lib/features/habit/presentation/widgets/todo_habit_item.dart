import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:habit_tracker_moshtari/common/extensions/context.dart';
import 'package:habit_tracker_moshtari/common/gen/assets.gen.dart';
import 'package:habit_tracker_moshtari/common/widgets/circle_progress.dart';
import 'package:habit_tracker_moshtari/features/habit/domain/entities/habit_entity.dart';

class TodoHabitItem extends StatelessWidget {
  const TodoHabitItem({
    super.key,
    required this.habit,
  });

  final HabitEntity habit;
  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: const ValueKey(0),
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        extentRatio: 0.24,
        children: [
          IconButton(
              splashRadius: 20,
              onPressed: () {},
              icon: const Icon(
                Icons.check_rounded,
                size: 30,
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
        height: 60,
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
                  child: Assets.icons.television.image(width: 20, height: 20)),
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
                Text(
                  habit.desc,
                  style: context.textTheme.labelSmall,
                )
              ],
            )),
            CircleProgress(
              currentStep: habit.habitGoal.currentStep,
              totalSteps: habit.habitGoal.totalStep,
            ),
          ],
        ),
      ),
    );
  }
}
