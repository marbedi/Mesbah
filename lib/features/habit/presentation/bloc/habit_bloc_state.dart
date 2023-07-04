part of 'habit_bloc_bloc.dart';

class HabitBlocState extends Equatable {
  final TodoListStates todoListStates;
  const HabitBlocState({required this.todoListStates});

  @override
  List<Object> get props => [todoListStates];

  HabitBlocState copyWith({TodoListStates? todoListStates}) =>
      HabitBlocState(todoListStates: todoListStates ?? this.todoListStates);
}
