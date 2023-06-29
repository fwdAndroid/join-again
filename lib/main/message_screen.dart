import 'package:flutter/material.dart';
import 'package:join/calenderpages/all.dart';
import 'package:join/calenderpages/ongoing.dart';
import 'package:join/calenderpages/past.dart';
import 'package:join/chat_views/views/ChatListScreen.dart';
import 'package:join/chat_views/views/NewChatScreen.dart';
import 'package:join/messages_screen/event_chat.dart';
import 'package:join/messages_screen/people_chat.dart';
import 'package:nb_utils/nb_utils.dart';

/// Flutter code sample for [TabBar].

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
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                  onTap: (){
                    Navigator.push(context,
                        MaterialPageRoute(builder: (builder) => NewChatScreen()));
                  },
                  child: Icon(Icons.search,color: Theme.of(context).primaryColor,)),
            )
          ],
          centerTitle: true,
          automaticallyImplyLeading: false,
          title: Text(
            "Messages",
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
                text: "Events",
              ),
              Tab(
                text: "People",
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            EventsChat(),
            ChatListScreen(),
          ],
        ),
      ),
    );
  }
}
