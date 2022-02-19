import 'package:flutter/material.dart';
import 'package:talkr_demo/pages/register_page.dart';
import 'package:google_fonts/google_fonts.dart';

import 'login_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: 350,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/background.png'),
                      fit: BoxFit.fill)),
              child: Stack(children: <Widget>[
                Positioned(
                  left: 30,
                  width: 80,
                  height: 150,
                  child: Container(
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/images/light-1.png'))),
                  ),
                ),
                Positioned(
                  left: 140,
                  width: 80,
                  height: 100,
                  child: Container(
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/images/light-2.png'))),
                  ),
                ),
                Positioned(
                  right: 40,
                  top: 40,
                  width: 80,
                  height: 100,
                  child: Container(
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/images/clock.jpeg'))),
                  ),
                ),
              ]),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        bottom: 90.0), //do not change anything in this line
                    child: Center(
                      child: Text(
                        "Talkr",
                        style: GoogleFonts.montserrat(
                            color: Colors.deepPurpleAccent,
                            fontWeight: FontWeight.w200,
                            fontSize: 80,
                            fontStyle: FontStyle.normal),
                      ),
                    ),
                  ),
                  Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Colors.deepPurpleAccent,
                          onPrimary: Colors.black,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50))),
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const LoginPage(),
                          ),
                        );
                      },
                      child: const Text(
                        'Login',
                        style: TextStyle(fontSize: 20.0, color: Colors.white),
                      ),
                    ),
                  ),
                  Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Colors.deepPurpleAccent,
                          onPrimary: Colors.black,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50))),
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const RegisterPage(),
                          ),
                        );
                      },
                      child: const Text(
                        'Register',
                        style: TextStyle(fontSize: 20.0, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}



/**/