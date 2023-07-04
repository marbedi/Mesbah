import 'package:easy_localization/easy_localization.dart' as t;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_tracker_moshtari/common/extensions/context.dart';
import 'package:habit_tracker_moshtari/common/extensions/date.dart';
import 'package:habit_tracker_moshtari/common/extensions/string.dart';
import 'package:habit_tracker_moshtari/common/utils/utils.dart';
import 'package:habit_tracker_moshtari/features/habit/presentation/bloc/habit_bloc_bloc.dart';
import 'package:habit_tracker_moshtari/features/habit/presentation/bloc/todo_list_state.dart';
import 'package:habit_tracker_moshtari/features/habit/presentation/widgets/todo_habit_item.dart';
import 'package:habit_tracker_moshtari/helper/date_helper.dart';
import 'package:lottie/lottie.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

import '../../../../common/gen/assets.gen.dart';
import '../../../../common/widgets/loading_widget.dart';
import '../widgets/date_list_items.dart';

final todoHabitsList = GlobalKey<_ListState>();

class TodoHabitListPage extends StatefulWidget {
  const TodoHabitListPage({super.key});

  @override
  State<TodoHabitListPage> createState() => _TodoHabitListPageState();
}

class _TodoHabitListPageState extends State<TodoHabitListPage> {
  ScrollController? _scrollController;
  ScrollController? _datesScrollController;
  bool lastStatus = true;
  double height = 200;

  late DateTime selectedDate;

  void _scrollListener() {
    if (_isShrink != lastStatus) {
      setState(() {
        lastStatus = _isShrink;
      });
    }
  }

  bool get _isShrink {
    return _scrollController != null &&
        _scrollController!.hasClients &&
        _scrollController!.offset > (height - kToolbarHeight);
  }

  @override
  void initState() {
    selectedDate = DateTime.now();
    _datesScrollController = ScrollController(
        initialScrollOffset: (DateHelper.daysOfMonth.indexWhere(
                    (element) => (element).isSameDate(selectedDate)) -
                2) *
            78.0);
    _scrollController = ScrollController()..addListener(_scrollListener);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: NestedScrollView(
          controller: _scrollController,
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [_Header(isShrink: _isShrink)];
          },
          body: CustomScrollView(
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.only(right: 5, top: 15, bottom: 10),
                sliver: SliverToBoxAdapter(
                  child: SizedBox(
                    height: 90.0,
                    child: ListView.builder(
                      controller: _datesScrollController,
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount: DateHelper.daysOfMonth.length,
                      itemBuilder: (context, index) {
                        final isSelected = DateHelper.daysOfMonth[index]
                            .isSameDate(selectedDate);
                        final isToday = DateTime.now()
                            .isSameDate(DateHelper.daysOfMonth[index]);

                        final day = DateHelper.daysOfMonth[index].toJalali();
                        return DateListItem(
                          isSelected: isSelected,
                          isToday: isToday,
                          day: day,
                          onTap: () {
                            setState(() {
                              selectedDate = day.toDateTime();
                            });
                            SchedulerBinding.instance.addPostFrameCallback((_) {
                              context.read<HabitBloc>().add(GetTodoListEvent(
                                  date: selectedDate.toJalali()));
                            });
                          },
                        );
                      },
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                  child: _List(
                date: selectedDate,
                key: todoHabitsList,
              ))
            ],
          )),
    ));
  }
}

class _List extends StatefulWidget {
  const _List({super.key, required this.date});
  final DateTime date;
  @override
  State<_List> createState() => _ListState();
}

class _ListState extends State<_List> {
  @override
  void initState() {
    context
        .read<HabitBloc>()
        .add(GetTodoListEvent(date: widget.date.toJalali()));
    super.initState();
  }

  void refresh() {
    context
        .read<HabitBloc>()
        .add(GetTodoListEvent(date: widget.date.toJalali()));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HabitBloc, HabitBlocState>(
      builder: (context, state) {
        if (state.todoListStates is TodoListLoading) {
          return const Center(child: LoadingWidget());
        }
        if (state.todoListStates is TodoListFailure) {
          Text(
            (state.todoListStates as TodoListFailure).message,
            style: context.textTheme.labelMedium,
          );
        }
        if (state.todoListStates is TodoListSuccess) {
          final list = (state.todoListStates as TodoListSuccess).habits;
          if (list.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset(Assets.animations.empty, height: 160),
                  Text(
                    'empty_habit_list_message'.tr(),
                    style: context.textTheme.labelMedium,
                  ),
                ],
              ),
            );
          }
          return ListView.builder(
              itemCount: list.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (c, i) => TodoHabitItem(habit: list[i]));
        }
        return const SizedBox();
      },
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({
    super.key,
    required bool isShrink,
  }) : _isShrink = isShrink;

  final bool _isShrink;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      title: _isShrink ? const _TimesWidget().animate().fadeIn() : null,
      pinned: true,
      // backgroundColor: context.colorScheme.primary,

      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20))),
      expandedHeight: 200,
      flexibleSpace: FlexibleSpaceBar(
          background: Container(
        padding: const EdgeInsets.all(10),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20)),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xffCE98DD),
              Color(0xff825AE3),
            ],
          ),
        ),
        child: Column(
          children: [
            const _TimesWidget(),
            Row(
              children: [
                Assets.images.quran.image(width: 150, height: 150),
                const SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: Text(
                    'وَلْیَعْفُوا وَلْیَصْفَحُوا أَلَا تُحِبُّونَ أَن یَغْفِرَ اللَّهُ لَکُمْ وَاللَّهُ غَفُورٌ رَّحِیمٌ (۲۲-نور)',
                    style: context.textTheme.labelMedium!
                        .copyWith(fontSize: 14, color: Colors.white),
                  ),
                )
              ],
            )
          ],
        ),
      )),
    );
  }
}

class _TimesWidget extends StatelessWidget {
  const _TimesWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: Center(
          child: Text(
            replaceFarsiNumber(
                t.DateFormat('dd MMM  yyyy ').format(DateTime.now())),
            style: context.textTheme.labelMedium!.copyWith(color: Colors.white),
            textDirection: TextDirection.ltr,
          ),
        )),
        const Icon(Icons.date_range, color: Colors.white),
        Expanded(
            child: Center(
          child: Text(
            replaceFarsiNumber(DateTime.now().toJalali().formatFullDate()),
            style: context.textTheme.labelMedium!.copyWith(color: Colors.white),
            textDirection: TextDirection.ltr,
          ),
        )),
      ],
    );
  }
}
