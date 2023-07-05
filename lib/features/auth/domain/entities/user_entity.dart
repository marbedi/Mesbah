import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../configs/config.dart';

class UserEntity {
  final String? id;
  final String? username;
  final String? fullName;
  final List<String>? habits;
  final int? score;
  final String? profilePicture;
  final String? follows;

  UserEntity(
      {this.id,
      this.username,
      this.fullName,
      this.habits,
      this.score,
      this.profilePicture,
      this.follows});

  UserEntity copyWith({
    String? id,
    String? username,
    String? fullName,
    List<String>? habits,
    int? score,
    String? profilePictures,
    String? follows,
  }) {
    return UserEntity(
      id: id ?? this.id,
      username: username ?? this.username,
      fullName: fullName ?? this.fullName,
      habits: habits ?? this.habits,
      score: score ?? this.score,
      profilePicture: profilePictures ?? this.profilePicture,
      follows: follows ?? this.follows,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'fullName': fullName,
      'habits': habits,
      'score': score,
      'profilePictures': profilePicture,
      'follows': follows,
    };
  }

  factory UserEntity.fromMap(Map<String, dynamic> map) {
    T isA<T>(k) => map[k] is T ? map[k] : throw ArgumentError.value(map[k], k);
    return UserEntity(
      id: isA<String?>('id'),
      username: isA<String?>('username'),
      fullName: isA<String?>('fullName'),
      habits: map['habits'] != null
          ? List<String>.from(isA<Iterable<String>>('habits'))
          : null,
      score: isA<int?>('score'),
      profilePicture: isA<String?>('profilePictures'),
      follows: isA<String?>('follows'),
    );
  }

  String toJson() => json.encode(toMap());

  factory UserEntity.fromJson(String source) =>
      UserEntity.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserEntity(id: $id, username: $username, fullName: $fullName, habits: $habits, score: $score, profilePictures: $profilePicture, follows: $follows)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserEntity &&
        other.id == id &&
        other.username == username &&
        other.fullName == fullName &&
        listEquals(other.habits, habits) &&
        other.score == score &&
        other.profilePicture == profilePicture &&
        other.follows == follows;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        username.hashCode ^
        fullName.hashCode ^
        habits.hashCode ^
        score.hashCode ^
        profilePicture.hashCode ^
        follows.hashCode;
  }
}

void createUser() async {
  await Supabase.initialize(
      url: config["supabase_url"], anonKey: config["supabase_anon_key"]);
  var supabase = Supabase.instance.client;

  supabase.from('user').insert(UserEntity(
        id: "1",
        follows: "2",
        fullName: "Full Name",
        username: "fullname",
        profilePicture: "https://google.com",
      ));
}
