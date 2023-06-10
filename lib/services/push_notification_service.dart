import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationService {
  static StreamController<String> _msjStream = new StreamController.broadcast();
  static FirebaseMessaging messaging = FirebaseMessaging.instance;

  static Stream<String> get messagesStream => _msjStream.stream;

  static String? token;
  static Future initApp() async {
    await Firebase.initializeApp();
    token = await FirebaseMessaging.instance.getToken();
    print('TOKEN Firebase: $token');

    FirebaseMessaging.onBackgroundMessage(_backgroundController);
    FirebaseMessaging.onMessage.listen(_onMsjController);
    FirebaseMessaging.onMessageOpenedApp.listen(_onMsjOpenApp);
  }

  static Future _backgroundController(RemoteMessage msj) async {
    print('Estado BACKGROUND segundo plano');
    _msjStream.add(msj.notification?.body ?? 'No body');
  }

  static Future _onMsjController(RemoteMessage msj) async {
    print('Estado FOREGROUND abierta');
    //print('MENSAJE NOTIFICACION ${msj.messageId}');
    print('MENSAJE TITULO ${msj.notification?.title}');
    _msjStream.add(msj.notification?.body ?? 'No body');
    _msjStream.add(msj.data['usuario'] ?? 'No hay datos');
    print('MENSAJE DATOS-DATA dato adicionales: ${msj.data}');
  }

  static Future _onMsjOpenApp(RemoteMessage msj) async {
    print('Estado OPEN APP cerrada');
    _msjStream.add(msj.notification?.body ?? 'No body');
  }

  static closedStreams() {
    _msjStream.close();
  }
}
