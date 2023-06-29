import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;
import 'package:join/chat_views/views/globals.dart';

class SendNotification{
  sendNoti({required String title,required String body,required String fcmToken}) async {
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization':'Bearer AAAAv-dPM7I:APA91bFcdTCtpzQmVN9lfsM1ukJdQEjS7dQSqRxp0Mjvtek7MnpnGAyNsyq0HZY_e_wajOTlCKY29NmVmFqoC2MwVz0MxBG1UmQMOP3oCs7AQjhik359H11ADiZKcO_P3W7VWk5n0bot'
    };
    Map<String,dynamic> userData={
      "to": fcmToken,
      'content_available':true,
      "data": {
        "body": body,
        "title": title
      }
    };
     var client = http.Client();

    var response = await client
        .post(Uri.parse('https://fcm.googleapis.com/fcm/send'), body:jsonEncode(userData), headers: headers)
        .timeout(const Duration(seconds: 30));
    ///print response
    var statusCode = response.statusCode;
    print('response:${response.body}:${response.statusCode}');

  }

  updateToken() async {
    userService.fireStore
        .collection(USER_COLLECTION)
        .doc(userID)
        .update({'fcm_token': await FirebaseMessaging.instance.getToken()??""}).catchError((e) {
    }).then((value) {
      print('token updated');
    });

  }
}