import 'dart:math';

import 'package:hive_flutter/hive_flutter.dart';
part 'reminder.g.dart';

@HiveType(typeId: 6)
class ReminderEntity {
  @HiveField(1)
  final String id;
  @HiveField(2)
  final DateTime time;
  @HiveField(3)
  final List<int> days;

  ReminderEntity({required this.id, required this.time, required this.days});

  ReminderEntity copyWith({
    String? id,
    DateTime? time,
    List<int>? days,
  }) {
    return ReminderEntity(
      id: id ?? this.id,
      time: time ?? this.time,
      days: days ?? this.days,
    );
  }
}

String generateRandomId(int length) {
  const chars = '0123456789';
  final random = Random();
  final id = StringBuffer();

  for (var i = 0; i < length; i++) {
    final index = random.nextInt(chars.length);
    id.write(chars[index]);
  }

  return id.toString();
}
