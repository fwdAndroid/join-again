import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:join/main/main_screen.dart';
import 'package:join/screens/settings/app_setting.dart';
import 'package:join/widgets/image_uploading_widget.dart';

import '../../services/storage_services.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({super.key});

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  Uint8List? _image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 225, 243, 246),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          "My Profile",
          style: TextStyle(fontFamily: "ProximaNova", fontSize: 20, color: Color(0xff160F29), fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        actions: [
          InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (builder) => AppSetting()));
/*
              Navigator.push(context,
                  MaterialPageRoute(builder: (builder) =>  ChatScreen(UserModel(uid: 'a3IwdwOqpTMD2mc1LyQCwIWuUTq1',name: 'testing',email: 'test@gmail.com',phoneNumber: '+923078508248',photoUrl: 'https://firebasestorage.googleapis.com/v0/b/join-a0ce2.appspot.com/o/ProfilePics%2Fa3IwdwOqpTMD2mc1LyQCwIWuUTq1?alt=media&token=9f01fd6a-d3af-4630-861a-ca87eb79e942'))
                  ));
*/
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset("assets/set.png"),
            ),
          )
        ],
      ),
      body: Column(
        children: [
          Container(
            height: 250,
            child: Stack(
              children: [
                Container(
                  height: 200,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment(
                        1,
                        0.83,
                      ),
                      end: Alignment(
                        0.16,
                        0.2,
                      ),
                      colors: [
                        Color(0xff368f8b),
                        Color(0xffff6e78),
                      ],
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    margin: EdgeInsets.only(left: 16, right: 16, top: 60),
                    alignment: Alignment.center,
                    height: 170,
                    width: 300,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        boxShadow: [BoxShadow(offset: Offset(0, 0), color: Colors.grey, blurRadius: 2)]),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        StreamBuilder(
                            stream: FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).snapshots(),
                            builder: (context, AsyncSnapshot snapshot) {
                              if (!snapshot.hasData) {
                                return new CircularProgressIndicator();
                              }
                              var document = snapshot.data;
                              return Container(
                                margin: EdgeInsets.only(top: 10),
                                child: InkWell(
                                  onTap: selectImage,
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Container(
                                      height: 61,
                                      width: 61,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      child: CircleAvatar(
                                        radius: 80,
                                        backgroundImage: NetworkImage(document['photo'].toString()),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }),
                        TextButton(
                            onPressed: dialog,
                            child: Text(
                              "Update Image",
                              style: TextStyle(color: Color(0xff246A73)),
                            )),
                        Padding(
                          padding: EdgeInsets.only(
                            top: 8,
                          ),
                          child: StreamBuilder(
                              stream:
                                  FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).snapshots(),
                              builder: (context, AsyncSnapshot snapshot) {
                                if (!snapshot.hasData) {
                                  return new CircularProgressIndicator();
                                }
                                var document = snapshot.data;
                                return Text(
                                  document['name'],
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      color: Color(0xff160F29), fontWeight: FontWeight.w600, fontFamily: "ProximaNova", fontSize: 18),
                                );
                              }),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(6)),
            height: 119,
            width: 343,
            // padding: EdgeInsets.only(top: 16, left: 16, right: 16),
            margin: EdgeInsets.only(top: 10, left: 10, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: 10,
                ),
                Image.asset(
                  "assets/errors.png",
                  height: 58,
                  width: 58,
                  fit: BoxFit.cover,
                ),
                SizedBox(
                  width: 10,
                ),
                Container(
                  width: 210,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "No Connection Yet!",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                      Text(
                        "Meet other users and scan their QR Codes to connect.",
                        style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 24,
                  height: 24,
                  margin: EdgeInsets.only(top: 20),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Text(
                      "",
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(6)),
              height: 119,
              width: 343,
              // padding: EdgeInsets.only(top: 16, left: 16, right: 16),
              margin: EdgeInsets.only(top: 10, left: 10, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  Image.asset(
                    "assets/phone.png",
                    height: 58,
                    width: 58,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    width: 210,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "No invite yet!",
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                        ),
                        Text(
                          "Invite your friend and experience the events in your area together.",
                          style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20, right: 10),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: Image.asset(
                        "assets/greenshare.png",
                        width: 24,
                        height: 24,
                      ),
                    ),
                  )
                ],
              )),
        ],
      ),
    );
  }

  selectImage() async {
    Uint8List ui = await pickImage(ImageSource.gallery);
    setState(() {
      _image = ui;
    });
  }

  void dialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Update Image'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Do you want to update your profile image'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
                'Yes',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              onPressed: () async {
                String photoURL = await StorageServices().uploadImageToStorage('ProfilePics', _image!, false);
                FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).update({"photo": photoURL});
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Image Updated Succesfully")));
                Navigator.push(context, MaterialPageRoute(builder: (builder) => MainScreen()));
              },
            ),
            TextButton(
              child: const Text(
                'No',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
