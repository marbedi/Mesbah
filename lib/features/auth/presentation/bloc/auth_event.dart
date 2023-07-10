part of 'auth_bloc.dart';

abstract class AuthBlocEvent extends Equatable {
  const AuthBlocEvent();

  @override
  List<Object> get props => [];
}

class SignInRequestedEvent extends AuthBlocEvent {
  final String email;
  final String password;

  const SignInRequestedEvent({required this.email, required this.password});
}

class SignUpRequestedEvent extends AuthBlocEvent {
  final String email;
  final String password;
  final String userame;
  final String fullName;

  const SignUpRequestedEvent({
    required this.email,
    required this.password,
    required this.userame,
    required this.fullName,
  });
}

class GetCurrentUserDataEvent extends AuthBlocEvent {}

class GetUserDataEvent extends AuthBlocEvent {
  final String id;

  const GetUserDataEvent({required this.id});
}
