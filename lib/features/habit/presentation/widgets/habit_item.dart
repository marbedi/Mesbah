import 'package:flutter/material.dart';
import 'package:mesbah/common/extensions/context.dart';
import 'package:mesbah/common/extensions/string.dart';
import 'package:mesbah/common/navigation/navigation_flow.dart';
import 'package:mesbah/features/habit/domain/entities/habit_entity.dart';

class HabitItem extends StatelessWidget {
  const HabitItem({super.key, required this.index, required this.habit});
  final int index;
  final HabitEntity habit;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(15)),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
      child: Row(
        children: [
          Text(
            (index + 1).toString().toFarsiNumber(),
            style: context.textTheme.labelMedium,
          ),
          const SizedBox(
            width: 20,
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
                ),
              ],
            ),
          ),
          Material(
            type: MaterialType.transparency,
            child: InkWell(
              customBorder: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              onTap: () {
                NavigationFlow.toCreateHabit(habit);
              },
              child: Ink(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: context.colorScheme.primary,
                    borderRadius: BorderRadius.circular(15)),
                child: const Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
