import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:join/database/storage_methods.dart';
import 'package:join/emailprofile.dart/user_dob.dart';
import 'package:join/widgets/utils.dart';

class UserPhotoEmail extends StatefulWidget {
  const UserPhotoEmail({super.key});

  @override
  State<UserPhotoEmail> createState() => _UserPhotoEmailState();
}

class _UserPhotoEmailState extends State<UserPhotoEmail> {
  Uint8List? _image;
  TextEditingController nameController = TextEditingController();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset(
            "assets/splash.png",
            height: 150,
            width: 200,
          ),
          SizedBox(
            height: 30,
          ),
          Container(
            margin: EdgeInsets.only(
              left: 20,
              right: 20,
            ),
            child: InkWell(
              onTap: () => selectImage(),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: 374,
                  height: 157,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Color(0xffD2D2D2),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _image != null
                          ? CircleAvatar(
                              radius: 59, backgroundImage: MemoryImage(_image!))
                          : Image.asset(
                              "assets/phone.png",
                              width: 51,
                              height: 39,
                            ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: RichText(
                          text: TextSpan(
                            text: 'Upload Profile Photo',
                            style: TextStyle(
                              fontFamily: 'ProximaNova',
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                              fontStyle: FontStyle.normal,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                  text: '*',
                                  style: TextStyle(
                                    fontFamily: 'ProximaNova',
                                    fontWeight: FontWeight.w500,
                                    fontStyle: FontStyle.normal,
                                  )),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 25, right: 25, top: 20),
            height: 46,
            child: TextFormField(
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.person_2,
                  color: Colors.grey,
                ),
                filled: true,
                contentPadding: EdgeInsets.only(top: 10),
                fillColor: Colors.white,
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                    borderSide: BorderSide(color: Colors.grey)),
                disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                    borderSide: BorderSide(color: Colors.grey)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                    borderSide: BorderSide(color: Colors.grey)),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                    borderSide: BorderSide(color: Colors.grey)),
                hintText: "Enter Your Name",
                helperStyle: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w200,
                  color: Colors.grey,
                ),
              ),
              focusNode: FocusNode(),
              autofocus: true,
              controller: nameController,
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 25, right: 25, top: 25),
            child: _isLoading
                ? CircularProgressIndicator()
                : ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        fixedSize: Size(343, 48),
                        backgroundColor: Color(0xff246A73)),
                    onPressed: createProfile,
                    child: Text(
                      "Next",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    )),
          ),
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

  void createProfile() async {
    if (nameController.text.isEmpty || _image!.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("All Fields are Required")));
    } else {
      String photoURL = await StorageMethods()
          .uploadImageToStorage('ProfilePics', _image!, false);
      await FirebaseFirestore.instance
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({"name": nameController.text, "photo": photoURL}).then(
              (value) => {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Name and Photo Added"))),
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (builder) => UserDateofBirth()))
                  });
    }
  }
}
