import 'package:flutter/material.dart';

import 'accepted_request.dart';
import 'all_request.dart';
import 'denied_request.dart';


class EventRequestTab extends StatefulWidget {
  const EventRequestTab({super.key});

  @override
  State<EventRequestTab> createState() => _EventRequestTabState();
}

class _EventRequestTabState extends State<EventRequestTab> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 1,
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          centerTitle: true,
          title: Text(
            "Event Request",
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
                text: "Request",
              ),
              Tab(
                text: "Accepted",
              ),
              Tab(
                text: 'Denied',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            AllRequest(),
            AcceptedRequest(),
            DeniedRequest(),
          ],
        ),
      ),
    );
  }
}
