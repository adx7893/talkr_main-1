// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:talkr_demo/pages/login_page.dart';
import 'package:talkr_demo/screens/edit_profile.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late String myEmail;
  late String name;
  bool _isSigningOut = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
        title: const Text('Profile'),
        actions: [
          _isSigningOut
              ? const CircularProgressIndicator()
              : FlatButton.icon(
                  onPressed: () async {
                    setState(() {
                      _isSigningOut = true;
                    });

                    await FirebaseAuth.instance.signOut();
                    setState(() {
                      _isSigningOut = false;
                    });
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => const LoginPage(),
                      ),
                    );
                  },
                  icon: const Icon(
                    Icons.person,
                    color: Colors.deepPurpleAccent,
                  ),
                  label: const Text(
                    'Sign out',
                    style: TextStyle(color: Colors.deepPurpleAccent),
                  ),
                ),
        ],
      ),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Text(
            "Signed In User: ",
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            user.email!,
            style: const TextStyle(fontSize: 20, color: Colors.white),
          ),
          const SizedBox(
            height: 40,
          ),
          Container(
            color: Colors.teal,
            child: MaterialButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditProfile(),
                    ));
              },
              child: Text("Edit Profile"),
            ),
          ),
        ]),
      ),
    );
  }
}
