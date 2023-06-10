import 'package:flutter/material.dart';
import 'package:notificaciones_push_flutter/my_app.dart';

import 'services/push_notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PushNotificationService.initApp();

  runApp(const MyApp());
}
