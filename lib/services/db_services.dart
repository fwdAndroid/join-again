import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:uuid/uuid.dart';

class DatabaseServices {
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  Future<void> likePosts(String uid, List likes) async {
    try {
      if (likes.contains(uid)) {
        await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).update({
          "likes": FieldValue.arrayRemove([uid])
        });
      } else {
        await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).update({
          "likes": FieldValue.arrayUnion([uid])
        });
      }
    } catch (E) {
      print(E.toString());
    }
  }

  static sendRequestToUserForChat({BuildContext? context, String? receiverId}) async {
    var requestId = const Uuid().v1();
    try {
      EasyLoading.show(status: "Please Wait");
      await FirebaseFirestore.instance.collection("requests").doc(requestId).set({
        "senderId": FirebaseAuth.instance.currentUser!.uid,
        "receiverId": receiverId,
        "requestId": requestId,
        "createdAt": DateTime.now(),
        "status": "pending",
      });
      EasyLoading.dismiss();
      Navigator.pop(context!);
    } on FirebaseException catch (e) {
      EasyLoading.showError(e.message.toString());

      EasyLoading.dismiss();
    }
  }

  static cancelRequest({String? docId}) async {
    try {
      EasyLoading.show(status: "Please Wait");
      await FirebaseFirestore.instance.collection("requests").doc(docId).delete();
      EasyLoading.dismiss();
      EasyLoading.showSuccess("Successfully Deleted the Request");
    } on FirebaseException catch (e) {
      EasyLoading.showError(e.message.toString());
      EasyLoading.dismiss();
    }
  }

  static acceptRequest({String? docId, String? myId, String? friendId}) async {
    try {
      EasyLoading.show(status: "Please Wait");
      await FirebaseFirestore.instance.collection("requests").doc(docId).update({
        "status": "accept",
      });
      await FirebaseFirestore.instance.collection("users").doc(myId).update({
        "friends": FieldValue.arrayUnion([friendId]),
      });
      await FirebaseFirestore.instance.collection("users").doc(friendId).update({
        "friends": FieldValue.arrayUnion([myId]),
      });
      EasyLoading.dismiss();
      print("==================$friendId");
      EasyLoading.showSuccess("Successfully Added to Your FriendList");
    } on FirebaseException catch (e) {
      EasyLoading.showError(e.message.toString());
      EasyLoading.dismiss();
    }
  }
}
