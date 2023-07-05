import 'package:flutter/material.dart';
import 'package:habit_tracker_moshtari/common/extensions/context.dart';
import 'package:habit_tracker_moshtari/common/extensions/date.dart';
import 'package:habit_tracker_moshtari/common/extensions/string.dart';
import 'package:habit_tracker_moshtari/common/utils/constants.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

import '../../features/habit/domain/entities/habit_entity.dart';

class JalaliTableCalendar extends StatefulWidget {
  const JalaliTableCalendar({super.key, required this.habit});
  final HabitEntity habit;

  @override
  State<JalaliTableCalendar> createState() => _JalaliTableCalendarState();
}

class _JalaliTableCalendarState extends State<JalaliTableCalendar> {
  late Jalali _currentMonth;
  late List<Jalali> _visibleDates;
  getHabitScore(int current, int total) {
    double score = (current / total) * 4;
    int roundedScore = score.round();

    if (roundedScore > 4) {
      roundedScore = 4;
    } else if (roundedScore < 1) {
      roundedScore = 0;
    }
    return roundedScore;
  }

  getColorWithScore(int score) {
    if (score == 0) {
      return Colors.transparent;
    }
    if (score == 1) {
      return context.colorScheme.primary.withOpacity(0.3);
    }
    if (score == 2) {
      return context.colorScheme.primary.withOpacity(0.5);
    }
    if (score == 3) {
      return context.colorScheme.primary.withOpacity(0.8);
    }
    if (score == 4) {
      return context.colorScheme.primary;
    }
    return Colors.transparent;
  }

  @override
  void initState() {
    super.initState();
    _currentMonth = Jalali.now();
    _visibleDates = _getVisibleDates(_currentMonth);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildHeader(),
        _buildDaysName(),
        _buildCalendar(),
      ],
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          splashRadius: 20,
          icon: const Icon(Icons.chevron_left),
          onPressed: () {
            setState(() {
              if (_currentMonth.month == 1) {
                _currentMonth = _currentMonth.copy(month: 12);
                _currentMonth =
                    _currentMonth.copy(year: _currentMonth.year - 1);
              } else {
                _currentMonth =
                    _currentMonth.copy(month: _currentMonth.month - 1);
              }
              _visibleDates = _getVisibleDates(_currentMonth);
            });
          },
        ),
        Text(_getFormattedMonthYear(_currentMonth),
            style: context.textTheme.labelMedium),
        IconButton(
          splashRadius: 20,
          icon: const Icon(Icons.chevron_right),
          onPressed: () {
            setState(() {
              if (_currentMonth.month == 12) {
                _currentMonth = _currentMonth.copy(month: 1);
                _currentMonth =
                    _currentMonth.copy(year: _currentMonth.year + 1);
              } else {
                _currentMonth =
                    _currentMonth.copy(month: _currentMonth.month + 1);
              }
              _visibleDates = _getVisibleDates(_currentMonth);
            });
          },
        ),
      ],
    );
  }

  Widget _buildDaysName() {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: Constants.weekDays
            .map((e) => Text(
                  e,
                  style: context.textTheme.labelMedium!.copyWith(fontSize: 12),
                ))
            .toList());
  }

  Widget _buildCalendar() {
    return GridView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 1,
          crossAxisCount: 7,
          crossAxisSpacing: 0,
          mainAxisSpacing: 0),
      itemCount: _visibleDates.length,
      itemBuilder: (context, index) {
        Jalali date = _visibleDates[index];
        // bool isSelected = date.year == _selectedDate.year &&
        //     date.month == _selectedDate.month &&
        //     date.day == _selectedDate.day;
        Jalali firstDayOfMonth =
            Jalali(_currentMonth.year, _currentMonth.month, 1);
        int daysBeforeFirst = firstDayOfMonth.weekDay - 1;

        bool itsLastMonthDay = index < daysBeforeFirst;
        final habitScore = getHabitScore(
            widget.habit.completionDates
                .where((element) => element.isToday(date.toDateTime()))
                .length,
            widget.habit.period.dayStep);
        return Container(
          decoration: BoxDecoration(
              color: getColorWithScore(habitScore),
              borderRadius: BorderRadius.circular(10)),
          child: Center(
            child: Text(date.day.toString().toFarsiNumber(),
                style: context.textTheme.labelMedium!.copyWith(
                  fontSize: itsLastMonthDay ? 0 : 16,
                  color: habitScore == 0
                      ? context.colorScheme.onBackground
                      : context.colorScheme.onPrimary,
                )),
          ),
        );
      },
    );
  }

  List<Jalali> _getVisibleDates(Jalali month) {
    Jalali firstDayOfMonth = Jalali(month.year, month.month, 1);
    int daysBeforeFirst = firstDayOfMonth.weekDay - 1;

    Jalali startDate = firstDayOfMonth.addDays(daysBeforeFirst * -1);
    List<Jalali> visibleDates = [];
    for (int i = 0;
        i < getDaysInMonth(month.year, month.month) + daysBeforeFirst;
        i++) {
      visibleDates.add(startDate.addDays(i));
    }

    return visibleDates;
  }

  String _getFormattedMonthYear(Jalali month) {
    return '${month.formatter.mN} ${month.year}';
  }
}
