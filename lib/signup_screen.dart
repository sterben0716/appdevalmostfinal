import 'package:appdevprac/home_screen.dart';
import 'package:appdevprac/utils/color_utils.dart';
import 'package:appdevprac/widgets/reusable_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _usernameTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text("Sign Up",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            hexStringColor("#0081A7"),
            hexStringColor("#FED9B7"),
            hexStringColor("#F07167")
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
        child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.fromLTRB(20,
                  MediaQuery.of(context).size.height *0.2, 20, 0),
              child: Column(
                children:<Widget>[
                  const SizedBox(
                    height: 20,
                  ),
                  reusableTexfield(
                      "Enter Username",
                      Icons.person_outline,
                      false,
                      _usernameTextController),
                  const SizedBox(
                    height: 20,
                  ),
                  reusableTexfield(
                      "Enter Email",
                      Icons.alternate_email_outlined,
                      false,
                      _emailTextController),
                  const SizedBox(
                    height: 20,
                  ),
                  reusableTexfield(
                      "Enter Password",
                      Icons.lock_outlined,
                      true,
                      _passwordTextController),
                  const SizedBox(
                    height: 20,
                  ),
                  signInSignUpButton(context, false, () {
                    FirebaseAuth.instance.createUserWithEmailAndPassword(
                        email: _emailTextController.text,
                        password: _passwordTextController.text)
                        .then((value){
                          print("Created new account");
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HomeScreen()));
                    }).onError((error, stackTrace) {
                      print("Error ${error.toString()}");
                    });
                  })
                ],
              ),
          )
        ),
      ),
    );

  }
}
