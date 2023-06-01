import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class WaterReminder {
  static Future remindHourly() async {

    const AndroidNotificationDetails androidNotificationDetails =
    AndroidNotificationDetails(
        'high_importance_channel_2', 'BeFit Water Notification Channel',
        importance: Importance.high, priority: Priority.max, playSound: true);

    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    var initializationSettingsAndroid = const AndroidInitializationSettings("@mipmap/ic_launcher");
    var initializationSettings = InitializationSettings(android: initializationSettingsAndroid);
    flutterLocalNotificationsPlugin.initialize(initializationSettings);

    await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()?.requestPermission();


    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.periodicallyShow(0, "Reminder to drink water", "Stay hydrated! Don't forget to sip on some H2O 💧", RepeatInterval.hourly, notificationDetails: androidNotificationDetails);
  }

  static Future cancel() async {
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    await flutterLocalNotificationsPlugin.cancelAll();
  }

  static Future<bool> isReminderActive() async {
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    final activeNotfs = await flutterLocalNotificationsPlugin.getActiveNotifications();
    if(activeNotfs.isEmpty) {
      return false;
    } else {
      return true;
    }
  }
}