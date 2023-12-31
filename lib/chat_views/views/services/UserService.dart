import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:path/path.dart';

import '../../../utils/globals.dart';
import '../models/UserModel.dart';
import 'BaseService.dart';

class UserService extends BaseService {
  FirebaseFirestore fireStore = FirebaseFirestore.instance;
  FirebaseStorage _storage = FirebaseStorage.instance;

  UserService() {
    ref = fireStore.collection(USER_COLLECTION);
  }

  Future<void> updateUserInfo(Map data, String id, {File? profileImage}) async {
    if (profileImage != null) {
      String fileName = basename(profileImage.path);
      Reference storageRef = _storage.ref().child("$USER_PROFILE_IMAGE/$fileName");
      UploadTask uploadTask = storageRef.putFile(profileImage);
      await uploadTask.then((e) async {
        await e.ref.getDownloadURL().then((value) {
//          loginStore.setPhotoUrl(aPhotoUrl: value);
          data.putIfAbsent("photoUrl", () => value);
        });
      });
    }

    return ref!.doc(id).update(data as Map<String, Object?>);
  }

  Future<void> updateUserStatus(Map data, String id) async {
    return ref!.doc(id).update(data as Map<String, Object?>);
  }

  Future<UserModel> getUser({String? email}) {
    return ref!.where("email", isEqualTo: email).limit(1).get().then((value) {
      if (value.docs.length == 1) {
        return UserModel.fromJson(value.docs.first.data() as Map<String, dynamic>);
      } else {
        throw 'User Not found';
      }
    });
  }

  Future<UserModel> getUserById({String? val}) {
    return ref!.where("uid", isEqualTo: val).limit(1).get().then((value) {
      if (value.docs.length == 1) {
        return UserModel.fromJson(value.docs.first.data() as Map<String, dynamic>);
      } else {
        throw 'User Not found';
      }
    });
  }

  Stream<List<UserModel>> users({String? searchText}) {
    print(searchText.validate());
    return ref!.where('name', isEqualTo: searchText.validate().isEmpty ? null : searchText!).snapshots().map((x) {
      print("x:${x.docs}");
      return x.docs.map((y) {
        print(y);
        return UserModel.fromJson(y.data() as Map<String, dynamic>);
      }).toList();
    });
  }

  Future<UserModel> userByEmail(String? email) async {
    return await ref!.where('email', isEqualTo: email).limit(1).get().then((value) {
      if (value.docs.isNotEmpty) {
        return UserModel.fromJson(value.docs.first.data() as Map<String, dynamic>);
      } else {
        throw 'No User Found';
      }
    });
  }

  Stream<UserModel> singleUser(String? id, {String? searchText}) {
    return ref!.where('uid', isEqualTo: id).limit(1).snapshots().map((event) {
      return UserModel.fromJson(event.docs.first.data() as Map<String, dynamic>);
    });
  }

  Future<UserModel> userByMobileNumber(String? phone) async {
    return await ref!.where('phoneNumber', isEqualTo: phone).limit(1).get().then((value) {
      if (value.docs.isNotEmpty) {
        return UserModel.fromJson(value.docs.first.data() as Map<String, dynamic>);
      } else {
        throw 'EXCEPTION_NO_USER_FOUND';
      }
    });
  }

  Future<String> blockUser(Map<String, dynamic> data) async {
    return await ref!.doc(userID).update(data).then((value) {
      return "User Blocked";
    }).catchError((e) {
      toast(e.toString());
      throw errorSomethingWentWrong;
    });
  }

  Future<String> unBlockUser(Map<String, dynamic> data) async {
    return await ref!.doc(userID).update(data).then((value) {
      return "User Blocked";
    }).catchError((e) {
      toast(e.toString());
      throw errorSomethingWentWrong;
    });
  }

  Future<String> reportUser(Map<String, dynamic> data, String reportUserId) async {
    return await ref!.doc(reportUserId).update(data).then((value) {
      return "Account Reported to Talkmia";
    }).catchError((e) {
      toast(e.toString());
      throw errorSomethingWentWrong;
    });
  }

  DocumentReference getUserReference({required String uid}) {
    return userService.ref!.doc(uid);
  }

  Future<void> removeDocument(String? id) => userService.ref!.doc(id).delete();
}
