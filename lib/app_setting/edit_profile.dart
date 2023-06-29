import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:group_button/group_button.dart';
import 'package:image_picker/image_picker.dart';
import 'package:join/main/main_screen.dart';
import 'package:join/widgets/utils.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController nameController = TextEditingController();
  TextEditingController dateofBrithController = TextEditingController();
  TextEditingController dropdownvalueController = TextEditingController();
  Uint8List? _image;
  String image = "";
  bool _isLoading = false;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    nameController.clear();
    dateofBrithController.clear();
    dropdownvalueController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Edit Profile",
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
              nameController.text = document['name'];
              dateofBrithController.text = document['dob'];
              dropdownvalueController.text = document['gender'];
              image = document['photo'];

              return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 420,
                      child: Stack(
                        children: [
                          Image.asset(
                            "assets/Group 1000001549.png",
                            width: MediaQuery.of(context).size.width,
                            height: 180,
                            fit: BoxFit.cover,
                          ),
                          Container(
                            margin:
                                EdgeInsets.only(left: 20, right: 20, top: 20),
                            child: Card(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  InkWell(
                                    // onTap: () => selectImage(),
                                    child: _image != null
                                        ? CircleAvatar(
                                            radius: 60,
                                            backgroundImage:
                                                MemoryImage(_image!))
                                        : Container(
                                            margin: EdgeInsets.only(top: 10),
                                            child: Center(
                                                child: CircleAvatar(
                                                    radius: 60,
                                                    backgroundImage:
                                                        NetworkImage(image))),
                                          ),
                                  ),
                                  Container(
                                      margin: EdgeInsets.only(
                                          left: 15, right: 15, top: 10),
                                      child: Text(
                                        "Name",
                                        style: TextStyle(
                                            fontFamily: "ProximaNova",
                                            fontWeight: FontWeight.w400,
                                            fontSize: 16,
                                            color: Color(0xff736F7F)),
                                      )),
                                  Container(
                                    width: 315,
                                    height: 46,
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(6)),
                                    ),
                                    margin: EdgeInsets.only(
                                        left: 15, right: 15, top: 5),
                                    child: TextFormField(
                                      controller: nameController,
                                      decoration: InputDecoration(
                                          contentPadding: EdgeInsets.only(
                                              top: 10, left: 10),
                                          hintText: "Fawad Kaleem",
                                          focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(6),
                                              borderSide: BorderSide(
                                                  color: Color(0xffEBF1F3))),
                                          disabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(6),
                                              borderSide: BorderSide(
                                                  color: Color(0xffEBF1F3))),
                                          enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(6),
                                              borderSide: BorderSide(
                                                  color: Color(0xffEBF1F3))),
                                          border: InputBorder.none,
                                          filled: true,
                                          fillColor: Color(0xffEBF1F3)),
                                    ),
                                  ),
                                  Container(
                                      margin: EdgeInsets.only(
                                          left: 15, right: 15, top: 10),
                                      child: Text(
                                        "Choose your Date of Birth",
                                        style: TextStyle(
                                            fontFamily: "ProximaNova",
                                            fontWeight: FontWeight.w400,
                                            fontSize: 16,
                                            color: Color(0xff736F7F)),
                                      )),
                                  Container(
                                    width: 315,
                                    height: 46,
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(6)),
                                    ),
                                    margin: EdgeInsets.only(
                                        left: 15, right: 15, top: 5),
                                    child: TextFormField(
                                      keyboardType: TextInputType.text,
                                      controller: dateofBrithController,
                                      decoration: InputDecoration(
                                          suffixIcon: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Image.asset(
                                              "assets/card.png",
                                              height: 16,
                                              width: 16,
                                            ),
                                          ),
                                          contentPadding: EdgeInsets.only(
                                              top: 10, left: 10),
                                          hintText: "21/05/2023",
                                          focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(6),
                                              borderSide: BorderSide(
                                                  color: Color(0xffEBF1F3))),
                                          disabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(6),
                                              borderSide: BorderSide(
                                                  color: Color(0xffEBF1F3))),
                                          enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(6),
                                              borderSide: BorderSide(
                                                  color: Color(0xffEBF1F3))),
                                          border: InputBorder.none,
                                          filled: true,
                                          fillColor: Color(0xffEBF1F3)),
                                    ),
                                  ),
                                  Container(
                                      margin: EdgeInsets.only(
                                          left: 15, right: 15, top: 10),
                                      child: Text(
                                        "Change Your Gender",
                                        style: TextStyle(
                                            fontFamily: "ProximaNova",
                                            fontWeight: FontWeight.w400,
                                            fontSize: 16,
                                            color: Color(0xff736F7F)),
                                      )),
                                  Container(
                                    margin: EdgeInsets.only(
                                        left: 15, right: 15, top: 5),
                                    width: 320,
                                    height: 46,
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(6)),
                                    ),
                                    child: TextFormField(
                                      controller: dropdownvalueController,
                                      decoration: InputDecoration(
                                          contentPadding: EdgeInsets.only(
                                              top: 10, left: 10),
                                          hintText: "Fawad Kaleem",
                                          focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(6),
                                              borderSide: BorderSide(
                                                  color: Color(0xffEBF1F3))),
                                          disabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(6),
                                              borderSide: BorderSide(
                                                  color: Color(0xffEBF1F3))),
                                          enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(6),
                                              borderSide: BorderSide(
                                                  color: Color(0xffEBF1F3))),
                                          border: InputBorder.none,
                                          filled: true,
                                          fillColor: Color(0xffEBF1F3)),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 25, right: 15, top: 10),
                      child: Text("Interest",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontFamily: "ProximaNova",
                            fontSize: 20,
                            color: Color.fromARGB(255, 2, 0, 7),
                          )),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 25, right: 15, top: 10),
                      child: Text("Choose up to 5 interests per category",
                          style: TextStyle(
                            fontFamily: "ProximaNova",
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                            color: Color(0xff736F7F),
                          )),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 20, right: 20, top: 20),
                      child: Card(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: 10),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Image.asset(
                                    "assets/s.png",
                                    width: 30,
                                    height: 30,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "Workout and Athletics",
                                    style: TextStyle(
                                        fontFamily: "ProximaNova",
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16,
                                        color: Colors.black),
                                  ),
                                  Spacer(),
                                  Text(
                                    "2/5",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16,
                                        color: Color(0xff736F7F)),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                ],
                              ),
                            ),
                            Divider(
                              color: Color(0xffECF2F3),
                              thickness: 2,
                            ),
                            Center(
                              child: GroupButton(
                                isRadio: false,
                                buttons: [
                                  "Football",
                                  "Golf",
                                  "Yoga",
                                  "Cricket",
                                  "Football",
                                  "Hockey"
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 10),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Image.asset(
                                    "assets/flower.png",
                                    width: 30,
                                    height: 30,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "Activities for intellectual",
                                    style: TextStyle(
                                        fontFamily: "ProximaNova",
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16,
                                        color: Colors.black),
                                  ),
                                  Spacer(),
                                  Text(
                                    "2/5",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16,
                                        color: Color(0xff736F7F)),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                ],
                              ),
                            ),
                            Divider(
                              color: Color(0xffECF2F3),
                              thickness: 2,
                            ),
                            Center(
                              child: GroupButton(
                                isRadio: false,
                                buttons: [
                                  "Networking",
                                  "Study Groups",
                                  "Languages",
                                  "Cricket",
                                  "Football",
                                  "Hockey"
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 10),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Image.asset(
                                    "assets/soc.png",
                                    width: 30,
                                    height: 30,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "Social & hangout",
                                    style: TextStyle(
                                        fontFamily: "ProximaNova",
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16,
                                        color: Colors.black),
                                  ),
                                  Spacer(),
                                  Text(
                                    "2/5",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16,
                                        color: Color(0xff736F7F)),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                ],
                              ),
                            ),
                            Divider(
                              color: Color(0xffECF2F3),
                              thickness: 2,
                            ),
                            Center(
                              child: GroupButton(
                                isRadio: false,
                                buttons: [
                                  "Networking",
                                  "Study Groups",
                                  "Languages",
                                  "Cricket",
                                  "Football",
                                  "Hockey"
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 10),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Image.asset(
                                    "assets/as.png",
                                    width: 30,
                                    height: 30,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "Culture and adventure",
                                    style: TextStyle(
                                        fontFamily: "ProximaNova",
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16,
                                        color: Colors.black),
                                  ),
                                  Spacer(),
                                  Text(
                                    "2/5",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16,
                                        color: Color(0xff736F7F)),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                ],
                              ),
                            ),
                            Divider(
                              color: Color(0xffECF2F3),
                              thickness: 2,
                            ),
                            Center(
                              child: GroupButton(
                                isRadio: false,
                                buttons: [
                                  "Museum",
                                  "Exbition",
                                  "Languages",
                                  "Cricket",
                                  "Football",
                                  "Hockey"
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                        margin: EdgeInsets.all(12),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xff246A73),
                              fixedSize: Size(342, 48),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8))),
                          onPressed: () async {
                            // String photoURL = await StorageMethods()
                            //     .uploadImageToStorage(
                            //         'ProfilePics', _image, false);
                            FirebaseFirestore.instance
                                .collection("users")
                                .doc(FirebaseAuth.instance.currentUser!.uid)
                                .update({
                              "name": nameController.text,
                              "dob": dateofBrithController.text,
                              "gender": dropdownvalueController.text,
                            });
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (builder) => MainScreen(),
                              ),
                            );
                          },
                          child: Text(
                            "Save",
                            style: TextStyle(color: Colors.white),
                          ),
                        ))
                  ]);
            }),
      ),
    );
  }

  selectImage() async {
    Uint8List ui = await pickImage(ImageSource.gallery);
    setState(() {
      _image = ui;
    });
  }
}
