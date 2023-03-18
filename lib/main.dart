import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:veda_nidhi_v2/repository/recents_box.dart';
import 'package:veda_nidhi_v2/theme/themes.dart';
import 'package:veda_nidhi_v2/utils/shared_prefs.dart';
import 'package:veda_nidhi_v2/views/notification_view/notification_view_screen.dart';
import 'package:veda_nidhi_v2/views/spash_view_screen.dart';

import 'bindings/controller_bindings.dart';
import 'firebase_options.dart';

late RecentsBox recentsBox;

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel',
  'High Importance Notifications',
  importance: Importance.high,
  playSound: true,
);
final GlobalKey<NavigatorState> navigatorKey = GlobalKey();
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  recentsBox = await RecentsBox.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );
  final deviceToken = await messaging.getToken();
  await SharedPref.setDeviceToken(deviceToken!);

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true, // Required to display a heads up notification
    badge: true,
    sound: true,
  );

  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    navigatorKey.currentState!.push(
        MaterialPageRoute(builder: (_) => const NotificationViewScreen()));
  });
  final terminatedMessage =
      await FirebaseMessaging.instance.getInitialMessage();
  if (terminatedMessage != null) {
    if (navigatorKey.currentState != null) {
      navigatorKey.currentState!.push(
          MaterialPageRoute(builder: (_) => const NotificationViewScreen()));
    }
  } 

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}


class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
     FirebaseMessaging.onMessage.listen((message) {
      if (message.notification != null &&
          message.notification!.android != null) {
        RemoteNotification notification = message.notification!;
      
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
                android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              channelDescription: channel.description,
              color: Colors.green,
              playSound: true,
              icon: '@mipmap/ic_launcher',
            )));
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorKey: navigatorKey,
        initialBinding: ControllerBindings(),
        theme: lightThemeData(context),
        home: const SplashViewScreen());
  }
}
