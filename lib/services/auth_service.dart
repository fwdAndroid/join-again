import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthServices {
  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;

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

      await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).set(
        {"email": FirebaseAuth.instance.currentUser!.email, "uid": FirebaseAuth.instance.currentUser!.uid},
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

      await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).set(
        {"phone": FirebaseAuth.instance.currentUser!.phoneNumber.toString(), "uid": FirebaseAuth.instance.currentUser!.uid},
      );
      res = 'success';
      debugPrint(res);
    } catch (e) {
      res = e.toString();
    }
    return res;
  }
}
