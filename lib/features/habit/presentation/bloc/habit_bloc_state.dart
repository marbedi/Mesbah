part of 'habit_bloc_bloc.dart';

class HabitBlocState extends Equatable {
  final TodoListStates todoListStates;
  final MyHabitListStates myHabitListStates;
  final OnlineHabitsStates onlineHabitsStates;
  const HabitBlocState(
      {required this.todoListStates,
      required this.myHabitListStates,
      required this.onlineHabitsStates});

  @override
  List<Object> get props =>
      [todoListStates, myHabitListStates, onlineHabitsStates];

  HabitBlocState copyWith(
          {TodoListStates? todoListStates,
          MyHabitListStates? myHabitListStates,
          OnlineHabitsStates? onlineHabitsStates}) =>
      HabitBlocState(
          todoListStates: todoListStates ?? this.todoListStates,
          myHabitListStates: myHabitListStates ?? this.myHabitListStates,
          onlineHabitsStates: onlineHabitsStates ?? this.onlineHabitsStates);
}
