// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:talkr_demo/pages/login_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserManagement {
  storeNewUser(user, context) async {
    var firebaseUser = FirebaseAuth.instance.currentUser;
    FirebaseFirestore.instance
        .collection('users')
        .doc(firebaseUser!.uid)
        .set({'email': user.email, 'uid': user.uid})
        .then((value) => Navigator.push(context,
            MaterialPageRoute(builder: (context) => const LoginPage())))
        .catchError((e) {
          print(e);
        });
  }
}
