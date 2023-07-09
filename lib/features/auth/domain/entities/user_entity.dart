import 'dart:convert';

import 'package:collection/collection.dart';

class UserEntity {
  String? id;
  String? username;
  String? fullName;
  List<dynamic>? habits;
  int? score;
  String? profilePicture;
  int? follows;

  UserEntity({
    this.id,
    this.username,
    this.fullName,
    this.habits,
    this.score,
    this.profilePicture,
    this.follows,
  });

  @override
  String toString() {
    return 'UserEntity(id: $id, username: $username, fullName: $fullName, habits: $habits, score: $score, profilePicture: $profilePicture, follows: $follows)';
  }

  factory UserEntity.fromMap(Map<String, dynamic> data) => UserEntity(
        id: data['id'] as String?,
        username: data['username'] as String?,
        fullName: data['full_name'] as String?,
        habits: data['habits'] as List<dynamic>?,
        score: data['score'] as int?,
        profilePicture: data['profile_picture'] as String?,
        follows: data['follows'] as int?,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'username': username,
        'full_name': fullName,
        'habits': habits,
        'score': score,
        'profile_picture': profilePicture,
        'follows': follows,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [UserEntity].
  factory UserEntity.fromJson(String data) {
    return UserEntity.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [UserEntity] to a JSON string.
  String toJson() => json.encode(toMap());

  UserEntity copyWith({
    String? id,
    String? username,
    String? fullName,
    List<dynamic>? habits,
    int? score,
    String? profilePicture,
    int? follows,
  }) {
    return UserEntity(
      id: id ?? this.id,
      username: username ?? this.username,
      fullName: fullName ?? this.fullName,
      habits: habits ?? this.habits,
      score: score ?? this.score,
      profilePicture: profilePicture ?? this.profilePicture,
      follows: follows ?? this.follows,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! UserEntity) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      id.hashCode ^
      username.hashCode ^
      fullName.hashCode ^
      habits.hashCode ^
      score.hashCode ^
      profilePicture.hashCode ^
      follows.hashCode;
}
