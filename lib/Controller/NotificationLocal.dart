import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';

class NotificationLocal{
static final _notifications = FlutterLocalNotificationsPlugin();
static final onNotifications = BehaviorSubject<String?>();
static Future _notificationDetails()async{
  return NotificationDetails(
    android:  AndroidNotificationDetails(
      'channel id',
      'channel name',
      'channel description',
    ),
    iOS: IOSNotificationDetails(),
  );
}
static Future init ({bool iniScheduled = false}) async{
  final android = AndroidInitializationSettings('@ipmap/ic_launcher');
  final iOS = IOSInitializationSettings();
  final settings = InitializationSettings(android: android,iOS: iOS);
  await _notifications.initialize(settings,
    onSelectNotification: (payload)async{

    },
  );
}

static Future showNotification({
  int id = 0,
  String? title,
  String? body,
  String? payload,

})async => _notifications.show(id,
    title,
    body,
    await _notificationDetails(),
  payload: payload,
  );

static Future showScheduledNotification({
  int id = 0,
  String? title,
  String? body,
  String? payload,
  required DateTime scheduledDate,


})async => _notifications.zonedSchedule(
  id,
  title,
  body,
  tz.TZDateTime.from(scheduledDate,tz.local),
  await _notificationDetails(),
  payload: payload,
  androidAllowWhileIdle: true,
  uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
);
}

