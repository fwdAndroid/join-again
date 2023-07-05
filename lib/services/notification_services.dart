import 'dart:math';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fluttertoast/fluttertoast.dart';

class NotificationServices {
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;

  init() {
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    _requestPermissions();

    android_iossettings();
    ForegroundMessage();
  }

  getToken() async {
    _requestFCMPermissions(_fcm);
    var token = await FirebaseMessaging.instance.getToken();
    FirebaseMessaging.instance.onTokenRefresh.listen((newToken) {
      // Save newToken
      token = newToken;
      if (kDebugMode) print('Token: $newToken');
    });
    if (kDebugMode) print('Token: $token');
    return token;
  }

  void _requestFCMPermissions(FirebaseMessaging fcm) {
    _fcm.requestPermission(
      provisional: true,
      criticalAlert: true,
      announcement: true,
      carPlay: true,
    );
    checkPermission(fcm);
  }

  checkPermission(FirebaseMessaging fcm) {
    FirebaseMessaging.instance.getNotificationSettings().then((value) {
      // print("check authorizationStatus:$checkStatus");
      // checkStatus++;
      if (value.authorizationStatus == AuthorizationStatus.notDetermined) {
        _requestFCMPermissions(fcm);
      } else if (value.authorizationStatus == AuthorizationStatus.denied) {
        Fluttertoast.showToast(
            msg: "Notification Disabled",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      } else {}
    });
  }

  android_iossettings() async {
    final AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
    final DarwinInitializationSettings initializationSettingsIOS = DarwinInitializationSettings(
        requestAlertPermission: false,
        requestBadgePermission: false,
        requestSoundPermission: false,
        onDidReceiveLocalNotification: didReceiveNotification);
    InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );
    flutterLocalNotificationsPlugin.initialize(initializationSettings, onDidReceiveNotificationResponse: onSelectNotification);
  }

  ForegroundMessage() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      if (kDebugMode) print("noti arrived:" + message.data.toString());
      showNotification(message);
    }).onError((e) {});
  }

  NotificationopenApp() {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      if (kDebugMode) print("APPOPEN:${message.data}");
    });
  }

  Future<void> _requestPermissions() async {
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

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      if (kDebugMode) print('User granted permission');
    } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
      if (kDebugMode) print('User granted provisional permission');
    } else {
      if (kDebugMode) print('User declined or has not accepted permission');
    }

    flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
  }

  onSelectNotification(NotificationResponse notificationResponse) {
    String payload = notificationResponse.payload.toString();
    if (kDebugMode) print("selectNotification " + payload);
  }

  didReceiveNotification(
    int? id,
    String? title,
    String? body,
    String? payload,
  ) async {}

  showNotification(RemoteMessage message) async {
    if (kDebugMode) print("noti arrived:1" + message.data.toString());

    const AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails('Join', 'join',
        channelDescription: 'join', importance: Importance.max, priority: Priority.high, color: Colors.green, ticker: 'ticker');
    const DarwinNotificationDetails iOSPlatformChannelSpecifics = DarwinNotificationDetails(presentSound: true, presentAlert: true);
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(iOS: iOSPlatformChannelSpecifics, android: androidPlatformChannelSpecifics);
    if (kDebugMode) print("noti arrived:2" + message.data.toString());
    Random random = Random();
    int notiID = random.nextInt(9999 - 1000) + 1000;
    flutterLocalNotificationsPlugin.show(
      notiID,
      message.data['title'],
      message.data['body'],
      platformChannelSpecifics,
    );
  }
}
