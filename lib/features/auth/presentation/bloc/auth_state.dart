part of 'auth_bloc.dart';

enum AuthStatus { inital, loading, success, failure }

class AuthBlocState {
  final AuthStatus status;
  final String? error;
  final UserEntity? userEntity;

  AuthBlocState({
    this.status = AuthStatus.inital,
    this.error,
    this.userEntity,
  });

  AuthBlocState copyWith({
    AuthStatus Function()? status,
    String? Function()? error,
    UserEntity Function()? userEntity,
  }) {
    return AuthBlocState(
      status: status != null ? status() : this.status,
      error: error != null ? error() : this.error,
      userEntity: userEntity != null ? userEntity() : this.userEntity,
    );
  }
}
