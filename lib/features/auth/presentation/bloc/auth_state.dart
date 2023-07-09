part of 'auth_bloc.dart';

enum AuthStatus {
  loading,
  unknown,
  authenticated,
  error,
}

class AuthBlocState {
  final AuthStatus status;
  final String? error;
  final UserEntity? userEntity;

  AuthBlocState({
    required this.status,
    this.error,
    this.userEntity,
  });

  AuthBlocState copyWith({
    AuthStatus? status,
    String? error,
    UserEntity? userEntity,
  }) {
    return AuthBlocState(
      status: status ?? this.status,
      error: error ?? this.error,
      userEntity: userEntity ?? this.userEntity,
    );
  }
}
