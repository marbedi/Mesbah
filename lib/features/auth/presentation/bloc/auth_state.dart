part of 'auth_bloc.dart';

enum AuthStatus {
  loading,
  unknown,
  authenticated,
}

class AuthBlocState {
  final AuthStatus status;
  final String? error;

  AuthBlocState({this.status = AuthStatus.unknown, this.error});

  AuthBlocState copyWith({
    AuthStatus? status,
    String? error,
  }) {
    return AuthBlocState(
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }
}
