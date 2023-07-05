import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:join/screens/custom_navbar/custom_navbar.dart';
import 'package:join/screens/first_screen/first_screen.dart';
import 'package:join/services/notification_services.dart';
import 'package:page_transition/page_transition.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("noti background");
  await Firebase.initializeApp();
  if (message.notification == null) {
    NotificationServices().showNotification(message);
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  await NotificationServices().init();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
        useMaterial3: true,
      ),
      home: AnimatedSplashScreen(
        nextScreen: FirebaseAuth.instance.currentUser != null ? MainScreen() : const LoginScreen(),
        splash: Image.asset(
          'assets/splash.png',
          height: 150,
          width: 150,
        ),
        duration: 2000,
        splashIconSize: 150,
        splashTransition: SplashTransition.slideTransition,
        pageTransitionType: PageTransitionType.fade,
        backgroundColor: Colors.white,
      ),
    );
  }
}
