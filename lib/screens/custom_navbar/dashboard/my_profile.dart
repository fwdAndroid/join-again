import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:join/screens/custom_navbar/dashboard/widgets/connection_and_invite_widget.dart';
import 'package:join/screens/custom_navbar/dashboard/widgets/user_custom_card.dart';
import 'package:join/widgets/image_uploading_widget.dart';

import '../../../services/storage_services.dart';
import '../../settings/app_setting.dart';
import '../custom_navbar.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({super.key});

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  TextEditingController searchController = TextEditingController();

  Uint8List? _image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 225, 243, 246),
      /*appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: TextField(
            decoration: InputDecoration(
              hintText: "Search for User",
              hintStyle: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
        leading: Container(
          width: 150, // Set the desired width here
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "My ",
                style: TextStyle(
                  fontFamily: "ProximaNova",
                  fontSize: 14,
                  color: Color(0xff160F29),
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Text(
                "Profile",
                style: TextStyle(
                  fontFamily: "ProximaNova",
                  fontSize: 14,
                  color: Color(0xff160F29),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        centerTitle: true,
        actions: [
          InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (builder) => AppSetting()));
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset("assets/set.png"),
            ),
          )
        ],
      ),*/
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "My Profile",
                    style: TextStyle(
                      fontFamily: "ProximaNova",
                      fontSize: 20,
                      color: Color(0xff160F29),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    width: 200,
                    child: TextField(
                      controller: searchController,
                      onChanged: (v) {
                        setState(() {});
                      },
                      decoration: const InputDecoration(
                        hintText: "Search For User",
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (builder) => const AppSetting()));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                          height: 40,
                          width: 40,
                          child: Image.asset("assets/set.png")),
                    ),
                  )
                ],
              ),

              SizedBox(
                height: 250,
                child: Stack(
                  children: [
                    Container(
                      height: 200,
                      decoration: const BoxDecoration(
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
                        margin:
                            const EdgeInsets.only(left: 16, right: 16, top: 60),
                        alignment: Alignment.center,
                        height: 170,
                        width: 300,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                            boxShadow: const [
                              BoxShadow(
                                  offset: Offset(0, 0),
                                  color: Colors.grey,
                                  blurRadius: 2)
                            ]),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
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
                                  return Container(
                                    height: 70,
                                    width: 70,
                                    child: Stack(
                                      children: [
                                        Positioned(
                                          left: 4.20,
                                          top: 4.20,
                                          child: Container(
                                            width: 61.29,
                                            height: 61.29,
                                            decoration: ShapeDecoration(
                                              gradient: LinearGradient(
                                                begin: Alignment(-0.98, 0.18),
                                                end: Alignment(0.98, -0.18),
                                                colors: [
                                                  Color(0xFFFF7E87),
                                                  Color(0xFFFF6E78)
                                                ],
                                              ),
                                              shape: OvalBorder(),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          left: 0,
                                          top: 0,
                                          child: Container(
                                            width: 70,
                                            height: 70,
                                            decoration: ShapeDecoration(
                                              gradient: LinearGradient(
                                                begin: Alignment(-0.98, 0.18),
                                                end: Alignment(0.98, -0.18),
                                                colors: [
                                                  Color(0xFFFF7E87),
                                                  Color(0xFFFF6E78)
                                                ],
                                              ),
                                              shape: OvalBorder(),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          left: 6.30,
                                          top: 6.30,
                                          child: Container(
                                            width: 57.40,
                                            height: 57.40,
                                            child: CircleAvatar(
                                              radius: 80,
                                              backgroundImage: NetworkImage(
                                                  document['photo'].toString()),
                                            ),
                                          ),
                                        ),
                                        // Container(
                                        //   margin:
                                        //       const EdgeInsets.only(top: 10),
                                        //   child: InkWell(
                                        //     onTap: selectImage,
                                        //     child: Align(
                                        //       alignment: Alignment.center,
                                        //       child: Container(
                                        //         height: 61,
                                        //         width: 61,
                                        //         child:
                                        //     ),
                                        //   ),
                                        // ),
                                      ],
                                    ),
                                  );
                                }),
                            // TextButton(
                            //     onPressed: dialog,
                            //     child: const Text(
                            //       "Update Image",
                            //       style: TextStyle(color: Color(0xff246A73)),
                            //     )),
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 8,
                              ),
                              child: StreamBuilder(
                                  stream: FirebaseFirestore.instance
                                      .collection("users")
                                      .doc(FirebaseAuth
                                          .instance.currentUser!.uid)
                                      .snapshots(),
                                  builder: (context, AsyncSnapshot snapshot) {
                                    if (!snapshot.hasData) {
                                      return const CircularProgressIndicator();
                                    }
                                    var document = snapshot.data;
                                    return Text(
                                      document['name'],
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.left,
                                      style: const TextStyle(
                                          color: Color(0xff160F29),
                                          fontWeight: FontWeight.w600,
                                          fontFamily: "ProximaNova",
                                          fontSize: 18),
                                    );
                                  }),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // ========= When Search Filter is Empty ====================//
              if (searchController.text.isEmpty)
                const ConnectionAndInviteWidget()
              else
                SizedBox(
                  height: 400,
                  child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("users")
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          var data = snapshot.data!.docs[index];

                          if (data['uid'].toString().toLowerCase().contains(
                                  searchController.text.toLowerCase()) ||
                              data['name'].toString().toLowerCase().contains(
                                  searchController.text.toLowerCase()) ||
                              data['email'].toString().toLowerCase().contains(
                                  searchController.text.toLowerCase())) {
                            return UserCustomCard(data: data);
                          } else {
                            return const SizedBox();
                          }
                        },
                      );
                    },
                  ),
                ),
            ],
          ),
        ),
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
                String photoURL = await StorageServices()
                    .uploadImageToStorage('ProfilePics', _image!, false);
                FirebaseFirestore.instance
                    .collection("users")
                    .doc(FirebaseAuth.instance.currentUser!.uid)
                    .update({"photo": photoURL});
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Image Updated Succesfully")));
                Navigator.push(context,
                    MaterialPageRoute(builder: (builder) => MainScreen()));
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
