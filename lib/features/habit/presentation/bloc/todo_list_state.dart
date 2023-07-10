import 'package:equatable/equatable.dart';
import 'package:mesbah/features/habit/domain/entities/habit_entity.dart';

abstract class TodoListStates extends Equatable {
  @override
  List<Object> get props => [];
}

class TodoListInitial extends TodoListStates {}

class TodoListLoading extends TodoListStates {}

class TodoListFailure extends TodoListStates {
  final String message;
  TodoListFailure({required this.message});
}

class TodoListSuccess extends TodoListStates {
  final List<HabitEntity> habits;
  TodoListSuccess({required this.habits});
}
