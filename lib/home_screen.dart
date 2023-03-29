import 'package:appdevprac/profile_details.dart';
import 'package:appdevprac/signin_screen.dart';
import 'package:appdevprac/socmed.dart';
import 'package:appdevprac/userprofile.dart';
import 'package:appdevprac/utils/color_utils.dart';
import 'package:appdevprac/utils/constants.dart';
import 'package:appdevprac/widgets/profile_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  hexStringColor("#0081A7"),
                  hexStringColor("#FED9B7"),
                  hexStringColor("#F07167")
                ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 150,
                  child: const CircleAvatar(
                    radius: 90,
                    backgroundImage: ExactAssetImage('img/profpic.jpg'),
                  ),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Constants.primaryColor.withOpacity(.5),
                      width: 5.0,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: size.width * .45,
                  child: Row(
                    children: [
                      Text(
                        'Japhet Steve Ong',
                        style: TextStyle(
                          color: Constants.blackColor,
                          fontSize: 22,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: size.height * .1,
                  width: size.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        child: const ProfileWidget(
                          icon: Icons.person,
                          title: 'About me',
                        ),
                        onTap: () {
                          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context)=>const ProfileDetails()));
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: size.height * .1,
                  width: size.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        child: const ProfileWidget(
                          icon: Icons.share,
                          title: 'Social Media',
                        ),
                        onTap: () {
                          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context)=>const SocialMedia()));
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: size.height * .1,
                  width: size.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        child: const ProfileWidget(
                          icon: Icons.mode_edit_outline_outlined,
                          title: 'Edit Profile',
                        ),
                        onTap: () {
                          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context)=>const UserProfile()));
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: size.height * .1,
                  width: size.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        child: const ProfileWidget(
                          icon: Icons.logout,
                          title: 'Log Out',
                        ),
                        onTap: () {
                          FirebaseAuth.instance.signOut().then((value) {
                            print("Signed Out");
                            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context)=>const SignInScreen()));
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}

