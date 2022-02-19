import 'DatabaseManager.dart';
import 'package:flutter/material.dart';

class UserList extends StatefulWidget {
  @override
  State<UserList> createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  List userProfileList = [];

  @override
  void initState() {
    super.initState();
    fetchDatabaseList();
  }

  fetchDatabaseList() async {
    dynamic result = await DatabaseManager().getUsersList();

    if (result != null) {
      setState(() {
        userProfileList = result;
      });
    } else {
      print('Unable to Retrieve');
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        title: Text(
          "TALKER",
          style: TextStyle(fontSize: 20),
        ),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        color: Colors.white,
        child: ListView.builder(
            itemCount: userProfileList.length,
            itemBuilder: (context, index) {
              return Stack(
                children: [
                  Card(
                    child: ListTile(
                      title: Text('${userProfileList[index]['name']}'),
                      subtitle: Text('${userProfileList[index]['email']}'),
                      leading: CircleAvatar(
                        child: Image(
                          image: AssetImage("assets/images/clock.jpeg"),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }),
      ),
    );
  }
}
