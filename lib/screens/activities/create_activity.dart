import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:join/widgets/buttons.dart';
import 'package:join/widgets/dialog.dart';
import 'package:join/widgets/image_uploading_widget.dart';
import 'package:join/widgets/snakbar.dart';

import 'activity/next_activity_page.dart';

class CreateActivity extends StatefulWidget {
  @override
  State<CreateActivity> createState() => _CreateActivityState();
}

class _CreateActivityState extends State<CreateActivity> {
  TextEditingController createTitleController = TextEditingController();

  List<String> dropdownItemList = [
    "Physical Activities",
    "Interllectual Activities",
    "Sip Together",
    "Creative Activities",
    "Relaxation and Leisure Activities"
  ];

  String art = "Physical Activities";

  TextEditingController descriptiontextController = TextEditingController();

  TextEditingController searchController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController createDateController = TextEditingController();
  TextEditingController endTimeController = TextEditingController();
  TextEditingController startTimeController = TextEditingController();

  bool switchValue1 = true;
  bool switchValue2 = true;
  bool switchValue3 = true;
  Uint8List? _image;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: const Color.fromARGB(255, 225, 243, 246),
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Create Activity",
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.left,
          style: TextStyle(
              fontFamily: "ProximaNova",
              fontWeight: FontWeight.w700,
              fontSize: 17,
              color: Color(0xff160F29)),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12, bottom: 1),
              child: Row(children: [
                Image.asset(
                  "assets/Group 6870.png",
                  height: 18,
                  width: 18,
                ),
                const SizedBox(
                  width: 10,
                ),
                const Text(
                  "Add Title Name ",
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      color: Color(0xff736F7F)),
                ),
              ]),
            ),
            Container(
              margin: const EdgeInsets.only(left: 15, right: 15, top: 10),
              child: TextFormField(
                decoration: InputDecoration(
                  filled: true,
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                      borderSide: const BorderSide(color: Colors.white)),
                  disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                      borderSide: const BorderSide(color: Colors.white)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                      borderSide: const BorderSide(color: Colors.white)),
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                      borderSide: const BorderSide(color: Color(0xff368F8B))),
                  hintText: "Wes Yabinlatelee",
                  helperStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff736F7F),
                  ),
                ),
                focusNode: FocusNode(),
                controller: createTitleController,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12, bottom: 1, top: 12),
              child: Row(
                children: [
                  Image.asset(
                    "assets/cat.png",
                    height: 18,
                    width: 18,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Text(
                    "Choose Category",
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        color: Color(0xff736F7F)),
                  ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6.0),
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(0.0, 0.1), //(x,y)
                    blurRadius: 0.5,
                  ),
                ],
              ),
              margin: const EdgeInsets.only(left: 15, right: 15, top: 10),
              child: DropdownButtonFormField<String>(
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: BorderSide.none,
                )),
                borderRadius: BorderRadius.circular(6),
                value: art,
                focusColor: Colors.black,
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
            Padding(
              padding: const EdgeInsets.only(left: 15, bottom: 1, top: 10),
              child: Row(
                children: [
                  Image.asset(
                    "assets/menus.png",
                    height: 18,
                    width: 18,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Text(
                    "Description",
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        color: Color(0xff736F7F)),
                  ),
                ],
              ),
            ),
            Container(
              width: 343,
              height: 107,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(0.0, 0.1), //(x,y)
                    blurRadius: 0.5,
                  ),
                ],
              ),
              margin: const EdgeInsets.only(
                left: 15,
                top: 10,
                right: 15,
              ),
              child: TextFormField(
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                      borderSide: const BorderSide(color: Colors.white)),
                  disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                      borderSide: const BorderSide(color: Colors.white)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                      borderSide: const BorderSide(color: Colors.white)),
                  fillColor: Colors.white,
                  filled: true,
                  contentPadding: const EdgeInsets.only(left: 15, top: 40),
                  border: InputBorder.none,
                  hintText: "Add description",
                ),
                focusNode: FocusNode(),
                controller: descriptiontextController,
                maxLines: 6,
              ),
            ),
            InkWell(
              onTap: () => selectImage(),
              child: Container(
                margin: const EdgeInsets.only(top: 20, right: 15, left: 15),
                child: _image != null
                    ? CircleAvatar(
                        radius: 59, backgroundImage: MemoryImage(_image!))
                    : Image.asset(
                        "assets/Group 6860.png",
                        width: 343,
                        height: 104,
                        fit: BoxFit.cover,
                      ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(0.0, 0.1), //(x,y)
                    blurRadius: 0.5,
                  ),
                ],
              ),
              margin: const EdgeInsets.only(
                left: 15,
                top: 22,
                right: 15,
              ),
              padding: const EdgeInsets.only(
                left: 20,
                top: 16,
                right: 20,
                bottom: 16,
              ),
              // decoration: AppDecoration.fillWhiteA700.copyWith(
              //   borderRadius: BorderRadiusStyle.roundedBorder6,
              // ),
              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                        padding: const EdgeInsets.only(
                          left: 1,
                        ),
                        child: SwitchListTile(
                          activeColor: Color(0xffFF6F79),
                          value: switchValue1,
                          onChanged: (bool? value) {
                            setState(() {
                              switchValue1 = value!;
                            });
                          },
                          subtitle: const Text(
                            "Activate this Button to be able to accept or reject new users to your activity",
                            maxLines: null,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                color: Color(0xff736F7F)),
                          ),
                          title: const Text(
                            'Private / On Request',
                            style: TextStyle(
                                color: Color(
                                  0xff160F29,
                                ),
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ),
                        )),
                    const Padding(
                      padding: EdgeInsets.only(
                        top: 19,
                      ),
                      child: Divider(
                        height: 1,
                        thickness: 1,
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(
                          left: 1,
                        ),
                        child: SwitchListTile(
                          activeColor: const Color(0xffFF6F79),
                          value: switchValue2,
                          onChanged: (bool? value) {
                            setState(() {
                              switchValue2 = value!;
                            });
                          },
                          subtitle: const Text(
                            "Get notified when someone is joining your activity.",
                            maxLines: null,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                color: Color(0xff736F7F)),
                          ),
                          title: const Text(
                            'Notifications',
                            style: TextStyle(
                                color: Color(
                                  0xff160F29,
                                ),
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ),
                        )),
                    const Padding(
                      padding: EdgeInsets.only(
                        top: 19,
                      ),
                      child: Divider(
                        height: 1,
                        thickness: 1,
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(
                          left: 1,
                        ),
                        child: SwitchListTile(
                          activeColor: const Color(0xffFF6F79),
                          value: switchValue3,
                          onChanged: (bool? value) {
                            setState(() {
                              switchValue3 = value!;
                            });
                          },
                          subtitle: const Text(
                            "Toggle if this is activity shall be repeated.",
                            maxLines: null,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                color: Color(0xff736F7F)),
                          ),
                          title: const Text(
                            'Repeat',
                            style: TextStyle(
                                color: Color(
                                  0xff160F29,
                                ),
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ),
                        )),
                  ]),
            ),
            Container(
              margin: const EdgeInsets.all(15),
              child: JoinButton(
                onPressed: dialog,
                title: 'Next',
              ),
            )
          ],
        ),
      ),
    ));
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
        return Dialogs(
          title: "Do you want to continue ?",
          fl: [
            TextButton(
              child: const Text(
                'Yes',
                style: TextStyle(color: Colors.black),
              ),
              onPressed: () {
                if (createTitleController.text.isEmpty) {
                  showSnakBar("Title is Required", context);
                  Navigator.pop(context);
                } else if (descriptiontextController.text.isEmpty) {
                  showSnakBar("Description is Required", context);

                  Navigator.pop(context);
                } else {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (builder) => NextActivityPage(
                                title: createTitleController.text,
                                image: _image,
                                description: descriptiontextController.text,
                                cate: art,
                              )));
                }
              },
            ),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
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
