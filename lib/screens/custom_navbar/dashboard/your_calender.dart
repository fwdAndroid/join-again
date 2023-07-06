import 'package:flutter/material.dart';
import 'package:join/screens/calender/ongoing.dart';

class YourCalender extends StatelessWidget {
  const YourCalender({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          automaticallyImplyLeading: false,
          title: const Text(
            "Your Calender",
            style: TextStyle(
                fontFamily: "ProximaNova",
                fontSize: 20,
                color: Color(0xff160F29),
                fontWeight: FontWeight.w600),
          ),
        ),
        body: OnGoing());
  }
}
