// import 'package:flutter/widgets.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:rxdart/rxdart.dart';
// import 'package:timezone/timezone.dart' as tz;

// class NotificationApi {
//   static final notification = FlutterLocalNotificationsPlugin();
//   static final onNotification = BehaviorSubject<String>();
//   static Future _notificationDetails() async {
//     return const NotificationDetails(
//         android: AndroidNotificationDetails('channel id', 'channel name',
//             channelDescription: 'channel description',
//             importance: Importance.max),
//         iOS: IOSNotificationDetails());
//   }

//   static Future init({bool initScheduled = false}) async {
//     const android = AndroidInitializationSettings('@mipmap/ic_launcher');
//     const iOS = IOSInitializationSettings();
//     const initializationSettings =
//         InitializationSettings(android: android, iOS: iOS);
//     await notification.initialize(initializationSettings,
//         onSelectNotification: (payload) async {
//       onNotification.add(payload);
//     });
//   }

//   static Future showNotification({
//     int id = 0,
//     String title = '',
//     String body = '',
//     String payload = '',
//   }) async =>
//       notification.show(id, title, body, await _notificationDetails(),
//           payload: payload);

//   static Future showScheduledNotification({
//     int id = 0,
//     String title,
//     String body,
//     String payload,
//     @required int hours,
//     @required int minates,
//     int seconds,
//   }) async {
//     await notification.zonedSchedule(id, title, body,
//         schedule(Time(hours, minates, seconds)), await _notificationDetails(),
//         payload: payload,
//         androidAllowWhileIdle: true,
//         uiLocalNotificationDateInterpretation:
//             UILocalNotificationDateInterpretation.absoluteTime);
//   }

//   static tz.TZDateTime schedule(Time time) {
//     final now = tz.TZDateTime.now(tz.UTC);
//     final she = tz.TZDateTime(tz.UTC, now.year, now.month, now.day, time.hour,
//         time.minute, time.second);
//     return she.isBefore(now) ? she.add(const Duration(days: 1)) : she;
//   }
// }

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/widgets.dart';

import '../../../custom_transition/up_to_down.dart';

class NotificationApi {
  static void notify({
    @required String title,
    @required String body,
    @required String channelKey,
    bool locked = true,
    int id = 0,
    int notificationInterval = 86400,
  }) async {
    String timeZone = await AwesomeNotifications().getLocalTimeZoneIdentifier();
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
          id: id,
          channelKey: channelKey,
          title: title,
          body: body,
          criticalAlert: true,
          locked: locked,
          displayOnForeground: true),
      schedule: NotificationInterval(
          interval: notificationInterval,
          preciseAlarm: true,
          timeZone: timeZone,
          allowWhileIdle: true,
          repeats: true),
    );
  }

  static void cancelNotification(int id, {bool cancelAll = false}) async {
    cancelAll
        ? await AwesomeNotifications().cancelAll()
        : await AwesomeNotifications().cancel(id);
  }

  static void goToAzkarScreen(context, Widget screen) {
    AwesomeNotifications().actionStream.listen((event) {
      Navigator.push(context, UpToDown(screen));
    });
  }
}
