import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';
import 'package:timezone/timezone.dart' as tz;

class NotificationApi {
  static final notification = FlutterLocalNotificationsPlugin();
  static final onNotification = BehaviorSubject<String>();
  static Future _notificationDetails() async {
    return const NotificationDetails(
        android: AndroidNotificationDetails('channel id', 'channel name',
            channelDescription: 'channel description',
            importance: Importance.max),
        iOS: IOSNotificationDetails());
  }

  static Future init({bool initScheduled = false}) async {
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iOS = IOSInitializationSettings();
    const initializationSettings =
        InitializationSettings(android: android, iOS: iOS);
    await notification.initialize(initializationSettings,
        onSelectNotification: (payload) async {
      onNotification.add(payload);
    });
  }

  static Future showNotification({
    int id = 0,
    String title = '',
    String body = '',
    String payload = '',
  }) async =>
      notification.show(id, title, body, await _notificationDetails(),
          payload: payload);

  static Future showScheduledNotification({
    int id = 0,
    String title,
    String body,
    String payload,
  }) async {
    await notification.zonedSchedule(id, title, body,
        schedule(const Time(4, 22, 0)), await _notificationDetails(),
        payload: payload,
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);
  }

  static tz.TZDateTime schedule(Time time) {
    final now = tz.TZDateTime.now(tz.UTC);
    final she = tz.TZDateTime(tz.UTC, now.year, now.month, now.day, time.hour,
        time.minute, time.second);
    return she.isBefore(now) ? she.add(const Duration(days: 1)) : she;
  }
}
