import 'dart:async';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';

Future<void> initializeNotificationService() async {
  AwesomeNotifications().initialize(
// set the icon to null if you want to use the default app icon
      'resource://drawable/res_app_icon',
      [
        NotificationChannel(
          channelGroupKey: 'basic_channel_group',
          channelKey: 'basic_channel',
          channelName: 'Basic notifications',
          channelDescription: 'Notification channel for basic tests',
          defaultColor: Colors.red,
          icon: 'resource://drawable/res_app_icon',
          ledColor: Colors.white,
        )
      ],

// Channel groups are only visual and are not required
      channelGroups: [
        NotificationChannelGroup(
            channelGroupkey: 'basic_channel_group',
            channelGroupName: 'Basic group')
      ],
      debug: true);

  AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
    if (!isAllowed) {
      // This is just a basic example. For real apps, you must show some
      // friendly dialog box before call the request method.
      // This is very important to not harm the user experience
      AwesomeNotifications().requestPermissionToSendNotifications();
    }
  });
}

/////////////////////////

Future<void> createPedometerNotification() async {
  await AwesomeNotifications().createNotification(
    content: NotificationContent(
      id: 1,
      channelKey: 'basic_channel',
      title: '${Emojis.person_activity_person_walking} قدم‌شمار سلامت من ',
      body: 'قدم شما فعاله',
      notificationLayout: NotificationLayout.BigText,
      displayOnBackground: true,
      displayOnForeground: true,
      locked: true,
      color: Colors.indigo,
      backgroundColor: Colors.green,
    ),
    actionButtons: [
      NotificationActionButton(
        key: 'CloseNotification',
        label: 'متوقف کردن',
      )
    ],
  );
}
