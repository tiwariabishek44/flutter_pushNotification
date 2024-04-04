import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class LocalNotifications {
  static final FlutterLocalNotificationsPlugin
      _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  static final onClickNotification = BehaviorSubject<String>();

// on tap on any notification
  static void onNotificationTap(NotificationResponse notificationResponse) {
    if (notificationResponse.actionId == 'yes_action') {
      LocalNotifications.showScheduleNotification(
          title: "Thisi",
          body: "This is a Periodic Notification",
          payload: "This is periodic data");

      log(" this is the reply action");
    } else if (notificationResponse.actionId == 'no_action') {
      log(" this is the cancle action");

      LocalNotifications.showScheduleNotification(
          title: "Thisi",
          body: "This is a Periodic Notification",
          payload: "This is periodic data");
    } else {
      log(" this is the no action");
    }
  }

// initialize the local notifications
  static Future init() async {
    // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    final DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings(
      onDidReceiveLocalNotification: (id, title, body, payload) => null,
    );
    final LinuxInitializationSettings initializationSettingsLinux =
        LinuxInitializationSettings(defaultActionName: 'Open notification');
    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsDarwin,
            linux: initializationSettingsLinux);
    _flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: onNotificationTap,
        onDidReceiveBackgroundNotificationResponse: onNotificationTap);
  }

  static int calculateTimeRemaining() {
    // Get the current time in the Nepali time zone
    var nepalTimeZone = tz.getLocation('Asia/Kathmandu'); // Nepali time zone
    var now = tz.TZDateTime.now(nepalTimeZone);

    // Define the target hour (22:00 or 10 PM)
    int targetHour = 16;

    // Calculate the difference in hours between now and the target hour
    int hoursRemaining;
    if (now.hour < targetHour) {
      hoursRemaining = targetHour - now.hour;
    } else {
      hoursRemaining = (24 - now.hour) + targetHour;
    }

    return hoursRemaining;
  }

  static Future<void> showScheduleNotification({
    required String title,
    required String body,
    required String payload,
  }) async {
    tz.initializeTimeZones();

    // Get the current time in the Nepali time zone
    var nepalTimeZone = tz.getLocation('Asia/Kathmandu'); // Nepali time zone
    var nowInNepal = tz.TZDateTime.now(nepalTimeZone);
    int remainingHours = calculateTimeRemaining();
    log("this is the remaning time ${remainingHours}");

//------------after the remaning hour 1
    await _flutterLocalNotificationsPlugin.zonedSchedule(
      1,
      "Hello Student",
      "Don't forget to order your meal! Order before ${remainingHours - 14} hours to ensure you don't miss today's menu. Time is running out!", // Updated notification message
      nowInNepal.add(Duration(seconds: 2)),
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'channel 3',
          'your channel name',
          channelDescription: 'your channel description',
          icon: '@mipmap/ic_launcher',
          importance: Importance.max,
          priority: Priority.high,
          ticker: 'ticker',
          playSound: true,
          largeIcon: DrawableResourceAndroidBitmap('@mipmap/ic_launcher'),
          styleInformation: BigPictureStyleInformation(
            DrawableResourceAndroidBitmap(
                '@mipmap/ic_launcher'), // Replace '@mipmap/food' with your large image asset path
            contentTitle: "Don't forget to order!",
            summaryText: 'Order before the deadline!', // Updated summary text
            htmlFormatContentTitle:
                true, // Enable HTML formatting for content title
            htmlFormatSummaryText:
                true, // Enable HTML formatting for summary text
          ),
          actions: <AndroidNotificationAction>[
            AndroidNotificationAction(
              'yes_action', // ID of the action
              'Make a Order', // Label of the action
              titleColor: Colors.red,
              showsUserInterface: true,
            ),
            AndroidNotificationAction(
              'no_action', // ID of the action
              'Cancle', // Label of the action
              titleColor: Colors.red,
              allowGeneratedReplies: true,

              showsUserInterface: true,
            ),
          ],
        ),
      ),

      androidScheduleMode: AndroidScheduleMode.exact,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      payload: payload,
    );
  }

  // close all the notifications available
  static Future cancelAll() async {
    await _flutterLocalNotificationsPlugin.cancelAll();
  }
}
