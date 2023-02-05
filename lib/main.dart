import 'package:befit_v2/screens/home/home_screen.dart';
import 'package:befit_v2/screens/onboard/onboard_screen.dart';
import 'package:befit_v2/utils/constants.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hive_flutter/adapters.dart';

import 'firebase_options.dart';

const AndroidNotificationChannel channel = AndroidNotificationChannel(
    "high_importance_channel", //id
    "BeFit Related Notification Channel", //title
    importance: Importance.high,
    playSound: true
);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform
  );
}

late Box appUserSettingsBox;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter().then((value) async {
    appUserSettingsBox = await Hive.openBox("appUserSettingsBox");
  });
  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform
  );
  if(kDebugMode) {
    FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(false);
    FirebaseCrashlytics.instance.deleteUnsentReports();
  } else {
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
  }

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
      AndroidFlutterLocalNotificationsPlugin>()?.requestPermission();

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true
  );
  runApp(const BeFitApp());
}


class BeFitApp extends StatelessWidget {
  const BeFitApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Axiforma',
        primaryColor: appUIPrimaryColor,
        colorScheme: ColorScheme.fromSwatch().copyWith(secondary: appUISecondaryColor),
      ),
      home: appUserSettingsBox.get("isFirstRun", defaultValue: true) ? const OnBoard() : const Home(),
    );
  }
}