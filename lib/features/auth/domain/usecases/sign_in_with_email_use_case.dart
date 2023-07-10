import 'package:dartz/dartz.dart';

import 'package:mesbah/common/exceptions/exceptions.dart';

import '../../../../common/usecases/usecase.dart';
import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

class SignInWithEmailUseCase
    extends UseCase<UserEntity, SignInWithEmailUseCaseParams> {
  final AuthRepository repository;

  SignInWithEmailUseCase({required this.repository});
  @override
  Future<Either<Failure, UserEntity>> call(
      SignInWithEmailUseCaseParams param) async {
    return await repository.signInWithEmail(param);
  }
}

class SignInWithEmailUseCaseParams {
  String email;
  String password;

  SignInWithEmailUseCaseParams({
    required this.email,
    required this.password,
  });
}
