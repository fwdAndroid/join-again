import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:join/app_setting/edit_profile.dart';
import 'package:join/auth/login_screen.dart';
import 'package:join/event_tab/event_tab.dart';

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
        title: Text(
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
            InkWell(
              onTap: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (builder) => LoginScreen()));
              },
              child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("users")
                      .doc(FirebaseAuth.instance.currentUser!.uid)
                      .snapshots(),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (!snapshot.hasData) {
                      return new CircularProgressIndicator();
                    }
                    var document = snapshot.data;
                    return Container(
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
                            margin:
                                EdgeInsets.only(left: 20, right: 20, top: 20),
                            child: Card(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(
                                        left: 20, right: 20, top: 10),
                                    child: Text(
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
                                    margin: EdgeInsets.only(
                                        left: 10, right: 10, top: 5),
                                    decoration: BoxDecoration(
                                        color: Color(0xffEDF3F4),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15))),
                                    child: ListTile(
                                      leading: Image.asset(
                                          "assets/circle-flags_uk.png"),
                                      title: Text(
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
                                    margin: EdgeInsets.only(
                                        left: 10, right: 10, top: 5),
                                    decoration: BoxDecoration(
                                        color: Color(0xffEDF3F4),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15))),
                                    child: ListTile(
                                      leading: Image.asset(
                                        "assets/face.png",
                                        width: 22,
                                        height: 22,
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
                                  Container(
                                    margin: EdgeInsets.only(
                                        left: 10, right: 10, top: 5),
                                    decoration: BoxDecoration(
                                        color: Color(0xffEDF3F4),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15))),
                                    child: ListTile(
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
            ),
            Container(
              margin: EdgeInsets.only(
                left: 25,
                top: 10,
              ),
              child: Text(
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
                margin: EdgeInsets.only(
                  left: 20,
                  right: 20,
                  top: 12,
                ),
                padding: EdgeInsets.only(
                  left: 20,
                  top: 13,
                  right: 20,
                  bottom: 13,
                ),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(0.0, 0.0),
                          color: Colors.grey,
                          blurRadius: 0.1)
                    ]),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
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
              margin: EdgeInsets.only(
                left: 20,
                right: 20,
                top: 12,
              ),
              padding: EdgeInsets.only(
                left: 20,
                top: 13,
                right: 20,
                bottom: 13,
              ),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                        offset: Offset(0.0, 0.0),
                        color: Colors.grey,
                        blurRadius: 0.1)
                  ]),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
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
                margin: EdgeInsets.only(
                  left: 20,
                  right: 20,
                  top: 12,
                ),
                padding: EdgeInsets.only(
                  left: 20,
                  top: 13,
                  right: 20,
                  bottom: 13,
                ),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(0.0, 0.0),
                          color: Colors.grey,
                          blurRadius: 0.1)
                    ]),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
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
              margin: EdgeInsets.only(
                left: 20,
                right: 20,
                top: 12,
              ),
              padding: EdgeInsets.only(
                left: 20,
                top: 13,
                right: 20,
                bottom: 13,
              ),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                        offset: Offset(0.0, 0.0),
                        color: Colors.grey,
                        blurRadius: 0.1)
                  ]),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
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
              margin: EdgeInsets.only(
                left: 20,
                right: 20,
                top: 12,
              ),
              padding: EdgeInsets.only(
                left: 20,
                top: 13,
                right: 20,
                bottom: 13,
              ),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                        offset: Offset(0.0, 0.0),
                        color: Colors.grey,
                        blurRadius: 0.1)
                  ]),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
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
              margin: EdgeInsets.only(
                left: 20,
                right: 20,
                top: 12,
              ),
              padding: EdgeInsets.only(
                left: 20,
                top: 13,
                right: 20,
                bottom: 13,
              ),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                        offset: Offset(0.0, 0.0),
                        color: Colors.grey,
                        blurRadius: 0.1)
                  ]),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
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
                margin: EdgeInsets.only(
                  left: 20,
                  right: 20,
                  top: 12,
                ),
                padding: EdgeInsets.only(
                  left: 20,
                  top: 13,
                  right: 20,
                  bottom: 13,
                ),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(0.0, 0.0),
                          color: Colors.grey,
                          blurRadius: 0.1)
                    ]),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
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
              margin: EdgeInsets.only(left: 20, right: 20, top: 12, bottom: 12),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8), // <-- Radius
                    ),
                    fixedSize: Size(343, 48),
                    backgroundColor: Color(0xff246A73)),
                onPressed: _logOut,
                child: Text(
                  "Log Out",
                  style: TextStyle(color: Colors.white),
                ),
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
          return Container(
            height: 144,
            width: 270,
            child: AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(14.0))),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    Center(
                        child: Text(
                      "Delete Account",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),
                    )),
                    SizedBox(
                      height: 10,
                    ),
                    Center(
                        child: Text(
                      "Are you sure you want to delete \naccount ?",
                      style: TextStyle(
                        color: Color(0xff736F7F),
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.center,
                    )),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text("No"),
                        ),
                        VerticalDivider(
                          color: Color(0xff3C3C43).withOpacity(.36),
                          thickness: 2,
                        ),
                        TextButton(
                          onPressed: () async {
                            await FirebaseFirestore.instance
                                .collection("users")
                                .doc(FirebaseAuth.instance.currentUser!.uid)
                                .delete()
                                .then((value) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text(
                                          "Account Deleted Successfully")));
                              FirebaseAuth.instance.currentUser!.delete();
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (builder) => LoginScreen()));
                            });
                          },
                          child: Text("Yes"),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  Future<void> _logOut() {
    return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return Container(
            height: 144,
            width: 270,
            child: AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(14.0))),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    Center(
                        child: Text(
                      "Logout",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),
                    )),
                    SizedBox(
                      height: 10,
                    ),
                    Center(
                        child: Text(
                      "Are you sure you want to logout ?",
                      style: TextStyle(
                        color: Color(0xff736F7F),
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.center,
                    )),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text("No"),
                        ),
                        VerticalDivider(
                          color: Color(0xff3C3C43).withOpacity(.36),
                          thickness: 2,
                        ),
                        TextButton(
                          onPressed: () async {
                            await FirebaseAuth.instance.signOut().then((value) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text("Logout Successfully")));
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (builder) => LoginScreen()));
                            });
                          },
                          child: Text("Yes"),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
