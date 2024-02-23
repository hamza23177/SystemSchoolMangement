import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tr_app/Master/HomeMaster.dart';
import 'package:tr_app/Screen/Welcome/welcome_screen.dart';
import 'package:tr_app/Student/HomeStudent.dart';
import 'package:tr_app/Teacher/HomeTeacher.dart';
import 'package:tr_app/constant.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'middleware/authmiddleware.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

SharedPreferences? prefs;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  print('User granted permission: ${settings.authorizationStatus}');
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Got a message whilst in the foreground!');
    print('Message data: ${message.data}');

    if (message.notification != null) {
      print('Message also contained a notification: ${message.notification}');
    }
  });
  prefs = await SharedPreferences.getInstance();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Myschool',
      theme: ThemeData(
        primaryColor: primaryColorS,
        scaffoldBackgroundColor: Colors.white,
      ),
      initialRoute: "/",
      getPages: [
        GetPage(
            name: "/",
            page: () => WelcomeScreen(),
            middlewares: [Authmidleware()]),
        GetPage(
          name: "/homeMaster",
          page: () => const HomeMaster(),
        ),
        GetPage(
          name: "/homeTeacher",
          page: () => const HomeTeacher(),
        ),
        GetPage(
          name: "/homeStudent",
          page: () => const HomeStudent(),
        ),
      ],
    );
  }
}
