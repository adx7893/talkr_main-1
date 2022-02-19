import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:talkr_demo/screens/like_screen.dart';
import 'package:talkr_demo/screens/post_screen.dart';
import 'package:talkr_demo/screens/feed_screen.dart';
import 'package:talkr_demo/screens/search_screen.dart';
import 'profile_screen.dart';

class MainScreen extends StatefulWidget {
  final User user;

  const MainScreen({Key? key, required this.user}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  //bool _isSigningOut = true;
  final navigationKey = GlobalKey<CurvedNavigationBarState>();
  int index = 2;
  final screens = [
    const FeedScreen(),
    SearchPage(),
    PostScreen(),
    const LikeScreen(),
    const ProfileScreen()
  ];

  @override
  void initState() {
    super.initState();
  }

  late String myEmail;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[index],
      bottomNavigationBar: Theme(
        data: Theme.of(context)
            .copyWith(iconTheme: const IconThemeData(color: Colors.black)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            CurvedNavigationBar(
              key: navigationKey,
              index: index,
              buttonBackgroundColor: Colors.white,
              backgroundColor: Colors.black,
              animationDuration: const Duration(milliseconds: 300),
              animationCurve: Curves.easeOut,
              items: const <Widget>[
                Icon(Icons.home_filled, color: Colors.deepPurpleAccent),
                Icon(
                  Icons.search_rounded,
                  color: Colors.deepPurpleAccent,
                ),
                Icon(
                  Icons.add_a_photo_rounded,
                  color: Colors.deepPurpleAccent,
                ),
                Icon(
                  Icons.favorite_border_rounded,
                  color: Colors.deepPurpleAccent,
                ),
                Icon(
                  Icons.person,
                  color: Colors.deepPurpleAccent,
                ),
              ],
              onTap: (index) => setState(() => this.index = index),
            ),
          ],
        ),
      ),
    );
  }
}

/*class _ProfilePageState extends State<ProfilePage> {
  bool _isSigningOut = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Welcome to your profile"),
            SizedBox(height: 500.0),
            _isSigningOut
                ? CircularProgressIndicator()
                : ElevatedButton(
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
                          builder: (context) => LoginPage(),
                        ),
                      );
                    },
                    child: Text('Sign out'),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}*/
