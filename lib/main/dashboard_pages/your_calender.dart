import 'package:flutter/material.dart';
import 'package:join/calenderpages/all.dart';
import 'package:join/calenderpages/ongoing.dart';
import 'package:join/calenderpages/past.dart';

/// Flutter code sample for [TabBar].

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
          title: Text(
            "Your Calender",
            style: TextStyle(
                fontFamily: "ProximaNova",
                fontSize: 20,
                color: Color(0xff160F29),
                fontWeight: FontWeight.w600),
          ),
          bottom: TabBar(
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
