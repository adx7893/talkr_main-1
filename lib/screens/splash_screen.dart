import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:talkr_demo/pages/main_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AnimatedSplashScreen(
        splashIconSize: 101,
        splash: Image.asset('assets/images/logo3.png'),
        nextScreen: MainPage(),
        splashTransition: SplashTransition.rotationTransition,
        backgroundColor: Colors.black38,
        duration: 2000,
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
