import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:mesbah/common/usecases/usecase.dart';
import 'package:mesbah/features/auth/domain/usecases/get_user_data_use_case.dart';
import 'package:mesbah/features/auth/domain/usecases/sign_in_with_email_use_case.dart';

import '../../domain/entities/user_entity.dart';
import '../../domain/usecases/sign_up_with_email_use_case.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthBlocEvent, AuthBlocState> {
  final SignInWithEmailUseCase? signInWithEmailUseCase;
  final SignUpWithEmailUseCase? signUpWithEmailUseCase;
  final GetUserDataUseCase? getUserDataUseCase;

  AuthBloc({
    this.signInWithEmailUseCase,
    this.signUpWithEmailUseCase,
    this.getUserDataUseCase,
  }) : super(AuthBlocState()) {
    on<SignInRequestedEvent>(
      (event, emit) async {
        emit(state.copyWith(status: () => AuthStatus.loading));

        final result = await signInWithEmailUseCase!(
            SignInWithEmailUseCaseParams(
                email: event.email, password: event.password));

        result.fold(
            (l) => emit(
                  state.copyWith(
                    status: () => AuthStatus.failure,
                    error: () => l.toString(),
                  ),
                ),
            (r) => emit(state.copyWith(
                  status: () => AuthStatus.success,
                  userEntity: () => r,
                )));
      },
    );
    on<SignUpRequestedEvent>(
      (event, emit) async {
        emit(state.copyWith(status: () => AuthStatus.loading));

        final result = await signUpWithEmailUseCase!(
            SignUpWithEmailUseCaseParams(
                email: event.email,
                password: event.password,
                fullName: event.fullName,
                username: event.userame));

        result.fold(
            (l) => emit(
                  state.copyWith(
                    status: () => AuthStatus.failure,
                    error: () => l.toString(),
                  ),
                ),
            (r) => emit(state.copyWith(
                  status: () => AuthStatus.success,
                  userEntity: () => r,
                )));
      },
    );
    on<GetUserDataEvent>(
      (event, emit) async {
        emit(state.copyWith(status: () => AuthStatus.loading));

        final result =
            await getUserDataUseCase!(GetUserDataUseCaseParams(id: event.id));

        result.fold(
            (l) => emit(
                  state.copyWith(
                    status: () => AuthStatus.failure,
                    error: () => l.toString(),
                  ),
                ),
            (r) => emit(state.copyWith(
                  status: () => AuthStatus.success,
                  userEntity: () => r,
                )));
      },
    );
  }
}
