import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:join/screens/profile_creation/select_gender.dart';
import 'package:join/widgets/snakbar.dart';

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
          const SizedBox(
            height: 30,
          ),
          Container(
              margin: const EdgeInsets.only(left: 25, right: 25, top: 20),
              height: 70,
              child: IntlPhoneField(
                controller: nameController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  helperStyle: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w200,
                    color: Colors.grey,
                  ),
                  filled: true,
                  contentPadding: const EdgeInsets.only(top: 10),
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                      borderSide: const BorderSide(color: Colors.grey)),
                  disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                      borderSide: const BorderSide(color: Colors.grey)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                      borderSide: const BorderSide(color: Colors.grey)),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                      borderSide: const BorderSide(color: Colors.grey)),
                ),
                initialCountryCode: 'TH',
                onChanged: (phone) {
                  print(phone.completeNumber);
                },
              )),
          Container(
            margin: const EdgeInsets.only(left: 25, right: 25, top: 25),
            child: _isLoading
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        fixedSize: const Size(343, 48),
                        backgroundColor: const Color(0xff246A73)),
                    onPressed: createProfile,
                    child: const Text(
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
      showSnakBar("All Fields are Required", context);
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
      showSnakBar("Phone Number Added", context);

      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (builder) => SelectGender()));
    }
  }
}
