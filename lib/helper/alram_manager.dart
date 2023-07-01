// import 'package:flutter_animate/flutter_animate.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:flutter/material.dart';
// import 'dart:async';
// import 'package:timezone/data/latest.dart' as tzl;
// import 'package:timezone/standalone.dart' as tz;

// import '../main.dart';

// void notificationTapBackground(NotificationResponse notificationResponse) {
//   // ignore: avoid_print
//   print('notification(${notificationResponse.id}) action tapped: '
//       '${notificationResponse.actionId} with'
//       ' payload: ${notificationResponse.payload}');
//   if (notificationResponse.input?.isNotEmpty ?? false) {
//     // ignore: avoid_print
//     print(
//         'notification action tapped with input: ${notificationResponse.input}');
//   }
// }

// class AlarmManager {
//   late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

//   AlarmManager() {
//     flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
//     initializeNotifications();
//   }

//   Future<void> initializeNotifications() async {
//     const AndroidInitializationSettings initializationSettingsAndroid =
//         AndroidInitializationSettings('@mipmap/ic_launcher');

//     final InitializationSettings initializationSettings =
//         InitializationSettings(
//       android: initializationSettingsAndroid,
//     );
//     await flutterLocalNotificationsPlugin.initialize(initializationSettings,
//         onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
//         onDidReceiveNotificationResponse: notificationTapBackground);
//   }

//   Future<void> scheduleDailyAlarm() async {
//     const AndroidNotificationDetails androidPlatformChannelSpecifics =
//         AndroidNotificationDetails(
//       'alarm_channel_id',
//       'Alarm Channel',
//     );
//     const NotificationDetails platformChannelSpecifics =
//         NotificationDetails(android: androidPlatformChannelSpecifics);
//     await flutterLocalNotificationsPlugin.zonedSchedule(
//         0,
//         'Alarm',
//         'Time to wake up!',
//         tz.TZDateTime.now(tz.getLocation('Asia/Tehran')).add(1.seconds),
//         platformChannelSpecifics,
//         uiLocalNotificationDateInterpretation:
//             UILocalNotificationDateInterpretation.absoluteTime);
//   }

//   Future<void> onSelectNotification(String payload) async {
//     if (payload != null) {
//       debugPrint('Notification clicked with payload: $payload');
//     }
//   }
// }
