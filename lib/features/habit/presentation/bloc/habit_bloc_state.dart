part of 'habit_bloc_bloc.dart';

class HabitBlocState extends Equatable {
  final TodoListStates todoListStates;
  final MyHabitListStates myHabitListStates;
  const HabitBlocState(
      {required this.todoListStates, required this.myHabitListStates});

  @override
  List<Object> get props => [todoListStates, myHabitListStates];

  HabitBlocState copyWith(
          {TodoListStates? todoListStates,
          MyHabitListStates? myHabitListStates}) =>
      HabitBlocState(
          todoListStates: todoListStates ?? this.todoListStates,
          myHabitListStates: myHabitListStates ?? this.myHabitListStates);
}
