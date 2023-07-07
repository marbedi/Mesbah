import 'package:dartz/dartz.dart';

import 'package:habit_tracker_moshtari/common/exceptions/exceptions.dart';
import 'package:habit_tracker_moshtari/common/extensions/future.dart';
import 'package:habit_tracker_moshtari/common/usecases/usecase.dart';

import '../../data/data_source/auth_remote_data_source.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/usecases/sign_in_with_email_use_case.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource dataSource;

  AuthRepositoryImpl({
    required this.dataSource,
  });
  @override
  Future<Either<Failure, UserEntity>> signInWithEmail(
      SignInWithEmailUseCaseParams param) async {
    return await dataSource.signInWithEmail(param).toEither();
  }

  @override
  Future<Either<Failure, Nothing>> signInWithGoogle() {
    // TODO: implement signInWithGoogle
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Nothing>> signOut() {
    // TODO: implement signOut
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, UserEntity>> signUpWithEmail(
      {required String email, required String password}) {
    // TODO: implement signUpWithEmail
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Nothing>> signUpWithGoogle() {
    // TODO: implement signUpWithGoogle
    throw UnimplementedError();
  }
}
