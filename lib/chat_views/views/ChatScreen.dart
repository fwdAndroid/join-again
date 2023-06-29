import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:join/chat_views/views/components/ChatTopWidget.dart';
import 'package:join/chat_views/views/send_notification.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:paginate_firestore/paginate_firestore.dart';

import 'components/ChatItemWidget.dart';
import 'components/MultipleSelectedAttachment.dart';
import 'globals.dart';
import 'models/ChatMessageModel.dart';
import 'models/ContactModel.dart';
import 'models/FileModel.dart';
import 'models/UserModel.dart';
import 'services/ChatMessageService.dart';

class ChatScreen extends StatefulWidget {
  final UserModel? receiverUser;

  ChatScreen(this.receiverUser);

  @override
  ChatScreenState createState() => ChatScreenState();
}

class ChatScreenState extends State<ChatScreen> with WidgetsBindingObserver {
   ChatMessageService chatMessageService=ChatMessageService();
  String id = '';


  TextEditingController messageCont = TextEditingController();
  FocusNode messageFocus = FocusNode();

  bool isFirstMsg = false;
  bool isBlocked = false;

  String? currentLat;
  String? currentLong;

  bool showPlayer = false;
  String? audioPath;

  Future<bool>? requestData;

  @override
  void initState() {
    super.initState();
    init();

  }


  init() async {
    WidgetsBinding.instance.addObserver(this);

    id = userID;

    mChatFontSize = 16;
    mIsEnterKey = false;
    mSelectedImage ='assets/Group 1000001315.png';

    chatMessageService = ChatMessageService();
    chatMessageService.setUnReadStatusToTrue(senderId: userID, receiverId: widget.receiverUser!.uid!);

//    requestData = chatRequestService.isRequestsUserExist(widget.receiverUser!.uid!);
    setState(() {});
  }

 /* void getLocation() async {
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    currentLat = position.latitude.toString();
    currentLong = position.longitude.toString();

    sendMessage(type: TYPE_LOCATION);
    if (messageCont.text.trim().isEmpty) {
      // messageFocus.requestFocus();
      return;
    }
  }*/

  void sendMessage({FilePickerResult? result, String? stickerPath, File? filepath, String? type}) async {
    print("Step2");


    ChatMessageModel data = ChatMessageModel();
    data.receiverId = widget.receiverUser!.uid;
    data.senderId = userID;
    data.message = messageCont.text;
    data.isMessageRead = false;
    data.stickerPath = stickerPath;
    data.createdAt = DateTime.now().millisecondsSinceEpoch;
    data.isEncrypt = false;
    if (result != null) {
      if (type == TYPE_Image) {
        print("Step3");

        data.messageType = MessageType.IMAGE.name;
      } else if (type == TYPE_VIDEO) {
        data.messageType = MessageType.VIDEO.name;
      } else if (type == TYPE_AUDIO) {
        data.messageType = MessageType.AUDIO.name;
      } else if (type == TYPE_DOC) {
        log(MessageType.DOC.name);
        data.messageType = MessageType.DOC.name;
      } else if (type == TYPE_VOICE_NOTE) {
        data.messageType = MessageType.VOICE_NOTE.name;
      } else {
        data.messageType = MessageType.TEXT.name;
        data.message = encryptData(messageCont.text);
        data.isEncrypt = true;
        log(data.messageType);
        log(messageCont.text);
      }
    } else if (stickerPath.validate().isNotEmpty) {
      data.messageType = MessageType.STICKER.name;
    } else {
      if (type == TYPE_LOCATION) {
        data.messageType = MessageType.LOCATION.name;
        data.currentLat = currentLat;
        data.currentLong = currentLong;
      } else if (type == TYPE_VOICE_NOTE) {
        data.messageType = MessageType.VOICE_NOTE.name;
        log(data.messageType);
        log(MessageType.VOICE_NOTE.name);
      } else {
        data.messageType = MessageType.TEXT.name;
        data.message = encryptData(messageCont.text);
        data.isEncrypt = true;
      }
    }
    print("Step4");


    sendNormalMessages(data, result: result != null ? result : null, filepath: filepath);

    chatMessageService.getContactsDocument(of: userID, forContact: widget.receiverUser!.uid).update(<String, dynamic>{
      "lastMessageTime": DateTime.now().millisecondsSinceEpoch,
    });

  }

