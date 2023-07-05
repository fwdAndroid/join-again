import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../custom_navbar/custom_navbar.dart';
import 'map_screen_activity.dart';

class NextActivityPage extends StatefulWidget {
  final title;
  final description;
  final image;
  final cate;

  const NextActivityPage({super.key, required this.description, required this.image, required this.cate, required this.title});

  @override
  State<NextActivityPage> createState() => _NextActivityPageState();
}

class _NextActivityPageState extends State<NextActivityPage> {
  TextEditingController createDateController = TextEditingController();
  TextEditingController startTimeController = TextEditingController();
  TextEditingController endTimeController = TextEditingController();
  DateTime? _selectedDate;
  @override
  void initState() {
    super.initState();

    startTimeController.text = "11: AM";
    endTimeController.text = "1:PM";
    createDateController.text = "20 July,2023";
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // LatLng startLocation = _isLoading
    //     ? const LatLng(25.276987, 55.296249)
    //     : LatLng(latlong[0], latlong[1]);
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 225, 243, 246),
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Create Activity",
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.left,
          style: TextStyle(fontFamily: "ProximaNova", fontWeight: FontWeight.w700, fontSize: 17, color: Color(0xff160F29)),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 12, bottom: 1, top: 12),
            child: Row(children: [
              Image.asset(
                "assets/select.png",
                height: 18,
                width: 18,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                "Select Date",
                style: TextStyle(fontFamily: "ProximaNova", fontWeight: FontWeight.w400, fontSize: 16, color: Color(0xff736F7F)),
              ),
            ]),
          ),
          Container(
            margin: EdgeInsets.only(left: 15, right: 15, top: 10),
            child: TextFormField(
              onTap: () {
                _selectDate(context);
              },
              decoration: InputDecoration(
                suffixIcon: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    "assets/Chevon Left.png",
                    height: 6,
                    width: 6,
                  ),
                ),
                filled: true,
                fillColor: Colors.white,
                focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(6), borderSide: BorderSide(color: Colors.white)),
                disabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(6), borderSide: BorderSide(color: Colors.white)),
                enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(6), borderSide: BorderSide(color: Colors.white)),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(6), borderSide: BorderSide(color: Colors.white)),
                hintText: "12/04/2023",
                helperStyle: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w200,
                  color: Colors.grey,
                ),
              ),
              autofocus: true,
              controller: createDateController,
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 12, right: 12, top: 10),
            child: Row(children: [
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 10, bottom: 1, top: 12),
                    child: Row(children: [
                      Image.asset(
                        "assets/clock.png",
                        height: 18,
                        width: 18,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Start Time",
                        style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16, color: Color(0xff736F7F)),
                      ),
                    ]),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: 161,
                    height: 46,
                    child: TextField(
                      onTap: () {
                        _startTime(context);
                      },
                      controller: startTimeController,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(top: 20, left: 10),
                        suffixIcon: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset(
                            "assets/Chevon Left.png",
                            height: 6,
                            width: 6,
                          ),
                        ),
                        hintText: "10 : 00 AM",
                        filled: true,
                        fillColor: Colors.white,
                        focusedBorder:
                            OutlineInputBorder(borderRadius: BorderRadius.circular(6), borderSide: BorderSide(color: Colors.white)),
                        disabledBorder:
                            OutlineInputBorder(borderRadius: BorderRadius.circular(6), borderSide: BorderSide(color: Colors.white)),
                        enabledBorder:
                            OutlineInputBorder(borderRadius: BorderRadius.circular(6), borderSide: BorderSide(color: Colors.white)),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(6), borderSide: BorderSide(color: Colors.white)),
                      ),
                    ),
                  ),
                ],
              )),
              SizedBox(
                width: 10,
              ),
              Expanded(
                  child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 12, bottom: 1, top: 12),
                    child: Row(children: [
                      Image.asset(
                        "assets/clock.png",
                        height: 18,
                        width: 18,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "End Time",
                        style: TextStyle(fontFamily: "ProximaNova", fontWeight: FontWeight.w400, fontSize: 16, color: Color(0xff736F7F)),
                      ),
                    ]),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: 161,
                    height: 46,
                    child: TextField(
                      onTap: () {
                        _endTime(context);
                      },
                      controller: endTimeController,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(top: 20, left: 10),
                        suffixIcon: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset(
                            "assets/Chevon Left.png",
                            height: 6,
                            width: 6,
                          ),
                        ),
                        hintText: "10 : 00 AM",
                        filled: true,
                        fillColor: Colors.white,
                        focusedBorder:
                            OutlineInputBorder(borderRadius: BorderRadius.circular(6), borderSide: BorderSide(color: Colors.white)),
                        disabledBorder:
                            OutlineInputBorder(borderRadius: BorderRadius.circular(6), borderSide: BorderSide(color: Colors.white)),
                        enabledBorder:
                            OutlineInputBorder(borderRadius: BorderRadius.circular(6), borderSide: BorderSide(color: Colors.white)),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(6), borderSide: BorderSide(color: Colors.white)),
                      ),
                    ),
                  ),
                ],
              )),
            ]),
          ),
          Container(
            margin: EdgeInsets.only(left: 15, right: 15, top: 15),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    fixedSize: Size(343, 48),
                    backgroundColor: Color(0xff246A73)),
                onPressed: createProfile,
                child: Text(
                  "Ready To Share",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                )),
          ),
        ],
      ),
    );
  }

  _startTime(BuildContext context) async {
    var time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      //timeController.text = time.format(context) from here
    ); //end of showTimePicker
    startTimeController.text = time!.format(context); // to here
  }

  _endTime(BuildContext context) async {
    var time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      //timeController.text = time.format(context) from here
    ); //end of showTimePicker
    endTimeController.text = time!.format(context); // to here
  }

  _selectDate(BuildContext context) async {
    var newSelectedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2040),
    );

    if (newSelectedDate != null) {
      _selectedDate = newSelectedDate;
      createDateController
        ..text = DateFormat.yMMMd().format(_selectedDate!)
        ..selection = TextSelection.fromPosition(TextPosition(offset: createDateController.text.length, affinity: TextAffinity.upstream));
    }
  }

  void createProfile() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Are you sure to continue ?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
                'Yes',
                style: TextStyle(color: Colors.black),
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (builder) => MapScreenActivity(
                              cate: widget.cate,
                              title: widget.title,
                              desc: widget.description,
                              image: widget.image,
                              starttime: startTimeController.text,
                              endtime: endTimeController.text,
                              day: createDateController.text,
                            )));
              },
            ),
            TextButton(
              child: const Text(
                'No',
                style: TextStyle(color: Colors.black),
              ),
              onPressed: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (builder) => MainScreen()));
              },
            ),
          ],
        );
      },
    );
  }
}
