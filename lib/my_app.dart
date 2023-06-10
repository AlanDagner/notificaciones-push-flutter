import 'package:flutter/material.dart';
import 'package:notificaciones_push_flutter/screens/home.dart';
import 'package:notificaciones_push_flutter/screens/message_screen.dart';
import 'package:notificaciones_push_flutter/services/push_notification_service.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GlobalKey<NavigatorState> navigatorKey =
      new GlobalKey<NavigatorState>();
  final GlobalKey<ScaffoldMessengerState> scaffoldKey =
      new GlobalKey<ScaffoldMessengerState>();

  @override
  void initState() {
    super.initState();
    PushNotificationService.messagesStream.listen((mensaje) {
      print('------------DESDE MYAP mensaje: $mensaje');

      navigatorKey.currentState?.pushNamed('/mensaje', arguments: mensaje);

      final snackBar =
          SnackBar(content: Text('Razon: $mensaje'));
      scaffoldKey.currentState?.showSnackBar(snackBar);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Notificaciones push',
      initialRoute: '/home',
      scaffoldMessengerKey: scaffoldKey,
      navigatorKey: navigatorKey,
      routes: {
        '/home': (_) => Home(),
        '/mensaje': (_) => MessageScreen(),
      },
    );
  }
}
