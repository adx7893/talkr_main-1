// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:talkr_demo/chat/UserList.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return UserList(); /*Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Chat"),
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Chat",
              style: TextStyle(color: Colors.white, fontSize: 20),
            )
          ],
        ),
      ),
    );*/
  }
}
