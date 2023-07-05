import 'dart:async';

import 'package:flutter/material.dart';
import 'package:join/chat_views/views/ChatScreen.dart';
import 'package:join/chat_views/views/utils/Appwidgets.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../utils/globals.dart';
import '../models/UserModel.dart';

class UserListComponent extends StatefulWidget {
  final AsyncSnapshot<List<UserModel>>? snap;
  final bool isGroupCreate;
  final bool isAddParticipant;
  final List<dynamic>? data;

  UserListComponent({this.snap, this.isGroupCreate = false, this.isAddParticipant = false, this.data});

  @override
  UserListComponentState createState() => UserListComponentState();
}

class UserListComponentState extends State<UserListComponent> {
  List<UserModel> _selectedList = [];
  List<String> selected = [];
  List<dynamic> existingMembersList = [];

  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    if (widget.data != null) {
      existingMembersList = widget.data!;
    }
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        ListView.separated(
          physics: widget.isGroupCreate ? AlwaysScrollableScrollPhysics() : NeverScrollableScrollPhysics(),
          itemCount: widget.snap!.data!.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            UserModel data = widget.snap!.data![index];
            if (data.uid == userID) {
              return 0.height;
            }
            return Container(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Row(
                children: [
                  Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      data.photoUrl!.isEmpty
                          ? Hero(
                              tag: data.uid.validate(),
                              child: Container(
                                height: 50,
                                width: 50,
                                padding: EdgeInsets.all(10),
                                color: Colors.red,
                                child: Text(data.name.validate()[0].toUpperCase(), style: secondaryTextStyle(color: Colors.white))
                                    .center()
                                    .fit(),
                              ).cornerRadiusWithClipRRect(50),
                            )
                          : cachedImage(data.photoUrl.validate(), width: 50, height: 50, fit: BoxFit.cover).cornerRadiusWithClipRRect(80),
                      if (selected.contains(data.uid)) Icon(Icons.check_circle, color: Colors.green)
                    ],
                  ),
                  12.width,
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${data.name.validate()}', style: primaryTextStyle()),
                      //Text('${data.userStatus.validate()}', style: secondaryTextStyle()),
                    ],
                  ).expand(),
//                  userService.getPreviouslyChat(data.uid!) ? Text('already_added'.translate, style: secondaryTextStyle()) : Offstage()
                ],
              ),
            ).onTap(() {
              ChatScreen(data).launch(context);
            });
          },
          separatorBuilder: (BuildContext context, int index) {
            if (widget.snap!.data![index].uid == userID) {
              return 0.height;
            }
            return Divider(indent: 80, height: 0);
          },
        ).paddingTop(_selectedList.isNotEmpty ? 100 : 0),
      ],
    );
  }
}
