import 'package:join/chat_views/views/components/UserListComponent.dart';
import 'package:join/chat_views/views/models/UserModel.dart';
import 'package:join/chat_views/views/utils/Appwidgets.dart';

import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import 'globals.dart';

class NewChatScreen extends StatefulWidget {
  @override
  _NewChatScreenState createState() => _NewChatScreenState();
}

class _NewChatScreenState extends State<NewChatScreen> {
  bool isSearch = true;
  bool autoFocus = false;
  TextEditingController searchCont = TextEditingController();
  String search = '';

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    //
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(
        "New Chat",
        textColor: Colors.white,
        actions: [
          AnimatedContainer(
            margin: EdgeInsets.only(left: 8),
            duration: Duration(milliseconds: 100),
            curve: Curves.decelerate,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                  TextField(
                    autofocus: true,
                    textAlignVertical: TextAlignVertical.center,
                    cursorColor: Theme.of(context).primaryColor,
                    onChanged: (s) {
                      setState(() {});
                    },
                    style: TextStyle(color: Colors.black,fontSize: 16),
                    controller: searchCont,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Search here...',
                      hintStyle: TextStyle(color: Colors.black,fontSize: 16),
                    ),
                  ).expand(),
              ],
            ),
            width: isSearch ? context.width() - 86 : 50,
          ),
        ],
      ),
      body: StreamBuilder<List<UserModel>>(
        stream: userService.users(searchText: searchCont.text),
        builder: (_, snap) {
          print(snap.data);
          if (snap.hasData) {
            if (snap.data!.length == 0) {
              return noDataFound(text: isSearch ? "No Result" : "No Data Found").withHeight(context.height()).center();
            }
            return SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Column(children: [
                UserListComponent(snap: snap, isGroupCreate: false)
              ]),
            );
          }
          return snapWidgetHelper(snap);
        },
      ),
    );
  }
}
