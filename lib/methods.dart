import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:talkr_demo/chat/DatabaseManager.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<User?> createAccount(String name, String email, String password) async {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  try {
    User? user = (await auth.createUserWithEmailAndPassword(
            email: email, password: password))
        .user;

    if (user != null) {
      await DatabaseManager().createUserData(name, email, user.uid);
      print('Account Created Successfully');
      await _firestore.collection("users").doc(auth.currentUser?.uid).set({
        "name": name,
        "email": email,
      });
      return user;
    } else {
      print('Failed');
      return user;
    }
  } catch (e) {
    print(e);
    return null;
  }
}

Future<User?> logIn(String email, String password) async {
  FirebaseAuth auth = FirebaseAuth.instance;
  try {
    User? user = (await auth.signInWithEmailAndPassword(
            email: email, password: password))
        .user;
    if (user != null) {
      print("Login Successfull");
      return user;
    } else {
      print("Login Failed");
      return user;
    }
  } catch (e) {
    print(e);
    return null;
  }
}

Future logOut(BuildContext context) async {
  FirebaseAuth auth = FirebaseAuth.instance;
  try {
    await auth.signOut();
  } catch (e) {
    print("error");
  }
}

/*Future<List> fetchDetails() async{
  List userlist = [];
  DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance.collection('new users').doc('details').get();
  //userlist = documentSnapshot.data(['details']);
  return userlist;
}*/