import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:habit_tracker_moshtari/features/habit/domain/usecases/get_habit_by_date.dart';
import 'package:habit_tracker_moshtari/features/habit/presentation/bloc/todo_list_state.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

part 'habit_bloc_event.dart';
part 'habit_bloc_state.dart';

class HabitBloc extends Bloc<HabitBlocEvent, HabitBlocState> {
  final GetHabitByDateUseCase getHabitByDateUseCase;
  HabitBloc({required this.getHabitByDateUseCase})
      : super(HabitBlocState(todoListStates: TodoListInitial())) {
    on<GetTodoListEvent>((event, emit) async {
      emit(state.copyWith(todoListStates: TodoListLoading()));
      final result = await getHabitByDateUseCase(event.date);
      result.fold(
          (l) => emit(state.copyWith(
              todoListStates: TodoListFailure(message: l.message))),
          (r) =>
              emit(state.copyWith(todoListStates: TodoListSuccess(habits: r))));
    });
  }
}
