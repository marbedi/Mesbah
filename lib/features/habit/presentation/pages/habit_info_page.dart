import 'package:easy_localization/easy_localization.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:mesbah/common/extensions/context.dart';
import 'package:mesbah/common/extensions/string.dart';
import 'package:mesbah/common/navigation/navigation_flow.dart';
import 'package:mesbah/common/utils/constants.dart';
import 'package:mesbah/features/habit/domain/entities/habit_entity.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

import '../../../../common/widgets/jalali_table_calender.dart';
import '../widgets/chart_bar.dart';

class HabitInfoPage extends StatelessWidget {
  const HabitInfoPage({super.key, required this.habit});
  final HabitEntity habit;
  double calculateDateProgressValue(DateTime end, DateTime start) {
    final DateTime now = DateTime.now();
    final Duration totalDuration = end.difference(start);
    final Duration currentDuration = now.difference(start);
    double progress =
        currentDuration.inMilliseconds / totalDuration.inMilliseconds;
    progress = progress.clamp(0.0, 1.0);
    return progress;
  }

  double calculateGoalProgressValue(double start, double end, double current) {
    double range = end - start;

    double progress = (current - start) / range;

    progress = progress.clamp(0.0, 1.0);

    return progress;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        // leadingWidth: 40,
        leading: IconButton(
            splashRadius: 25,
            onPressed: () {
              NavigationFlow.back();
            },
            icon: Icon(
              Icons.arrow_back,
              color: context.colorScheme.onBackground,
            )),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Constants.habitIcons[habit.icon].image(width: 30, height: 30),
            const SizedBox(
              width: 5,
            ),
            Text(
              habit.title,
              style: context.textTheme.labelMedium,
            ),
            const SizedBox(
              width: 40,
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: double.infinity,
                child: Text(
                  habit.desc,
                  textAlign: TextAlign.center,
                  style: context.textTheme.labelMedium!
                      .copyWith(fontSize: 15, color: Colors.grey[600]),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              if (habit.longDesc != null)
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    habit.longDesc!,
                    textAlign: TextAlign.center,
                    style: context.textTheme.labelMedium!
                        .copyWith(fontSize: 15, color: Colors.grey[600]),
                  ),
                ),
              const SizedBox(
                height: 10,
              ),
              const Divider(),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${'start_date'.tr()}\n${habit.startDate.toJalali().formatFullDate()}',
                        style: context.textTheme.labelMedium!
                            .copyWith(fontSize: 12),
                      ),
                      Text(
                        '${'end_date'.tr()}\n${habit.endDate.toJalali().formatFullDate()}',
                        style: context.textTheme.labelMedium!
                            .copyWith(fontSize: 12),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: LinearProgressIndicator(
                      value: calculateDateProgressValue(
                          habit.endDate, habit.startDate),
                      minHeight: 20,
                    ),
                  ),
                ],
              ),
              if (habit.habitGoal.goalType == GoalType.integer) ...[
                const SizedBox(
                  height: 10,
                ),
                const Divider(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'target'.tr(),
                      style: context.textTheme.labelMedium,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${'current_step'.tr()} : ${habit.habitGoal.currentStep.toString().toFarsiNumber()} ${habit.habitGoal.unit}',
                          style: context.textTheme.labelMedium!
                              .copyWith(fontSize: 12),
                        ),
                        Text(
                          '${'target'.tr()} : ${habit.habitGoal.totalStep.toString().toFarsiNumber()} ${habit.habitGoal.unit}',
                          style: context.textTheme.labelMedium!
                              .copyWith(fontSize: 12),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: LinearProgressIndicator(
                        value: calculateGoalProgressValue(
                            0,
                            habit.habitGoal.totalStep.toDouble(),
                            habit.habitGoal.currentStep.toDouble()),
                        minHeight: 20,
                      ),
                    ),
                  ],
                ),
              ],
              const SizedBox(
                height: 10,
              ),
              const Divider(),
              JalaliTableCalendar(
                habit: habit,
              ),
              const SizedBox(
                height: 10,
              ),
              const Divider(),
              HabitBarChart()
            ],
          )),
    );
  }
}
