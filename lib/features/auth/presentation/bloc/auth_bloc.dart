import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_tracker_moshtari/common/usecases/usecase.dart';

import 'package:habit_tracker_moshtari/features/auth/domain/usecases/sign_in_with_email_use_case.dart';

import '../../domain/entities/user_entity.dart';
import '../../domain/usecases/sign_up_with_email_use_case.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthBlocEvent, AuthBlocState> {
  final SignInWithEmailUseCase? signInWithEmailUseCase;
  final SignUpWithEmailUseCase? signUpWithEmailUseCase;

  AuthBloc({
    this.signInWithEmailUseCase,
    this.signUpWithEmailUseCase,
  }) : super(AuthBlocState(status: AuthStatus.unknown)) {
    on<SignInRequestedEvent>(
      (event, emit) async {
        emit(state.copyWith(status: AuthStatus.loading));

        final result = await signInWithEmailUseCase!(
            SignInWithEmailUseCaseParams(
                email: event.email, password: event.password));

        result.fold(
            (l) => emit(
                  state.copyWith(
                    status: AuthStatus.error,
                    error: l.toString(),
                  ),
                ),
            (r) => emit(state.copyWith(
                  status: AuthStatus.authenticated,
                  userEntity: r,
                )));
      },
    );
    on<SignUpRequestedEvent>(
      (event, emit) async {
        emit(state.copyWith(status: AuthStatus.loading));

        final result = await signUpWithEmailUseCase!(
            SignUpWithEmailUseCaseParams(
                email: event.email,
                password: event.password,
                fullName: event.fullName,
                username: event.userame));

        result.fold(
            (l) => emit(
                  state.copyWith(
                    status: AuthStatus.error,
                    error: l.toString(),
                  ),
                ),
            (r) => emit(state.copyWith(
                  status: AuthStatus.authenticated,
                  userEntity: r,
                )));
      },
    );
  }
}
