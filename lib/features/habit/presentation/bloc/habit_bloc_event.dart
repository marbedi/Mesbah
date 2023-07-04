part of 'habit_bloc_bloc.dart';

abstract class HabitBlocEvent extends Equatable {
  const HabitBlocEvent();

  @override
  List<Object> get props => [];
}

class GetTodoListEvent extends HabitBlocEvent {
  final Jalali date;
  const GetTodoListEvent({required this.date});
}
