import 'dart:async';
import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:habit_tracker_moshtari/common/extensions/context.dart';
import 'package:habit_tracker_moshtari/common/extensions/string.dart';
import 'package:habit_tracker_moshtari/common/widgets/titled_dropdown.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

class HabitBarChart extends StatefulWidget {
  HabitBarChart({super.key});

  List<Color> get availableColors => const <Color>[Colors.red];

  final Color barBackgroundColor = Colors.white;
  final Color barColor = Colors.blue;
  final Color touchedBarColor = Colors.green;

  @override
  State<StatefulWidget> createState() => HabitBarChartState();
}

class HabitBarChartState extends State<HabitBarChart> {
  final Duration animDuration = const Duration(milliseconds: 250);

  int touchedIndex = -1;

  bool isPlaying = false;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                // const Text(
                //   '',
                //   style: TextStyle(
                //     color: Colors.green,
                //     fontSize: 24,
                //     fontWeight: FontWeight.bold,
                //   ),
                // ),
                // const SizedBox(
                //   height: 4,
                // ),
                // SizedBox(
                //   width: 100,
                //   child: TitledDropDown(
                //       name: 'year',
                //       title: '',
                //       initial: Jalali.now().year,
                //       items: List.generate(100, (index) {
                //         final year = index + 1400;
                //         return DropdownMenuItem(
                //           value: year,
                //           child: Center(
                //             child: Text(
                //               year.toString().toFarsiNumber(),
                //               style: context.textTheme.labelMedium,
                //             ),
                //           ),
                //         );
                //       })),
                // ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      splashRadius: 20,
                      icon: const Icon(Icons.chevron_left),
                      onPressed: () {},
                    ),
                    Text('1402'.toFarsiNumber(),
                        style: context.textTheme.labelMedium),
                    IconButton(
                      splashRadius: 20,
                      icon: const Icon(Icons.chevron_right),
                      onPressed: () {},
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: BarChart(
                      mainBarData(),
                      swapAnimationDuration: animDuration,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
              ],
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.all(8),
          //   child: Align(
          //     alignment: Alignment.topRight,
          //     child: IconButton(
          //       icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow,
          //           color: Colors.green),
          //       onPressed: () {
          //         setState(() {
          //           isPlaying = !isPlaying;
          //           if (isPlaying) {
          //             refreshState();
          //           }
          //         });
          //       },
          //     ),
          //   ),
          // )
        ],
      ),
    );
  }

  BarChartGroupData makeGroupData(
    int x,
    double y, {
    bool isTouched = false,
    Color? barColor,
    double width = 14,
    List<int> showTooltips = const [],
  }) {
    barColor ??= widget.barColor;
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: isTouched ? y + 1 : y,
          color:
              isTouched ? widget.touchedBarColor : context.colorScheme.primary,
          width: width,
          borderSide: isTouched
              ? BorderSide(color: Colors.grey)
              : const BorderSide(color: Colors.white, width: 0),
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            toY: 20,
            color: widget.barBackgroundColor,
          ),
        ),
      ],
      showingTooltipIndicators: showTooltips,
    );
  }

  List<BarChartGroupData> showingGroups() => List.generate(12, (i) {
        switch (i) {
          case 0:
            return makeGroupData(0, 5, isTouched: i == touchedIndex);
          case 1:
            return makeGroupData(1, 6.5, isTouched: i == touchedIndex);
          case 2:
            return makeGroupData(2, 5, isTouched: i == touchedIndex);
          case 3:
            return makeGroupData(3, 7.5, isTouched: i == touchedIndex);
          case 4:
            return makeGroupData(4, 9, isTouched: i == touchedIndex);
          case 5:
            return makeGroupData(5, 11.5, isTouched: i == touchedIndex);
          case 6:
            return makeGroupData(6, 6.5, isTouched: i == touchedIndex);
          case 7:
            return makeGroupData(7, 6.5, isTouched: i == touchedIndex);
          case 8:
            return makeGroupData(8, 6.5, isTouched: i == touchedIndex);
          case 9:
            return makeGroupData(9, 6.5, isTouched: i == touchedIndex);
          case 10:
            return makeGroupData(10, 6.5, isTouched: i == touchedIndex);
          case 11:
            return makeGroupData(11, 6.5, isTouched: i == touchedIndex);
          // case 12:
          //   return makeGroupData(6, 6.5, isTouched: i == touchedIndex);
          default:
            return throw Error();
        }
      });

  BarChartData mainBarData() {
    return BarChartData(
      barTouchData: BarTouchData(
        touchTooltipData: BarTouchTooltipData(
          tooltipBgColor: Colors.grey[200],
          tooltipHorizontalAlignment: FLHorizontalAlignment.right,
          tooltipMargin: -10,
          getTooltipItem: (group, groupIndex, rod, rodIndex) {
            String weekDay;
            switch (group.x) {
              case 0:
                weekDay = 'فروردین';
                break;
              case 1:
                weekDay = 'اردیبهشت';
                break;
              case 2:
                weekDay = 'خرداد';
                break;
              case 3:
                weekDay = 'تیر';
                break;
              case 4:
                weekDay = 'مرداد';
                break;
              case 5:
                weekDay = 'شهریور';
                break;
              case 6:
                weekDay = 'مهر';
                break;
              case 7:
                weekDay = 'آبان';
                break;
              case 8:
                weekDay = 'آذر';

                break;
              case 9:
                weekDay = 'دی';

                break;
              case 10:
                weekDay = 'بهمن';

                break;
              case 11:
                weekDay = 'اسفند';

                break;
              default:
                throw Error();
            }
            return BarTooltipItem(
              '$weekDay\n',
              context.textTheme.labelMedium!,
              children: <TextSpan>[
                TextSpan(
                    text: (rod.toY - 1).toString(),
                    style:
                        context.textTheme.labelMedium!.copyWith(fontSize: 12)),
              ],
            );
          },
        ),
        touchCallback: (FlTouchEvent event, barTouchResponse) {
          setState(() {
            if (!event.isInterestedForInteractions ||
                barTouchResponse == null ||
                barTouchResponse.spot == null) {
              touchedIndex = -1;
              return;
            }
            touchedIndex = barTouchResponse.spot!.touchedBarGroupIndex;
          });
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: getTitles,
            reservedSize: 38,
          ),
        ),
        leftTitles: const AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      barGroups: showingGroups(),
      gridData: const FlGridData(show: false),
    );
  }

  Widget getTitles(double value, TitleMeta meta) {
    final style = context.textTheme.labelMedium!.copyWith(fontSize: 8);
    Widget text;
    switch (value.toInt()) {
      case 0:
        text = Text('فروردین', style: style.copyWith(fontSize: 6));
        break;
      case 1:
        text = Text('اردیبهشت', style: style.copyWith(fontSize: 6));
        break;
      case 2:
        text = Text('خرداد', style: style);
        break;
      case 3:
        text = Text('تیر', style: style);
        break;
      case 4:
        text = Text('مرداد', style: style);
        break;
      case 5:
        text = Text('شهریور', style: style);
        break;
      case 6:
        text = Text('مهر', style: style);
        break;
      case 7:
        text = Text('آبان', style: style);
        break;
      case 8:
        text = Text('آذر', style: style);
        break;
      case 9:
        text = Text('دی', style: style);
        break;
      case 10:
        text = Text('بهمن', style: style);
        break;
      case 11:
        text = Text('اسفند', style: style);
        break;
      default:
        text = Text('', style: style);
        break;
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 16,
      child: text,
    );
  }

  Future<dynamic> refreshState() async {
    setState(() {});
    await Future<dynamic>.delayed(
      animDuration + const Duration(milliseconds: 50),
    );
    if (isPlaying) {
      await refreshState();
    }
  }
}
