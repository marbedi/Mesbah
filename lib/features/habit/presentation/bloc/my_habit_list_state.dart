import 'package:equatable/equatable.dart';
import 'package:habit_tracker_moshtari/features/habit/domain/entities/habit_entity.dart';

abstract class MyHabitListStates extends Equatable {
  @override
  List<Object> get props => [];
}

class MyHabitListInitial extends MyHabitListStates {}

class MyHabitListLoading extends MyHabitListStates {}

class MyHabitListFailure extends MyHabitListStates {
  final String message;
  MyHabitListFailure({required this.message});
}

class MyHabitListSuccess extends MyHabitListStates {
  final List<HabitEntity> habits;
  MyHabitListSuccess({required this.habits});
}
