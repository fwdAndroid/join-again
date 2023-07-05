import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../utils/globals.dart';
import '../models/ChatMessageModel.dart';
import '../models/UserModel.dart';
import 'ImageChatComponent.dart';
import 'TextChatComponent.dart';

class ChatItemWidget extends StatefulWidget {
  final ChatMessageModel? data;
  final bool isGroup;

  ChatItemWidget({this.data, this.isGroup = false});

  @override
  _ChatItemWidgetState createState() => _ChatItemWidgetState();
}

class _ChatItemWidgetState extends State<ChatItemWidget> {
  String? images;
  UserModel userModel = UserModel();

  void initState() {
    super.initState();
    init();
  }

  init() async {
//    appStore.isLoading = true;
    await userService.getUserById(val: widget.data!.senderId).then((value) {
      userModel = value;
//      appStore.isLoading = false;
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String time;
    DateTime date = DateTime.fromMicrosecondsSinceEpoch(widget.data!.createdAt! * 1000);
    if (date.day == DateTime.now().day) {
      time = DateFormat('hh:mm a').format(DateTime.fromMicrosecondsSinceEpoch(widget.data!.createdAt! * 1000));
    } else {
      time = DateFormat('dd-MM-yyy hh:mm a').format(DateTime.fromMicrosecondsSinceEpoch(widget.data!.createdAt! * 1000));
    }

    EdgeInsetsGeometry customPadding(String? messageTypes) {
      switch (messageTypes) {
        case TEXT:
          return EdgeInsets.symmetric(horizontal: 12, vertical: 8);
        case IMAGE:
        case VIDEO:
        case DOC:
        case LOCATION:
        case AUDIO:
          return EdgeInsets.symmetric(horizontal: 4, vertical: 4);
        default:
          return EdgeInsets.symmetric(horizontal: 4, vertical: 4);
      }
    }

    // Future<void> openFile(String filePath) async {
    //   OpenFile.open(filePath);
    // }

    Widget chatItem(String? messageTypes) {
      switch (messageTypes) {
        case TEXT:
          return TextChatComponent(data: widget.data!, time: time);

        case IMAGE:
          return ImageChatComponent(data: widget.data!, time: time);
        default:
          return Container();
      }
    }

    return GestureDetector(
      // onLongPress: (){
      //   // if(floatingKey.currentContext==null)
      //   // floatingKey = GlobalKey(debugLabel: 'Floating');
      //  if( isFloatingOpen) {
      //    floating!.remove();
      //    // floating = createFloating();
      //    // Overlay.of(context)!.insert(floating!);
      //    // Overlay.of(context)!.activate();
      //  }
      //   // setState(() {
      //     if(isFloatingOpen) floating!.remove();
      //     else {
      //       floating = createFloating();
      //       Overlay.of(context)!.insert(floating!);
      //     }
      //     isFloatingOpen = !isFloatingOpen;
      //   // });
      // },
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: widget.data!.isMe.validate() ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          mainAxisAlignment: widget.data!.isMe! ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            Container(
              margin: widget.data!.isMe.validate()
                  ? EdgeInsets.only(top: 0.0, bottom: 0.0, left: isRTL ? 0 : context.width() * 0.25, right: 8)
                  : EdgeInsets.only(top: 2.0, bottom: 2.0, left: 8, right: isRTL ? 0 : context.width() * 0.25),
              padding: customPadding(widget.data!.messageType),
              decoration: widget.data!.messageType != MessageType.STICKER.name
                  ? BoxDecoration(
                      boxShadow: defaultBoxShadow(),
                      color: widget.data!.isMe.validate() ? Theme.of(context).primaryColor : context.cardColor,
                      borderRadius: widget.data!.isMe.validate()
                          ? radiusOnly(bottomLeft: chatMsgRadius, topLeft: chatMsgRadius, bottomRight: chatMsgRadius, topRight: 0)
                          : radiusOnly(bottomLeft: chatMsgRadius, topLeft: 0, bottomRight: chatMsgRadius, topRight: chatMsgRadius),
                    )
                  : null,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (widget.isGroup && userModel.name != null && !widget.data!.isMe.validate())
                    Text(userModel.name.validate(), style: boldTextStyle(size: 12, color: Colors.white)).paddingAll(1),
                  if (widget.isGroup && userModel.name != null && !widget.data!.isMe.validate()) 8.height,
                  chatItem(widget.data!.messageType),
                ],
              ),
            ),
          ],
        ),
        margin: EdgeInsets.only(top: 2, bottom: 2),
      ),
    );
  }
}
// if (widget.isGroup && userModel.name != null && !widget.data!.isMe.validate()) 8.height,
//   Stack(
//     children: [
//       chatItem(widget.data!.messageType),
//       FlutterFeedReaction(
//         reactions: [
//           FeedReaction(
//             name: 'Like',
//             reaction: Icon(
//               Icons.star,
//               size: 35.0,
//               color: Colors.blue,
//             ),
//           ),
//           FeedReaction(
//             name: 'Love',
//             reaction: Icon(
//               Icons.star,
//               size: 35.0,
//               color: Colors.red,
//             ),
//           ),
//           FeedReaction(
//             name: 'Care',
//             reaction: Icon(
//               Icons.star,
//               size: 35.0,
//               color: Colors.deepPurple,
//             ),
//           ),
//           FeedReaction(
//             name: 'Lol',
//             reaction: Icon(
//               Icons.star,
//               size: 35.0,
//               color: Colors.yellow,
//             ),
//           ),
//           FeedReaction(
//             name: 'Sad',
//             reaction: Icon(
//               Icons.star,
//               size: 35.0,
//               color: Colors.green,
//             ),
//           ),
//         ],
//         prefix:!widget.data!.isMe.validate()?Container(color: Colors.grey,
//           ):SizedBox(),
//         suffix:widget.data!.isMe.validate()? SizedBox():Container(color: Colors.grey,
//           width: 20,height: 20,
//         ),
//         onReactionSelected: (val) {
//           toast(val.name);
//         },
//         onPressed: () {
//           toast("Pressed");
//         },
//         dragSpace: 0.0,
//       ),
//     ],
//   ),
