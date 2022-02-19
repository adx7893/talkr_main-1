// ignore_for_file: file_names, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseManager {
  final CollectionReference profileList =
      FirebaseFirestore.instance.collection('UserProfile');

  Future createUserData(String name, String email, String uid) async {
    return await profileList.doc(uid).set({
      'name': name,
      'email': email,
    });
  }

  Future getUsersList() async {
    List itemList = [];
    try {
      // ignore: avoid_types_as_parameter_names, non_constant_identifier_names
      await profileList.get().then((QuerySnapshot) {
        // ignore: avoid_function_literals_in_foreach_calls
        QuerySnapshot.docs.forEach((element) {
          itemList.add(element.data());
        });
      });
      return itemList;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
