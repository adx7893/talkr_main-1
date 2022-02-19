/*import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:talkr_demo/models/user.dart';
import 'dart:async';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPage createState() => _SearchPage();
}

class _SearchPage extends State<SearchPage>
    with AutomaticKeepAliveClientMixin<SearchPage> {
  // ignore: prefer_typing_uninitialized_variables
  var userDocs;

  buildSearchField() {
    return AppBar(
      backgroundColor: Colors.white,
      title: Form(
        child: TextFormField(
          decoration: const InputDecoration(labelText: 'Search for a user...'),
          onFieldSubmitted: submit,
        ),
      ),
    );
  }

  ListView buildSearchResults(List<DocumentSnapshot> docs) {
    List<UserSearchItem> userSearchItems = [];

    for (var doc in docs) {
      User user = User.fromDocument(doc);
      UserSearchItem searchItem = UserSearchItem(user);
      userSearchItems.add(searchItem);
    }

    return ListView(
      children: userSearchItems,
    );
  }

  void submit(String searchValue) async {
    Future<QuerySnapshot> users = await Firestore.instance
        .collection('UserProfile')
        .where('name', arrayContains: 'abh')
        .getDocuments();

    setState(() {
      userDocs = users;
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); // reloads state when opened again

    return Scaffold(
      appBar: buildSearchField(),
      // ignore: unnecessary_null_comparison
      body: userDocs == null
          ? const Text("")
          : FutureBuilder<QuerySnapshot>(
              future: userDocs,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return buildSearchResults(snapshot.data!.docs);
                } else {
                  return Container(
                      alignment: FractionalOffset.center,
                      child: const CircularProgressIndicator());
                }
              }),
    );
  }

  // ensures state is kept when switching pages
  @override
  bool get wantKeepAlive => true;
}

class Firestore {
  // ignore: prefer_typing_uninitialized_variables
  static var instance;
}

class UserSearchItem extends StatelessWidget {
  final User user;

  // ignore: use_key_in_widget_constructors
  const UserSearchItem(this.user);

  @override
  Widget build(BuildContext context) {
    TextStyle boldStyle = const TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
    );

    return GestureDetector(
      child: ListTile(
        leading: const CircleAvatar(
          backgroundColor: Colors.grey,
        ),
        title: Text(user.username, style: boldStyle),
        subtitle: Text(user.username),
      ),
    );
  }

  void openProfile(BuildContext context, id) {}
}*/ //currentcode

import 'package:talkr_demo/methods.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:talkr_demo/screens/chat_screen.dart';

import 'chat_room.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> with WidgetsBindingObserver {
  Map<String, dynamic>? userMap;
  bool isLoading = false;
  final TextEditingController _search = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
    setStatus("Online");
  }

  void setStatus(String status) async {
    await _firestore
        .collection('UserProfile')
        .doc(_auth.currentUser!.uid)
        .update({
      "status": status,
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      // online
      setStatus("Online");
    } else {
      // offline
      setStatus("Offline");
    }
  }

  String chatRoomId(String user1, String user2) {
    if (user1[0].toLowerCase().codeUnits[0] >
        user2.toLowerCase().codeUnits[0]) {
      return "$user1$user2";
    } else {
      return "$user2$user1";
    }
  }

  void onSearch() async {
    FirebaseFirestore _firestore = FirebaseFirestore.instance;

    setState(() {
      isLoading = true;
    });

    await _firestore
        .collection('UserProfile')
        .where("name", isEqualTo: _search.text)
        .get()
        .then((value) {
      setState(() {
        userMap = value.docs[0].data();
        isLoading = false;
      });
      print(userMap);
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text("Home Screen"),
        actions: [
          IconButton(icon: Icon(Icons.logout), onPressed: () => logOut(context))
        ],
      ),
      body: isLoading
          ? Center(
              child: Container(
                height: size.height / 20,
                width: size.height / 20,
                child: CircularProgressIndicator(),
              ),
            )
          : Column(
              children: [
                SizedBox(
                  height: size.height / 20,
                ),
                Container(
                  height: size.height / 14,
                  width: size.width,
                  alignment: Alignment.center,
                  child: Container(
                    height: size.height / 14,
                    width: size.width / 1.15,
                    child: TextField(
                      controller: _search,
                      decoration: InputDecoration(
                        hintText: "Search",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height / 50,
                ),
                ElevatedButton(
                  onPressed: onSearch,
                  child: Text("Search"),
                ),
                SizedBox(
                  height: size.height / 30,
                ),
                userMap != null
                    ? ListTile(
                        onTap: () {
                          String roomId = chatRoomId(
                              _auth.currentUser!.displayName!,
                              userMap!['name']);

                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => ChatRoom(
                                chatRoomId: roomId,
                                userMap: userMap!,
                              ),
                            ),
                          );
                        },
                        leading: Icon(Icons.account_box, color: Colors.black),
                        title: Text(
                          userMap!['name'],
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        subtitle: Text(userMap!['email']),
                        trailing: Icon(Icons.chat, color: Colors.black),
                      )
                    : Container(),
              ],
            ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.group),
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => ChatScreen(),
          ),
        ),
      ),
    );
  }
}
