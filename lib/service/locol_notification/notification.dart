import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
class LocalNotificationService {
  static final LocalNotificationService localNotificationService =
  LocalNotificationService._();

  factory LocalNotificationService() {
    return localNotificationService;
  }

  LocalNotificationService._();

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  void init(GlobalKey<NavigatorState> navigatorKey) {
    // Android
    const AndroidInitializationSettings androidInitializationSettings =
    AndroidInitializationSettings("img");

    //IOS
    final DarwinInitializationSettings initializationSettingsDarwin =
    DarwinInitializationSettings(
      onDidReceiveLocalNotification: onDidReceiveLocalNotification,
    );

    //Set
    InitializationSettings initializationSettings = InitializationSettings(
      android: androidInitializationSettings,
      iOS: initializationSettingsDarwin,
    );

    flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      // onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
      onDidReceiveNotificationResponse: (
          NotificationResponse notificationResponse,
          ) {
        //Android
        if (notificationResponse.payload != null) {
          Navigator.push(navigatorKey.currentContext!,
              MaterialPageRoute(builder: (context) {
                return Scaffold();
              }));

          debugPrint('PAYLOAD RESULT------> ${notificationResponse.payload}');
        } else {
          print("PAYLOAD RESULT NULL");
        }
      },
    );

    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.requestPermission();
    tz.initializeTimeZones();
  }

  @pragma('vm:entry-point')
  void notificationTapBackground(NotificationResponse notificationResponse) {
    print("TAPPED FROM BACKGROUND");
  }

// Android

  //IOS
  void onDidReceiveLocalNotification(
      int id,
      String? title,
      String? body,
      String? payload,
      ) async {
    print(payload);
  }

  //channel
  AndroidNotificationChannel androidNotificationChannel =
  const AndroidNotificationChannel(
    "my_channel",
    "Notification Lesson ",
    importance: Importance.max,
    description: "My Notification description",
  );

  void showNotification({
    required int id,
    required title,
    String subtitle="",
  }) {
    flutterLocalNotificationsPlugin.show(
      id,
      subtitle.isEmpty?"Someone":title,
      subtitle.isEmpty?"Hello $title":subtitle,
      NotificationDetails(
        android: AndroidNotificationDetails(
          androidNotificationChannel.id,
          androidNotificationChannel.name,
          priority: Priority.max,
          playSound: true,
          icon: "img",
          showProgress: true,
          largeIcon: const DrawableResourceAndroidBitmap('img'),
        ),
      ),
      payload: "SIMPLE NOTIFICATION DATA ID:$id",
    );
  }

  void scheduleNotification({required int id, required int delayedTime}) async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      "scheduleNotification ID:$id",
      "EXAMPLE",
      tz.TZDateTime.now(tz.local).add(Duration(seconds: delayedTime)),
      NotificationDetails(
        android: AndroidNotificationDetails(
          androidNotificationChannel.id,
          androidNotificationChannel.name,
          channelDescription: 'To remind you about upcoming birthdays',
        ),
      ),
      payload: "SCHEADULED NOTIFICATION PAYLOAD DATA ID:$id",
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
      UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  void showPeriodically({required int id}) async {
    await flutterLocalNotificationsPlugin.periodicallyShow(
      id,
      'Bu notification',
      'Rostan notification',
      RepeatInterval.everyMinute,
      NotificationDetails(
        android: AndroidNotificationDetails(
          androidNotificationChannel.id,
          androidNotificationChannel.name,
          channelDescription: 'To remind you about upcoming birthdays',
        ),
      ),
      androidAllowWhileIdle: true,
      payload: "PERIODICALLY NOTIFICACYION DATA ID:$id",
    );
  }

  void cancelAllNotifications() {
    flutterLocalNotificationsPlugin.cancelAll();
  }

  void cancelNotificationById(int id) {
    flutterLocalNotificationsPlugin.cancel(id);
  }
}