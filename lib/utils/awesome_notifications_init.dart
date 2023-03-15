import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';

class AwesomeNotificationsInit {
  init() {
    AwesomeNotifications().initialize(
        // set the icon to null if you want to use the default app icon
        'resource://drawable/res_app_icon',
        [
          NotificationChannel(
            channelGroupKey: 'basic_channel_group',
            channelKey: 'basic_channel',
            channelName: 'Basic notifications',
            channelDescription: 'Notification channel for basic tests',
            defaultColor: Color(0xFF9D50DD),
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
  }

  notificationWalk(id) {
    AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: int.parse(id.toString()),
          channelKey: 'basic_channel',
          title: 'قدم شمار سلامت من',
          body: 'قدم شمار فعال است',
          locked: true,
          color: Colors.red,
          backgroundColor: Colors.grey,
          displayOnBackground: true,
          autoDismissible: false,
          fullScreenIntent: false,
          wakeUpScreen: false,
          criticalAlert: false,
          payload: {'walkNoti': 'true'},
          category: NotificationCategory.Reminder,
          displayOnForeground: true,
          customSound: "",
          showWhen: false,
          hideLargeIconOnExpand: false,
        ),
        actionButtons: [
          NotificationActionButton(
            key: "close",
            label: "متوقف کردن",
            showInCompactView: false,
            autoDismissible: true,
            buttonType: ActionButtonType.KeepOnTop,
            color: Colors.blue,
            isDangerousOption: false,
          ),
        ]);
  }

  notiCancel(id) async {
    await AwesomeNotifications().cancel(int.parse(id.toString()));
  }
}
