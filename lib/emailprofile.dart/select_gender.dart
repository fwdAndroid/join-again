import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:join/main/main_screen.dart';

class SelectGender extends StatefulWidget {
  const SelectGender({super.key});

  @override
  State<SelectGender> createState() => _SelectGenderState();
}

class _SelectGenderState extends State<SelectGender> {
  List<String> dropdownItemList = [
    "Male",
    "Female",
    "Others",
  ];

  String art = "Male";
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
            height: 80,
            child: DropdownButtonFormField<String>(
              focusColor: Colors.black,
              decoration: InputDecoration(
                  hintStyle: TextStyle(color: Colors.black),
                  fillColor: Colors.black,
                  labelStyle: TextStyle(color: Colors.black),
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                    borderSide: BorderSide(color: Colors.black),
                  )),
              borderRadius: BorderRadius.circular(6),
              value: art,
              isDense: true,
              isExpanded: true,
              icon: Image.asset(
                "assets/Chevon Left.png",
                height: 16,
                width: 16,
              ),
              elevation: 16,
              style: const TextStyle(color: Colors.black),
              onChanged: (String? value) {
                // This is called when the user selects an item.
                setState(() {
                  art = value!;
                });
              },
              items: dropdownItemList
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
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
                      "Finish",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    )),
          ),
        ],
      ),
    );
  }

  void createProfile() async {
    if (art.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("All Fields are Required")));
    } else {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({
        "gender": art,
      }).then((value) => {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text("Gender is Added"))),
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (builder) => MainScreen()))
              });
    }
  }
}