  void sendNormalMessages(ChatMessageModel data, {FilePickerResult? result, File? filepath}) async {
    fileList.clear();
    if (isFirstMsg) {
      ContactModel data = ContactModel();
      data.uid = widget.receiverUser!.uid;
      data.addedOn = Timestamp.now();
      data.lastMessageTime = DateTime.now().millisecondsSinceEpoch;

      chatMessageService.getContactsDocument(of:userID, forContact: widget.receiverUser!.uid).set(data.toJson()).then((value) {
        print('here:');
      }).catchError((e) {
        log(e);
      });
      ContactModel data2 = ContactModel();
      data2.uid = userID;
      data2.addedOn = Timestamp.now();
      data2.lastMessageTime = DateTime.now().millisecondsSinceEpoch;
      chatMessageService.getContactsDocument(of:widget.receiverUser!.uid, forContact: userID).set(data2.toJson()).then((value) {
        print('here:');
      }).catchError((e) {
        log(e);
      });
    }
    ///notification
    try{
      UserModel userData=await  userService.getUserById(val: userID);
      SendNotification().sendNoti(title: userData.name.toString()+" sent you ${messageCont.text.isEmpty?'an image':'a message'}",
          body: messageCont.text, fcmToken: widget.receiverUser!.fcmToken.toString());

    }catch(e){

    }
//    notificationService.sendPushNotifications(getStringAsync(userDisplayName), messageCont.text, receiverPlayerId: widget.receiverUser!.oneSignalPlayerId).catchError(log);
    messageCont.clear();
    setState(() {});

    await chatMessageService.addMessage(data,false).then((value) async {
      if (result != null) {
        FileModel fileModel = FileModel();
        fileModel.id = value.id;
        fileModel.file = File(result.files.single.path!);
        fileList.add(fileModel);

        setState(() {});

        // ignore: unnecessary_null_comparison
        await chatMessageService
            .addMessageToDb(senderDoc: value, data: data, sender: sender, user: widget.receiverUser, image: result != null ? File(result.files.single.path!) : null, isRequest: false)
            .then((value) {
          //
        });

      }
    });
    data.isMessageRead=true;
    fileList.clear();

    if(result==null){
      await chatMessageService.addMessage(data,true).then((value) async {

        if (result != null) {
          FileModel fileModel = FileModel();
          fileModel.id = value.id;
          fileModel.file = File(result.files.single.path!);
          fileList.add(fileModel);

          setState(() {});

          // ignore: unnecessary_null_comparison
          await chatMessageService
              .addMessageToDb(senderDoc: value, data: data, sender: sender, user: widget.receiverUser, image: result != null ? File(result.files.single.path!) : null, isRequest: false)
              .then((value) {
            //
          });

        }
      })      ;
    }


    print('both ids:${userID}:${widget.receiverUser!.uid}');
    userService.fireStore
        .collection(USER_COLLECTION)
        .doc(userID)
        .collection(CONTACT_COLLECTION)
        .doc(widget.receiverUser!.uid)
        .update({'lastMessageTime': DateTime.now().millisecondsSinceEpoch}).catchError((e) {
      log('error1:$e');
 /*     if(e.toString().contains('not-found')){
        userService.fireStore
            .collection(USER_COLLECTION)
            .doc(userID)
            .collection(CONTACT_COLLECTION)
            .doc(widget.receiverUser!.uid)
            .set({'lastMessageTime': DateTime.now().millisecondsSinceEpoch}).catchError((e) {
          log('error11:$e');
        }).then((value) {
          print('own contact created2');
        });
      }*/
    }).then((value) {
      print('own contact created');
    });


    userService.fireStore
        .collection(USER_COLLECTION)
        .doc(widget.receiverUser!.uid)
        .collection(CONTACT_COLLECTION)
        .doc(userID)
        .update({'lastMessageTime': DateTime.now().millisecondsSinceEpoch}).catchError((e) {
      log('error2:$e');
    /*  if(e.toString().contains('not-found')) {
        userService.fireStore
            .collection(USER_COLLECTION)
            .doc(widget.receiverUser!.uid)
            .collection(CONTACT_COLLECTION)
            .doc(userID)
            .set({'lastMessageTime': DateTime.now().millisecondsSinceEpoch}).catchError((e) {
          log('error22:$e');
          if(e.conains('not-found')) {

          }
        }).then((value) {
          print('other contact created2');
        });
      }*/
      }).then((value) {
      print('other contact created');
    });
  }


  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    super.didChangeAppLifecycleState(state);

/*
    if (state == AppLifecycleState.detached) {
      oneSignal.disablePush(false);
    }

    if (state == AppLifecycleState.paused) {
      oneSignal.disablePush(false);
    }
    if (state == AppLifecycleState.resumed) {
      oneSignal.disablePush(true);
    }
*/
  }

  @override
  void dispose() async {
    // myInterstitial?.show();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }


  _showAttachmentDialog() {
    return showDialog(
      barrierColor: Colors.transparent,
      context: context,
      builder: (context) {
        return Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            padding: EdgeInsets.only(top: 16, bottom: 16, left: 12, right: 12),
            margin: EdgeInsets.only(bottom: 78, left: 12, right: 12),
            decoration: BoxDecoration(
              color: context.scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Material(
              color: context.scaffoldBackgroundColor,
              child: Wrap(
                spacing: 16,
                runSpacing: 16,
                children: [
                  iconsBackgroundWidget(context, name: "Gallery", iconData: Icons.image, color: Colors.purple.shade400).onTap(() async {
                  //

                    FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.image, allowMultiple: true, allowCompression: true);

                    if (result != null) {
                      List<File> image = [];
                      result.files.map((e) {
                        image.add(File(e.path.validate()));
                      }).toList();
                      // finish(context);
                      bool res = await MultipleSelectedAttachment(attachedFiles: image, userModel: widget.receiverUser, isImage: true).launch(context);
                      if (res) {
                        finish(context);
                        print("Step1");
//                        await ChatScreen(widget.receiverUser).launch(context);
                        result.files.map((e) {
                          sendMessage(result: result, filepath: File(e.path.validate()), type: TYPE_Image);
                        }).toList();
                      }
                    } else {
                      // User canceled the picker
                    }
                  }),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget buildChatRequestWidget(AsyncSnapshot<bool> snap) {
      if (snap.hasData) {
        return getRequestedWidget(snap.data!);
      } else if (snap.hasError) {
        return getRequestedWidget(false);
      } else {
        return getRequestedWidget(false);
      }
    }

    return Scaffold(
      backgroundColor: context.scaffoldBackgroundColor,
        appBar: PreferredSize(preferredSize: Size(context.width(), kToolbarHeight), child: ChatAppBarWidget(receiverUser: widget.receiverUser!)),
      body: Container(
        child: FutureBuilder<bool>(
          future: requestData,
          builder: (context, snap) {
            return Stack(
              fit: StackFit.expand,
              children: [
/*
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: Image.asset(mSelectedImage).image,
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(Colors.black54, BlendMode.luminosity),
                    ),
                  ),
                ),
*/
                PaginateFirestore(
                  reverse: true,
                  isLive: true,
                  padding: EdgeInsets.only(left: 8, top: 8, right: 8, bottom: 0),
                  physics: BouncingScrollPhysics(),
                  query: chatMessageService.chatMessagesWithPagination(currentUserId: userID, receiverUserId: widget.receiverUser!.uid!),
                  itemsPerPage: PER_PAGE_CHAT_COUNT,
                  shrinkWrap: true,
                  onLoaded: (page) {
                    isFirstMsg = page.documentSnapshots.isEmpty;
                  },
                  onEmpty: SizedBox(),
                  itemBuilderType: PaginateBuilderType.listView,
                  itemBuilder: (context, snap, index) {
                    ChatMessageModel data = ChatMessageModel.fromJson(snap[index].data() as Map<String, dynamic>);
                    print('sender id:${data.senderId}:${data.receiverId}');
                    data.isMe = data.senderId == id;
                    return ChatItemWidget(data: data);
                  },
                ).paddingBottom(snap.hasData ? (snap.data! ? 176 : 76) : 76),
                buildChatRequestWidget(snap),
              ],
            );
          },
        ),
      ).onTap(() {
        hideKeyboard(context);
      }),
    );
  }
///EWoYlJYIlbTzlmkrqXsvmSGXEal1:a3IwdwOqpTMD2mc1LyQCwIWuUTq1
   Widget getRequestedWidget(bool isRequested) {
     return Positioned(
       bottom: 16,
       left: 16,
       right: 16,
       child: Stack(
         alignment: Alignment.bottomRight,
         children: [
           Row(
             crossAxisAlignment: CrossAxisAlignment.end,
             children: [
               Container(
                 decoration: boxDecorationWithShadow(borderRadius: BorderRadius.circular(30), spreadRadius: 0, blurRadius: 0, backgroundColor: context.cardColor),
                 padding: EdgeInsets.only(left: 0, right: 8),
                 child: Row(
                   children: [
/*
                     IconButton(
                       icon: Icon(LineIcons.smiling_face_with_heart_eyes),
                       iconSize: 24.0,
                       padding: EdgeInsets.all(2),
                       color: Colors.grey,
                       onPressed: () {

                       },
                     ),
*/
                   SizedBox(
                     width: 10,
                   ),
                     AppTextField(
                       controller: messageCont,
                       textFieldType: TextFieldType.OTHER,
                       cursorColor:Colors.black,
                       focus: messageFocus,
                       textCapitalization: TextCapitalization.sentences,
                       keyboardType: TextInputType.multiline,
                       minLines: 1,
                       maxLines: 5,
                       textInputAction: mIsEnterKey ? TextInputAction.send : TextInputAction.newline,
                       onFieldSubmitted: (p0) {
                         sendMessage();
                       },
                       onChanged: (s) {
                         setState(() {});
                       },
                       decoration: InputDecoration(
                         border: InputBorder.none,
                         hintText: 'Enter here',
                         hintStyle: secondaryTextStyle(size: 16),
                         isDense: true,
                       ),
                     ).expand(),
                     IconButton(
                       visualDensity: VisualDensity(horizontal: 0, vertical: 1),
                       icon: Icon(Icons.image),
                       iconSize: 25.0,
                       padding: EdgeInsets.all(2),
                       color: Colors.grey,
                       onPressed: () async {
//                         _showAttachmentDialog();
                         hideKeyboard(context);
                         FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.image, allowMultiple: true, allowCompression: true);

                         if (result != null) {
                           List<File> image = [];
                           result.files.map((e) {
                             image.add(File(e.path.validate()));
                           }).toList();
                           // finish(context);
                           bool res = await MultipleSelectedAttachment(attachedFiles: image, userModel: widget.receiverUser, isImage: true).launch(context);
                           if (res) {
                             finish(context);
                             print("Step1");
                             await ChatScreen(widget.receiverUser).launch(context);
                             result.files.map((e) {
                               sendMessage(result: result, filepath: File(e.path.validate()), type: TYPE_Image);
                             }).toList();
                           }
                         } else {
                           // User canceled the picker
                         }
                       },
                     ),
                   ],
                 ),
                 width: context.width(),
               ).expand(),
               8.width,
                 GestureDetector(
                   onTap: () {
                     if(messageCont.text.trim().isNotEmpty)
                     sendMessage();
                   },
                   child: Container(
                     width: 50,
                     height: 50,
                     alignment: Alignment.center,
                     decoration: BoxDecoration(color:messageCont.text.trim().isNotEmpty? Theme.of(context).primaryColor:Colors.grey.withOpacity(0.4), shape: BoxShape.circle),
                     child: Icon(Icons.send, color:messageCont.text.trim().isNotEmpty?Colors.white:Colors.grey, size: 22),
                   ),
                 ),
//               if (messageCont.text.isEmpty) SizedBox(width: 48)
             ],
           ),
         ],
       ),
     );
   }

}
