import 'package:flutter/material.dart';
import 'package:join/screens/calender/all.dart';
import 'package:join/screens/calender/ongoing.dart';
import 'package:join/screens/calender/past.dart';

class YourCalender extends StatelessWidget {
  const YourCalender({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 1,
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          automaticallyImplyLeading: false,
          title: const Text(
            "Your Calender",
            style: TextStyle(fontFamily: "ProximaNova", fontSize: 20, color: Color(0xff160F29), fontWeight: FontWeight.w600),
          ),
          bottom: const TabBar(
            labelColor: Colors.black,
            tabs: <Widget>[
              Tab(
                text: "All",
              ),
              Tab(
                text: "OnGoing",
              ),
              Tab(
                text: 'Past',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            All(),
            OnGoing(),
            Past(),
          ],
        ),
      ),
    );
  }
}
