import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../validator.dart';
import 'google_sign_in.dart';
import '../screens/main_screen.dart';
import 'package:talkr_demo/methods.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController displayName = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Register",
        ),
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: isLoading
          ? Center(
              child: Container(
                height: size.height / 20,
                width: size.height / 20,
                child: CircularProgressIndicator(),
              ),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
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
                                  image:
                                      AssetImage('assets/images/light-1.png'))),
                        ),
                      ),
                      Positioned(
                        left: 140,
                        width: 80,
                        height: 100,
                        child: Container(
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image:
                                      AssetImage('assets/images/light-2.png'))),
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
                                  image:
                                      AssetImage('assets/images/clock.jpeg'))),
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
                              bottom:
                                  50.0), //do not change anything in this line
                          child: Center(
                            child: Text(
                              "Register",
                              style: GoogleFonts.montserrat(
                                  color: Colors.deepPurpleAccent,
                                  fontWeight: FontWeight.w300,
                                  fontSize: 50,
                                  fontStyle: FontStyle.normal),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                          child: Container(
                            width: size.width,
                            alignment: Alignment.center,
                            child: field(
                                size, "Name", Icons.account_box, displayName),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                          child: Container(
                            width: size.width,
                            alignment: Alignment.center,
                            child: Center(
                              child:
                                  field(size, "Email", Icons.password, _email),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                          child: Container(
                            width: size.width,
                            alignment: Alignment.center,
                            child:
                                field(size, "Password", Icons.lock, _password),
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        customButton(size),
                        // const SizedBox(width: 12.0),
                        Center(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: Colors.deepPurpleAccent,
                                onPrimary: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50))),
                            child: const Text(
                              'Google',
                              style: TextStyle(fontSize: 20),
                            ),
                            onPressed: () {
                              final provider =
                                  Provider.of<GoogleSignInProvider>(context,
                                      listen: false);
                              provider.googleLogin();
                            },
                          ),
                        )
                        // Padding(
                        //   padding: const EdgeInsets.all(8.0),
                        //   child: GestureDetector(
                        //     onTap: () => Navigator.pop(context),
                        //     child: const Text(
                        //       "Login",
                        //       style: TextStyle(
                        //         color: Colors.blue,
                        //         fontSize: 16,
                        //         fontWeight: FontWeight.w500,
                        //       ),
                        //     ),
                        //   ),
                        // )
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget customButton(Size size) {
    return GestureDetector(
      onTap: () async {
        if (displayName.text.isNotEmpty &&
            _email.text.isNotEmpty &&
            _password.text.isNotEmpty) {
          setState(() {
            isLoading = true;
          });

          createAccount(displayName.text, _email.text, _password.text)
              .then((user) {
            if (user != null) {
              setState(() {
                isLoading = false;
              });
              Navigator.push<void>(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => MainScreen(
                    user: user,
                  ),
                ),
              );
              print("Account Created Sucessfull");
            } else {
              print("Login Failed");
              setState(() {
                isLoading = false;
              });
            }
          });
        } else {
          print("Please enter Fields");
        }
      },
      child: Container(
          height: size.height / 20,
          width: size.width / 1.2,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: Colors.deepPurpleAccent,
          ),
          alignment: Alignment.center,
          child: Text(
            "Create Account",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          )),
    );
  }

  Widget field(
      Size size, String hintText, IconData icon, TextEditingController cont) {
    return Container(
      height: size.height / 15,
      width: size.width / 1,
      child: TextField(
        controller: cont,
        decoration: InputDecoration(
          prefixIcon: Icon(icon),
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey),
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.transparent, width: 1.5),
            borderRadius: BorderRadius.circular(50),
          ),
        ),
      ),
    );
  }
}
