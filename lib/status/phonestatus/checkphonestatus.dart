import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:join/chat_views/views/globals.dart';
import 'package:join/database/database_methods.dart';
import 'package:join/main/main_screen.dart';
import 'package:join/status/phonestatus/user_phone_photo_email.dart';

class CheckPhoneStatus extends StatefulWidget {
  const CheckPhoneStatus({super.key});

  @override
  State<CheckPhoneStatus> createState() => _CheckPhoneStatusState();
}

class _CheckPhoneStatusState extends State<CheckPhoneStatus> {
  @override
  void initState() {
    // TODO: implement initState
    checkresult();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Loading Please wait"),
      ),
    );
  }

  void checkresult() async {
    final doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    final bool doesDocExist = doc.exists;
userID=FirebaseAuth.instance.currentUser!.uid;
    if (doesDocExist) {
      print("wrong which");
      Navigator.push(
          context, MaterialPageRoute(builder: (builder) => MainScreen()));
    } else {
      DatabaseMethods().phone().then((value) => {
            Navigator.push(context,
                MaterialPageRoute(builder: (builder) => UserPhonePhotoEmail()))
          });
    }
  }
}
