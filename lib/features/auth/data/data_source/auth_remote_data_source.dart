import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../common/usecases/usecase.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/usecases/sign_in_with_email_use_case.dart';

abstract class AuthRemoteDataSource {
  Future<UserEntity> getUser({required String id});
  Future<UserEntity> signInWithEmail(SignInWithEmailUseCaseParams param);
  Future<UserEntity> signUpWithEmail(
      {required String email, required String password});
  Future<Nothing> signInWithGoogle();
  Future<Nothing> signUpWithGoogle();
  Future<Nothing> signOut();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Supabase supabase;

  AuthRemoteDataSourceImpl({required this.supabase});
  @override
  Future<UserEntity> signInWithEmail(SignInWithEmailUseCaseParams param) async {
    final response = await supabase.client.auth
        .signInWithPassword(email: param.email, password: param.password);

    UserEntity userEntity = UserEntity.fromJson(supabase.client
        .from("user")
        .select()
        .eq("id", response.user!.id)
        .toString());

    return userEntity;
  }

  @override
  Future<Nothing> signInWithGoogle() {
    // TODO: implement signInWithGoogle
    throw UnimplementedError();
  }

  @override
  Future<Nothing> signOut() {
    // TODO: implement signOut
    throw UnimplementedError();
  }

  @override
  Future<UserEntity> signUpWithEmail(
      {required String email, required String password}) async {
    final response = await supabase.client.auth
        .signInWithPassword(email: email, password: password);

    UserEntity userEntity = UserEntity.fromJson(supabase.client
        .from("user")
        .select()
        .eq("id", response.user!.id)
        .toString());

    return userEntity;
  }

  @override
  Future<Nothing> signUpWithGoogle() {
    // TODO: implement signUpWithGoogle
    throw UnimplementedError();
  }

  @override
  Future<UserEntity> getUser({required String id}) {
    // TODO: implement getUserData
    throw UnimplementedError();
  }
}
