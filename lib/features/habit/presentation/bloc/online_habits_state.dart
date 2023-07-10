import 'package:equatable/equatable.dart';

import '../../domain/entities/habit_entity.dart';

abstract class OnlineHabitsStates extends Equatable {
  @override
  List<Object> get props => [];
}

class OnlineHabitsInitial extends OnlineHabitsStates {}

class OnlineHabitsLoading extends OnlineHabitsStates {}

class OnlineHabitsFailure extends OnlineHabitsStates {
  final String message;
  OnlineHabitsFailure({required this.message});
}

class OnlineHabitsSuccess extends OnlineHabitsStates {
  final List<HabitEntity> habits;
  OnlineHabitsSuccess({required this.habits});
}
