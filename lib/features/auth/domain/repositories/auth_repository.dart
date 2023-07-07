import 'package:dartz/dartz.dart';

import '../../../../common/exceptions/exceptions.dart';
import '../../../../common/usecases/usecase.dart';
import '../entities/user_entity.dart';
import '../usecases/sign_in_with_email_use_case.dart';
// import '../../../habit.dart';

abstract class AuthRepository {
  Future<Either<Failure, UserEntity>> signInWithEmail(
      SignInWithEmailUseCaseParams param);
  Future<Either<Failure, UserEntity>> signUpWithEmail(
      {required String email, required String password});
  Future<Either<Failure, Nothing>> signInWithGoogle();
  Future<Either<Failure, Nothing>> signUpWithGoogle();
  Future<Either<Failure, Nothing>> signOut();
}
