import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class DatabaseMethods {
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

//Add Google
  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

//OTP Number Add
  Future<String> emailGoogle() async {
    String res = 'Some error occured';
    try {
      //Add User to the database with modal

      await firebaseFirestore
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set(
        {
          "email": FirebaseAuth.instance.currentUser!.email,
          "uid": FirebaseAuth.instance.currentUser!.uid
        },
      );
      res = 'success';
      debugPrint(res);
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  Future<String> phone() async {
    String res = 'Some error occured';
    try {
      //Add User to the database with modal

      await firebaseFirestore
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set(
        {
          "phone": FirebaseAuth.instance.currentUser!.phoneNumber.toString(),
          "uid": FirebaseAuth.instance.currentUser!.uid
        },
      );
      res = 'success';
      debugPrint(res);
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  //Profile Details
  // Future<String> profileDetail({
  //   required String email,
  //   required String uid,
  //   required String name,
  //   required String address,
  //   required String gender,
  //   required bool blocked,
  //   required String dob,
  //   required String phoneNumber,
  //   required Uint8List file,
  // }) async {
  //   String res = 'Some error occured';

  //   try {
  //     if (email.isNotEmpty || name.isNotEmpty) {
  //       String photoURL = await StorageMethods()
  //           .uploadImageToStorage('ProfilePics', file, false);
  //       //Add User to the database with modal

  //       ProfileModel userModel = ProfileModel(
  //         likes: [],
  //         blocked: blocked,
  //         dob: dob,
  //         gender: gender,
  //         name: name,
  //         address: address,
  //         uid: FirebaseAuth.instance.currentUser!.uid,
  //         email: FirebaseAuth.instance.currentUser!.email ?? email,
  //         phoneNumber: phoneNumber,
  //         photoURL: photoURL,
  //       );
  //       await firebaseFirestore
  //           .collection('users')
  //           .doc(uid)
  //           .update(userModel.toJson());

  //       res = 'success';
  //     }
  //   } catch (e) {
  //     res = e.toString();
  //   }
  //   return res;
  // }

//Like Doctor
  Future<void> likePosts(String uid, List likes) async {
    try {
      if (likes.contains(uid)) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .update({
          "likes": FieldValue.arrayRemove([uid])
        });
      } else {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .update({
          "likes": FieldValue.arrayUnion([uid])
        });
      }
    } catch (E) {
      print(E.toString());
    }
  }
}
