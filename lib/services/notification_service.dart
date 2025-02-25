import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import '../models/schedule_model.dart';

class NotificationService {
  final FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initNotification() async {
    AndroidInitializationSettings initializationSettingsAndroid =
        const AndroidInitializationSettings('app_icon');

    var initializationSettingsIOS = DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
        onDidReceiveLocalNotification:
            (int id, String? title, String? body, String? payload) async {});

    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    await notificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse:
            (NotificationResponse notificationResponse) async {});
  }

  Future<void> scheduleNotification(Schedule schedule) async {
    if (!schedule.reminder) return;

    final notificationId = DateTime.now().millisecondsSinceEpoch.hashCode;

    await notificationsPlugin.zonedSchedule(
      notificationId,
      schedule.title,
      schedule.description,
      tz.TZDateTime.from(schedule.date, tz.local),
      NotificationDetails(
        android: AndroidNotificationDetails(
          'schedule_channel',
          'Schedule Notifications',
          channelDescription: 'Notifications for scheduled events',
          importance: Importance.max,
          priority: Priority.high,
        ),
        iOS: const DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
        ),
      ),
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );

    // Update the schedule with the notification ID
    schedule.notificationId = notificationId;
  }

  Future<void> cancelNotification(int notificationId) async {
    await notificationsPlugin.cancel(notificationId);
  }
}
