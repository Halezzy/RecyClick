import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tz;

class NotificacaoService {
  static final _plugin = FlutterLocalNotificationsPlugin();

  static Future<void> init() async {
    tz.initializeTimeZones();

    // Usa o novo ícone criado: ic_stat_notify.png
    const android = AndroidInitializationSettings('ic_stat_notify');
    const initSettings = InitializationSettings(android: android);

    await _plugin.initialize(initSettings);
  }

  static Future<void> agendarNotificacao({
    required int id,
    required String titulo,
    required String corpo,
    required DateTime dataHora,
  }) async {
    await _plugin.zonedSchedule(
      id,
      titulo,
      corpo,
      tz.TZDateTime.from(dataHora, tz.local),
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'reciclick_id',
          'Reciclick Notificações',
          channelDescription: 'Lembretes ecológicos do app Reciclick',
          icon: 'ic_stat_notify', // 👈 Referência ao ícone sem extensão
          importance: Importance.max,
          priority: Priority.high,
        ),
      ),
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.dateAndTime,
    );
  }
}
