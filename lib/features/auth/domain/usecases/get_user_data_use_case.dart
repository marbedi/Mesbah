import 'package:dartz/dartz.dart';

import 'package:mesbah/common/exceptions/exceptions.dart';

import '../../../../common/usecases/usecase.dart';
import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

class GetUserDataUseCase extends UseCase<UserEntity, GetUserDataUseCaseParams> {
  final AuthRepository repository;

  GetUserDataUseCase({required this.repository});
  @override
  Future<Either<Failure, UserEntity>> call(
      GetUserDataUseCaseParams param) async {
    return await repository.getUserData(param);
  }
}

class GetUserDataUseCaseParams {
  String id;

  GetUserDataUseCaseParams({
    required this.id,
  });
}
