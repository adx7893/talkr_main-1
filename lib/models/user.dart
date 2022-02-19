import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String username;
  final String email;

  User({
    required this.username,
    required this.email,
  });

  factory User.fromDocument(DocumentSnapshot doc) {
    return User(
      email: doc['email'],
      username: doc['username'],
    );
  }
}
