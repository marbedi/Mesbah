import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mesbah/features/habit/domain/usecases/get_habit_by_date.dart';
import 'package:mesbah/features/habit/presentation/bloc/my_habit_list_state.dart';
import 'package:mesbah/features/habit/presentation/bloc/todo_list_state.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

import '../../domain/entities/my_habits_search_filter.dart';
import '../../domain/usecases/get_all_habits_use_case.dart';
import 'online_habits_state.dart';

part 'habit_bloc_event.dart';
part 'habit_bloc_state.dart';

class HabitBloc extends Bloc<HabitBlocEvent, HabitBlocState> {
  final GetHabitByDateUseCase getHabitByDateUseCase;
  final GetAllHabitsUseCase getAllHabitsUseCase;
  HabitBloc(
      {required this.getHabitByDateUseCase, required this.getAllHabitsUseCase})
      : super(HabitBlocState(
            todoListStates: TodoListInitial(),
            myHabitListStates: MyHabitListInitial(),
            onlineHabitsStates: OnlineHabitsInitial())) {
    on<GetTodoListEvent>((event, emit) async {
      emit(state.copyWith(todoListStates: TodoListLoading()));
      final result = await getHabitByDateUseCase(event.date);
      result.fold(
          (l) => emit(state.copyWith(
              todoListStates: TodoListFailure(message: l.message))),
          (r) =>
              emit(state.copyWith(todoListStates: TodoListSuccess(habits: r))));
    });
    on<GetMyHabitsListEvent>((event, emit) async {
      emit(state.copyWith(myHabitListStates: MyHabitListLoading()));
      final result = await getAllHabitsUseCase(event.filter);
      result.fold(
        (l) => emit(state.copyWith(
            myHabitListStates: MyHabitListFailure(message: l.message))),
        (r) => emit(
          state.copyWith(
            myHabitListStates: MyHabitListSuccess(habits: r),
          ),
        ),
      );
    });
    on<GetAllOnlineHabitsEvent>((event, emit) async {
      emit(state.copyWith(myHabitListStates: MyHabitListLoading()));
      // final result = await getAllHabitsUseCase();
      // result.fold(
      //   (l) => emit(state.copyWith(
      //       myHabitListStates: MyHabitListFailure(message: l.message))),
      //   (r) => emit(
      //     state.copyWith(
      //       myHabitListStates: MyHabitListSuccess(habits: r),
      //     ),
      //   ),
      // );
    });
  }
}
