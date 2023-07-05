import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:join/emailprofile.dart/select_gender.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class UserPhoneNumber extends StatefulWidget {
  const UserPhoneNumber({super.key});

  @override
  State<UserPhoneNumber> createState() => _UserPhoneNumberState();
}

class _UserPhoneNumberState extends State<UserPhoneNumber> {
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
              margin: EdgeInsets.only(left: 25, right: 25, top: 20),
              height: 70,
              child: IntlPhoneField(
                controller: nameController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  helperStyle: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w200,
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
                ),
                initialCountryCode: 'TH',
                onChanged: (phone) {
                  print(phone.completeNumber);
                },
              )),
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

  void createProfile() async {
    if (nameController.text.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("All Fields are Required")));
    } else {
      setState(() {
        _isLoading = true;
      });
      await FirebaseFirestore.instance
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({
        "phone": nameController.text,
      });
      setState(() {
        _isLoading = false;
      });

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Phone Number Added")));
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (builder) => SelectGender()));
    }
  }
}
