import 'package:dartz/dartz.dart';

import 'package:mesbah/common/exceptions/exceptions.dart';

import '../../../../common/usecases/usecase.dart';
import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

class SignUpWithEmailUseCase
    extends UseCase<UserEntity, SignUpWithEmailUseCaseParams> {
  final AuthRepository repository;

  SignUpWithEmailUseCase({required this.repository});
  @override
  Future<Either<Failure, UserEntity>> call(
      SignUpWithEmailUseCaseParams param) async {
    return await repository.signUpWithEmail(param);
  }
}

class SignUpWithEmailUseCaseParams {
  String email;
  String password;
  String username;
  String fullName;

  SignUpWithEmailUseCaseParams({
    required this.email,
    required this.password,
    required this.username,
    required this.fullName,
  });
}
