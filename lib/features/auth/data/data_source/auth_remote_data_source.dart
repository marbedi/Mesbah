import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../common/usecases/usecase.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/usecases/get_user_data_use_case.dart';
import '../../domain/usecases/sign_in_with_email_use_case.dart';
import '../../domain/usecases/sign_up_with_email_use_case.dart';

abstract class AuthRemoteDataSource {
  Future<UserEntity> getUserData(GetUserDataUseCaseParams param);
  Future<UserEntity> signInWithEmail(SignInWithEmailUseCaseParams param);
  Future<UserEntity> signUpWithEmail(SignUpWithEmailUseCaseParams param);
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

    final user = await supabase.client
        .from("users")
        .select<Map<String, dynamic>>()
        .eq("id", response.user!.id)
        .single();

    UserEntity userEntity = UserEntity.fromMap(user);

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
  Future<UserEntity> signUpWithEmail(SignUpWithEmailUseCaseParams param) async {
    final response = await supabase.client.auth
        .signUp(email: param.email, password: param.password);

    UserEntity userEntity = UserEntity(
        id: response.user!.id,
        fullName: param.fullName,
        habits: <int>[0],
        username: param.username,
        follows: 1,
        profilePicture: "",
        score: 0);

    await supabase.client.from("users").insert(userEntity.toMap());

    return userEntity;
  }

  @override
  Future<Nothing> signUpWithGoogle() {
    // TODO: implement signUpWithGoogle
    throw UnimplementedError();
  }

  @override
  Future<UserEntity> getUserData(GetUserDataUseCaseParams param) async {
    // final user = await supabase.client.auth.admin.getUserById(param.id);

    final user = await supabase.client
        .from("users")
        .select<Map<String, dynamic>>()
        .eq("id", param.id)
        .single();

    final UserEntity userEntity = UserEntity.fromMap(user);
    return userEntity;
  }
}
