import 'dart:math';

import 'package:easy_localization/easy_localization.dart' as t;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:habit_tracker_moshtari/common/extensions/context.dart';
import 'package:habit_tracker_moshtari/common/extensions/date.dart';
import 'package:habit_tracker_moshtari/common/extensions/string.dart';
import 'package:habit_tracker_moshtari/common/navigation/navigation_flow.dart';
import 'package:habit_tracker_moshtari/common/utils/utils.dart';
import 'package:habit_tracker_moshtari/features/habit/domain/entities/habit_entity.dart';
import 'package:habit_tracker_moshtari/features/habit/domain/usecases/complete_habit_use_case.dart';
import 'package:habit_tracker_moshtari/features/habit/presentation/bloc/habit_bloc_bloc.dart';
import 'package:habit_tracker_moshtari/features/habit/presentation/bloc/todo_list_state.dart';
import 'package:habit_tracker_moshtari/features/habit/presentation/widgets/todo_habit_item.dart';
import 'package:habit_tracker_moshtari/helper/date_helper.dart';
import 'package:habit_tracker_moshtari/helper/validator.dart';
import 'package:lottie/lottie.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

import '../../../../common/gen/assets.gen.dart';
import '../../../../common/utils/constants.dart';
import '../../../../common/widgets/loading_widget.dart';
import '../../../../locator.dart';
import '../widgets/date_list_items.dart';

final todoHabitsList = GlobalKey<_ListState>();
final goalFormKey = GlobalKey<FormBuilderState>();

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
      buildWhen: (previous, current) =>
          previous.todoListStates != current.todoListStates,
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
              itemBuilder: (c, i) {
                final habit = list[i];

                return TodoHabitItem(
                  habit: habit,
                  onTap: () {
                    NavigationFlow.toHabitInfo(habit);
                  },
                  isToday: widget.date.isToday(),
                  onCheckTap: () async {
                    var either;
                    if (habit.habitGoal.goalType == GoalType.integer) {
                      final value = await showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          builder: (c) => GoalInputBottomSheet(
                                habit: habit,
                                c: c,
                              ));
                      if (value != null) {
                        either = await sl<CompleteHabitUseCase>()(
                            CompleteHabitUseCaseParams(
                          id: habit.id,
                          value: int.parse(value),
                        ));
                      }
                    } else {
                      either = await sl<CompleteHabitUseCase>()(
                          CompleteHabitUseCaseParams(
                        id: habit.id,
                      ));
                    }
                    either.fold(
                        (l) =>
                            context.showMessage(l.message, SnackBarType.error),
                        (r) => todoHabitsList.currentState?.refresh());
                  },
                );
              });
        }
        return const SizedBox();
      },
    );
  }
}

class GoalInputBottomSheet extends StatelessWidget {
  GoalInputBottomSheet({super.key, required this.habit, required this.c});
  final BuildContext c;
  final HabitEntity habit;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      margin: EdgeInsets.only(bottom: MediaQuery.of(c).viewInsets.bottom),
      child: FormBuilder(
        key: goalFormKey,
        child: Row(
          children: [
            Expanded(
              child: FormBuilderTextField(
                name: 'value',
                decoration: InputDecoration(
                    isDense: false,
                    errorStyle: context.textTheme.labelSmall!.copyWith(
                      color: context.colorScheme.error,
                    ),
                    contentPadding: const EdgeInsets.all(5),
                    hintStyle: context.textTheme.labelMedium!
                        .copyWith(color: Colors.grey[400]),
                    hintText: habit.habitGoal.unit ?? ''),
                style: context.textTheme.labelMedium,
                validator: Validator.required(),
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            IconButton(
                splashRadius: 25,
                onPressed: () {
                  if (goalFormKey.currentState!.saveAndValidate()) {
                    NavigationFlow.back(
                        goalFormKey.currentState?.value['value']);
                  }
                },
                icon: Icon(
                  Icons.check,
                  color: context.colorScheme.onBackground,
                ))
          ],
        ),
      ),
    );
  }
}

class _Header extends StatefulWidget {
  const _Header({
    super.key,
    required bool isShrink,
  }) : _isShrink = isShrink;

  final bool _isShrink;

  @override
  State<_Header> createState() => _HeaderState();
}

class _HeaderState extends State<_Header> {
  String getVers(bool showMeaning) {
    final keys = Constants.quranVerses.keys.toList();
    final randomKey = keys[randomNumber];
    return showMeaning ? Constants.quranVerses[randomKey] as String : randomKey;
  }

  @override
  void initState() {
    randomNumber = Random().nextInt(Constants.quranVerses.keys.length);
    super.initState();
  }

  bool showMeaning = false;
  int randomNumber = 0;
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      title: widget._isShrink ? const _TimesWidget().animate().fadeIn() : null,
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
                Flexible(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        showMeaning = !showMeaning;
                      });
                    },
                    child: Text(
                      getVers(showMeaning).toFarsiNumber(),
                      style: context.textTheme.labelMedium!
                          .copyWith(fontSize: 14, color: Colors.white),
                    ),
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
