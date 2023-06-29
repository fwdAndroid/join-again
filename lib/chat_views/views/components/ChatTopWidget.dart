import 'package:join/chat_views/views/globals.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';

import '../models/UserModel.dart';

class ChatAppBarWidget extends StatefulWidget {
  final UserModel? receiverUser;

  ChatAppBarWidget({required this.receiverUser});

  @override
  ChatAppBarWidgetState createState() => ChatAppBarWidgetState();
}

class ChatAppBarWidgetState extends State<ChatAppBarWidget> {
  bool isRequestAccept = false;
  bool isBlocked = false;

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {

    isRequestAccept=true;
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    String getTime(int val) {
      String? time;
      DateTime date = DateTime.fromMicrosecondsSinceEpoch(val * 1000);
      if (date.day == DateTime.now().day) {
        time = "at ${DateFormat('hh:mm a').format(date)}";
      } else {
        time = date.timeAgo;
      }
      return time;
    }

    return AppBar(
      automaticallyImplyLeading: false,
      title: StreamBuilder<UserModel>(
        stream: userService.singleUser(widget.receiverUser!.uid),
        builder: (context, snap) {
          if (snap.hasError) {
            return Container();
          }
          if (snap.hasData) {
            UserModel data = snap.data!;

            return Row(
              children: [
                GestureDetector(
                  onTap: (){
                    finish(context, true);
                  },
                  child: Row(
                    children: [
                      Icon(Icons.arrow_back, color: whiteColor),
                      4.width,
                      data.photoUrl!.isEmpty
                          ? Hero(
                              tag: data.uid.validate(),
                              child: noProfileImageFound(height: 35, width: 35),
                            )
                          : Hero(
                              tag: data.uid!,
                              child: Image.network(
                                data.photoUrl.validate(),
                                height: 35,
                                width: 35,
                                fit: BoxFit.cover,
                                errorBuilder: (_, __, ___) {
                                  return noProfileImageFound(height: 35, width: 35);
                                },
                              ).cornerRadiusWithClipRRect(50)),
                    ],
                  ).paddingSymmetric(vertical: 16),
                ),
                10.width,
                GestureDetector(
                  onTap: (){
//                    UserProfileScreen(uid: data.uid.validate()).launch(context, pageRouteAnimation: PageRouteAnimation.Scale, duration: 300.milliseconds);
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(data.name!, style: TextStyle(color: whiteColor)),
                    ],
                  ).paddingSymmetric(vertical: 16),
                ).expand(),
              ],
            );
          }

          return snapWidgetHelper(snap, loadingWidget: Container());
        },
      ),
      actions: [
      ],
      backgroundColor: context.primaryColor,
    );
  }


}
