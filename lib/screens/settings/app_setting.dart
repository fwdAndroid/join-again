import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:join/screens/settings/edit_profile.dart';
import 'package:join/widgets/buttons.dart';
import 'package:join/widgets/dialog.dart';

import '../first_screen/first_screen.dart';
import '../events/event_tab.dart';

class AppSetting extends StatefulWidget {
  const AppSetting({super.key});

  @override
  State<AppSetting> createState() => _AppSettingState();
}

class _AppSettingState extends State<AppSetting> {
  List<String> dropdownItemList = [
    "Item One",
    "Item Two",
    "Item Three",
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 225, 243, 246),
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Setting",
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.left,
          style: TextStyle(
              fontFamily: "ProximaNova",
              fontSize: 20,
              color: Color(0xff160F29),
              fontWeight: FontWeight.w600),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("users")
                    .doc(FirebaseAuth.instance.currentUser!.uid)
                    .snapshots(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (!snapshot.hasData) {
                    return const CircularProgressIndicator();
                  }
                  var document = snapshot.data;
                  return SizedBox(
                    height: 300,
                    child: Stack(
                      children: [
                        Image.asset(
                          "assets/Group 1000001549.png",
                          width: MediaQuery.of(context).size.width,
                          height: 150,
                          fit: BoxFit.cover,
                        ),
                        Container(
                          margin: const EdgeInsets.only(
                              left: 20, right: 20, top: 20),
                          child: Card(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(
                                      left: 20, right: 20, top: 10),
                                  child: const Text(
                                    "Link Accounts",
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        fontFamily: "ProximaNova",
                                        fontSize: 16,
                                        color: Color(0xff736F7F),
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(
                                      left: 10, right: 10, top: 5),
                                  decoration: const BoxDecoration(
                                      color: Color(0xffEDF3F4),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(15))),
                                  child: ListTile(
                                    leading: Image.asset(
                                        "assets/circle-flags_uk.png"),
                                    title: const Text(
                                      "Linked",
                                      style: TextStyle(
                                          fontFamily: "ProximaNova",
                                          fontSize: 16,
                                          color: Color(0xff246A73),
                                          fontWeight: FontWeight.w400),
                                    ),
                                    subtitle: Text(document['email']),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(
                                      left: 10, right: 10, top: 5),
                                  decoration: const BoxDecoration(
                                      color: Color(0xffEDF3F4),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(15))),
                                  child: ListTile(
                                    leading: Image.asset(
                                      "assets/face.png",
                                      width: 22,
                                      height: 22,
                                    ),
                                    title: const Text(
                                      "Tap to Connect Here",
                                      style: TextStyle(
                                          color: Color(
                                            0xff160F29,
                                          ),
                                          fontSize: 16,
                                          fontFamily: "ProximaNova",
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(
                                      left: 10, right: 10, top: 5),
                                  decoration: const BoxDecoration(
                                      color: Color(0xffEDF3F4),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(15))),
                                  child: const ListTile(
                                    leading: Icon(
                                      Icons.phone,
                                      color: Color(0xff246A73),
                                    ),
                                    title: Text(
                                      "Tap to Connect Here",
                                      style: TextStyle(
                                          color: Color(
                                            0xff160F29,
                                          ),
                                          fontSize: 16,
                                          fontFamily: "ProximaNova",
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
            Container(
              margin: const EdgeInsets.only(
                left: 25,
                top: 10,
              ),
              child: const Text(
                "Other",
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.left,
                style: TextStyle(
                    color: Color(
                      0xff160F29,
                    ),
                    fontSize: 16,
                    fontFamily: "ProximaNova",
                    fontWeight: FontWeight.w600),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (builder) => EditProfile()));
              },
              child: Container(
                margin: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                  top: 12,
                ),
                padding: const EdgeInsets.only(
                  left: 20,
                  top: 13,
                  right: 20,
                  bottom: 13,
                ),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: const [
                      BoxShadow(
                          offset: Offset(0.0, 0.0),
                          color: Colors.grey,
                          blurRadius: 0.1)
                    ]),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(
                        top: 1,
                        bottom: 2,
                      ),
                      child: Text(
                        "Edit Profile",
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: Color(
                              0xff160F29,
                            ),
                            fontSize: 16,
                            fontFamily: "ProximaNova",
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    Image.asset(
                      "assets/arrow.png",
                      height: 20,
                      width: 20,
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                left: 20,
                right: 20,
                top: 12,
              ),
              padding: const EdgeInsets.only(
                left: 20,
                top: 13,
                right: 20,
                bottom: 13,
              ),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: const [
                    BoxShadow(
                        offset: Offset(0.0, 0.0),
                        color: Colors.grey,
                        blurRadius: 0.1)
                  ]),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(
                      top: 1,
                      bottom: 2,
                    ),
                    child: Text(
                      "FAQ",
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: Color(
                            0xff160F29,
                          ),
                          fontSize: 16,
                          fontFamily: "ProximaNova",
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  Image.asset(
                    "assets/arrow.png",
                    height: 20,
                    width: 20,
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (builder) => EventRequestTab()));
              },
              child: Container(
                margin: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                  top: 12,
                ),
                padding: const EdgeInsets.only(
                  left: 20,
                  top: 13,
                  right: 20,
                  bottom: 13,
                ),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: const [
                      BoxShadow(
                          offset: Offset(0.0, 0.0),
                          color: Colors.grey,
                          blurRadius: 0.1)
                    ]),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(
                        top: 1,
                        bottom: 2,
                      ),
                      child: Text(
                        "Events Request",
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: Color(
                              0xff160F29,
                            ),
                            fontSize: 16,
                            fontFamily: "ProximaNova",
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    Image.asset(
                      "assets/arrow.png",
                      height: 20,
                      width: 20,
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                left: 20,
                right: 20,
                top: 12,
              ),
              padding: const EdgeInsets.only(
                left: 20,
                top: 13,
                right: 20,
                bottom: 13,
              ),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: const [
                    BoxShadow(
                        offset: Offset(0.0, 0.0),
                        color: Colors.grey,
                        blurRadius: 0.1)
                  ]),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(
                      top: 1,
                      bottom: 2,
                    ),
                    child: Text(
                      "Report a problem",
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: Color(
                            0xff160F29,
                          ),
                          fontSize: 16,
                          fontFamily: "ProximaNova",
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  Image.asset(
                    "assets/arrow.png",
                    height: 20,
                    width: 20,
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                left: 20,
                right: 20,
                top: 12,
              ),
              padding: const EdgeInsets.only(
                left: 20,
                top: 13,
                right: 20,
                bottom: 13,
              ),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: const [
                    BoxShadow(
                        offset: Offset(0.0, 0.0),
                        color: Colors.grey,
                        blurRadius: 0.1)
                  ]),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(
                      top: 1,
                      bottom: 2,
                    ),
                    child: Text(
                      "Join the partner ship program",
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: Color(
                            0xff160F29,
                          ),
                          fontSize: 16,
                          fontFamily: "ProximaNova",
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  Image.asset(
                    "assets/arrow.png",
                    height: 20,
                    width: 20,
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                left: 20,
                right: 20,
                top: 12,
              ),
              padding: const EdgeInsets.only(
                left: 20,
                top: 13,
                right: 20,
                bottom: 13,
              ),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: const [
                    BoxShadow(
                        offset: Offset(0.0, 0.0),
                        color: Colors.grey,
                        blurRadius: 0.1)
                  ]),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(
                      top: 1,
                      bottom: 2,
                    ),
                    child: Text(
                      "Join for the bussiness",
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: Color(
                            0xff160F29,
                          ),
                          fontSize: 16,
                          fontFamily: "ProximaNova",
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  Image.asset(
                    "assets/arrow.png",
                    height: 20,
                    width: 20,
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: _deleteAccount,
              child: Container(
                margin: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                  top: 12,
                ),
                padding: const EdgeInsets.only(
                  left: 20,
                  top: 13,
                  right: 20,
                  bottom: 13,
                ),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: const [
                      BoxShadow(
                          offset: Offset(0.0, 0.0),
                          color: Colors.grey,
                          blurRadius: 0.1)
                    ]),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(
                        top: 1,
                        bottom: 2,
                      ),
                      child: Text(
                        "Delete Account",
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: Color(
                              0xff160F29,
                            ),
                            fontSize: 16,
                            fontFamily: "ProximaNova",
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    Image.asset(
                      "assets/arrow.png",
                      height: 20,
                      width: 20,
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                  left: 20, right: 20, top: 12, bottom: 12),
              child: JoinButton(
                onPressed: _logOut,
                title: 'Logout',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _deleteAccount() {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return Dialogs(
          title: "Delete Account \n\nAre you sure to delete the account?",
          fl: [
            TextButton(
                onPressed: () async {
                  await FirebaseFirestore.instance
                      .collection("users")
                      .doc(FirebaseAuth.instance.currentUser!.uid)
                      .delete()
                      .then((value) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Account Deleted Successfully")));
                    FirebaseAuth.instance.currentUser!.delete();
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (builder) => LoginScreen()));
                  });
                },
                child: const Text(
                  "Yes",
                  style: TextStyle(color: Colors.black),
                )),
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("No"))
          ],
        );
      },
    );
  }

  Future<void> _logOut() {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return Dialogs(
          title: "Logout\n\nAre you sure you want to logout ?",
          fl: [
            TextButton(
                onPressed: () async {
                  await FirebaseAuth.instance.signOut().then((value) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Logout Successfully")));
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (builder) => LoginScreen()));
                  });
                },
                child: const Text(
                  "Yes",
                  style: TextStyle(color: Colors.black),
                )),
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  "No",
                  style: TextStyle(color: Colors.black),
                ))
          ],
        );
      },
    );
  }
}
