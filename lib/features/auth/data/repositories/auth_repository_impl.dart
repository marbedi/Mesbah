import 'package:dartz/dartz.dart';

import 'package:mesbah/common/exceptions/exceptions.dart';
import 'package:mesbah/common/extensions/future.dart';
import 'package:mesbah/common/usecases/usecase.dart';
import 'package:mesbah/features/auth/domain/usecases/get_user_data_use_case.dart';

import '../../data/data_source/auth_remote_data_source.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/usecases/sign_in_with_email_use_case.dart';
import '../../domain/usecases/sign_up_with_email_use_case.dart';

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
      SignUpWithEmailUseCaseParams param) async {
    return await dataSource.signUpWithEmail(param).toEither();
  }

  @override
  Future<Either<Failure, Nothing>> signUpWithGoogle() {
    // TODO: implement signUpWithGoogle
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, UserEntity>> getUserData(
      GetUserDataUseCaseParams params) async {
    return await dataSource.getUserData(params).toEither();
  }
}
