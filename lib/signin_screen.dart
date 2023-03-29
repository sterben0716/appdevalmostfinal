import 'package:appdevprac/home_screen.dart';
import 'package:appdevprac/signup_screen.dart';
import 'package:appdevprac/utils/color_utils.dart';
import 'package:appdevprac/widgets/reusable_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _passwordTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient:LinearGradient(colors: [
            hexStringColor("#0081A7"),
            hexStringColor("#FED9B7"),
            hexStringColor("#F07167")
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(20, MediaQuery.of(context).size.height *0.2, 20, 0),
            child: Column(
              children: <Widget>[
                logoWidget("img/welcome.png"),
                SizedBox(
                  height: 30,
                ),
                reusableTexfield(
                    "Enter Username",
                    Icons.person_outline,
                    false,
                    _emailTextController),
                SizedBox(
                  height: 20,
                ),
                reusableTexfield(
                    "Enter Password",
                    Icons.lock_outline,
                    true,
                    _passwordTextController),
                SizedBox(
                  height: 20,
                ),
                signInSignUpButton(context, true, () {
                  FirebaseAuth.instance.signInWithEmailAndPassword(
                      email: _emailTextController.text,
                      password: _passwordTextController.text).then((value) {
                    Navigator.push(context, MaterialPageRoute(builder: (context) =>HomeScreen()));
                  }).onError((error, stackTrace) {
                    print("Error ${error.toString()}");
                  });
                }),
                signUpOption()
              ],
            ),
          ),
        ),
      )
    );
  }

  Row signUpOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Dont have an account?",
            style: TextStyle(color: Colors.white70)),
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => SignUpScreen()));
          },
          child: const Text(
            "Sign Up",
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold),
          ),
        ),
        Padding(padding: EdgeInsetsDirectional.only(bottom: 100))
      ],
    );
  }
}

