import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:intl/intl.dart';

class CurrentChatRoom extends StatefulWidget {
  String receiverId;
  String receiverName;
  String doctorId;
  String doctorName;
  CurrentChatRoom({
    Key? key,
    required this.receiverName,
    required this.doctorId,
    required this.doctorName,
    required this.receiverId,
  }) : super(key: key);

  @override
  State<CurrentChatRoom> createState() => _CurrentChatRoomState();
}

class _CurrentChatRoomState extends State<CurrentChatRoom> {
  String groupChatId = "";
  ScrollController scrollController = ScrollController();
  File? imageUrl;
  UploadTask? task;
  File? file;
  bool _isLoading = false;

  TextEditingController messageController = TextEditingController();
  String? imageLink, fileLink;
  firebase_storage.UploadTask? uploadTask;

  @override
  void initState() {
    // TODO: implement initState
    if (FirebaseAuth.instance.currentUser!.uid.hashCode <=
        widget.receiverId.hashCode) {
      groupChatId =
          "${FirebaseAuth.instance.currentUser!.uid}-${widget.receiverId}";
    } else {
      groupChatId =
          "${widget.receiverId}-${FirebaseAuth.instance.currentUser!.uid}";
    }
    // firebaseFirestore.collection("users").doc(widget.receiverId).get().then((value) {
    //   setState(() {
    //     receiverimageLink= value.get("imageLink");
    //     receiverName=value.get("UserName");
    //   });
    // });

    super.initState();
  }

  bool show = false;

  String myStatus = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        backgroundColor: Colors.white,
        title: Column(
          children: [
            Text(
              widget.doctorName,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black),
            ),
            SizedBox(
              height: 6,
            ),
            Text(
              widget.receiverName,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black),
            ),
          ],
        ),
      ),
      body: WillPopScope(
        onWillPop: () {
          if (show) {
            setState(() {
              show = false;
            });
          } else {
            Navigator.pop(context);
          }
          return Future.value(false);
        },
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: <Widget>[
              StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("messages")
                      .doc(groupChatId)
                      .collection(groupChatId)
                      .orderBy("timestamp", descending: false)
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasData) {
                      return snapshot.data!.docs == 0
                          ? Center(child: CircularProgressIndicator.adaptive())
                          : Expanded(
                              child: ListView.builder(
                                reverse: false,
                                controller: scrollController,
                                itemCount: snapshot.data!.docs.length,
                                shrinkWrap: true,
                                padding: EdgeInsets.only(top: 10, bottom: 10),
                                itemBuilder: (context, index) {
                                  var ds = snapshot.data!.docs[index];
                                  return ds.get("type") == 0
                                      ? Container(
                                          padding: EdgeInsets.only(
                                              // left: 14,
                                              // right: 14,
                                              top: 10,
                                              bottom: 10),
                                          child: Align(
                                            alignment: (ds.get("senderId") ==
                                                    FirebaseAuth.instance
                                                        .currentUser!.uid
                                                ? Alignment.bottomRight
                                                : Alignment.bottomLeft),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: (ds.get("senderId") ==
                                                        FirebaseAuth.instance
                                                            .currentUser!.uid
                                                    ? Colors.grey.shade100
                                                    : Colors.blue[100]),
                                              ),
                                              padding: EdgeInsets.all(16),
                                              child: Column(
                                                children: [
                                                  Text(
                                                    ds.get("content"),
                                                    style:
                                                        TextStyle(fontSize: 15),
                                                  ),
                                                  Text(
                                                    DateFormat.jm().format(
                                                      DateTime
                                                          .fromMillisecondsSinceEpoch(
                                                        int.parse(
                                                          ds.get("time"),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        )
                                      : Container();
                                },
                              ),
                            );
                    } else if (snapshot.hasError) {
                      return Center(child: Icon(Icons.error_outline));
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  }),
              Align(
                alignment: Alignment.bottomLeft,
                child: Container(
                  padding: EdgeInsets.only(left: 10, bottom: 10, top: 10),
                  height: 60,
                  width: double.infinity,
                  color: Colors.white,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: TextField(
                          controller: messageController,
                          decoration: InputDecoration(
                              hintText: "Write message...",
                              hintStyle: TextStyle(color: Colors.black54),
                              border: InputBorder.none),
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      FloatingActionButton(
                        onPressed: () {
                          sendMessage(messageController.text.trim(), 0);
                        },
                        child: Icon(
                          Icons.send,
                          color: Colors.white,
                          size: 18,
                        ),
                        backgroundColor: Colors.blue,
                        elevation: 0,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void sendMessage(String content, int type) {
    // type: 0 = text, 1 = image, 2 = sticker
    if (content.trim() != '') {
      messageController.clear();

      var documentReference = FirebaseFirestore.instance
          .collection('messages')
          .doc(groupChatId)
          .collection(groupChatId)
          .doc(DateTime.now().millisecondsSinceEpoch.toString());

      FirebaseFirestore.instance.runTransaction((transaction) async {
        await transaction.set(
          documentReference,
          {
            "senderId": FirebaseAuth.instance.currentUser!.uid,
            "receiverId": widget.receiverId,
            "time": DateTime.now().millisecondsSinceEpoch.toString(),
            'timestamp': DateTime.now().millisecondsSinceEpoch.toString(),
            'content': content,
            'type': type
          },
        );
      });
      scrollController.animateTo(0.0,
          duration: Duration(milliseconds: 300), curve: Curves.easeOut);
    } else {
      // Fluttertoast.showToast(msg: 'Nothing to send');
    }
  }
}
