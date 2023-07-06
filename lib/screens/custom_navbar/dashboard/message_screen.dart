import 'package:flutter/material.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({super.key});

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 1,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          // actions: [
          //   Padding(
          //     padding: const EdgeInsets.all(8.0),
          //     child: InkWell(
          //       onTap: () {
          //         Navigator.push(context,
          //             MaterialPageRoute(builder: (builder) => NewChatScreen()));
          //       },
          //       child: Icon(
          //         Icons.search,
          //         color: Theme.of(context).primaryColor,
          //       ),
          //     ),
          //   )
          // ],
          centerTitle: true,
          automaticallyImplyLeading: false,
          title: const Text(
            "Messages",
            style: TextStyle(
                fontFamily: "ProximaNova",
                fontSize: 20,
                color: Color(0xff160F29),
                fontWeight: FontWeight.w600),
          ),
          bottom: const TabBar(
            labelColor: Colors.black,
            tabs: <Widget>[
              Tab(text: "Events"),
              Tab(text: "People"),
            ],
          ),
        ),
        body: const TabBarView(
          children: <Widget>[
            // TODOs Create Own
            Center(child: Text("Event Chat")),
            Center(child: Text("People Chat"))
          ],
        ),
      ),
    );
  }
}
