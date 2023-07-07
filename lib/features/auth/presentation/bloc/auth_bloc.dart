import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_tracker_moshtari/features/auth/domain/usecases/sign_in_with_email_use_case.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthBlocEvent, AuthBlocState> {
  final SignInWithEmailUseCase signInWithEmailUseCase;

  AuthBloc({required this.signInWithEmailUseCase})
      : super(AuthBlocState(status: AuthStatus.unknown)) {
    on<SignInRequestedEvent>(
      (event, emit) async {
        emit(state.copyWith(status: AuthStatus.loading));

        final result = await signInWithEmailUseCase(
            SignInWithEmailUseCaseParams(
                email: event.email, password: event.password));

        result.fold((l) => print("Error"), (r) => print("aaaliiii"));
      },
    );
  }
}
