import 'dart:math';

import 'package:flutter/material.dart';

class ReminderEntity {
  final String? id;
  final TimeOfDay time;
  final List<int> days;

  ReminderEntity({this.id, required this.time, required this.days});
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
