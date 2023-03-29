import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:appdevprac/home_screen.dart';

class SocialMedia extends StatelessWidget {
  const SocialMedia({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        elevation: 1,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context)=>const HomeScreen()));
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.only(left: 16, top: 25, right: 16),
        child: ListView(
          children: [
            const Text(
              "Social Media",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 40,
            ),
            Row(
              children: const [
                Icon(
                  Icons.share_outlined,
                  color: Colors.green,
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  "Accounts",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const Divider(
              height: 15,
              thickness: 2,
            ),
            const SizedBox(
              height: 10,
            ),
            const ListTile(
              leading: Icon(
                Icons.facebook,
                color: Colors.lightBlue,
              ),
              title: Text('Facebook'),
              subtitle: Text('@japhetsteve716'),
            ),
            const ListTile(
              leading: Icon(
                Icons.camera_alt_rounded,
                color: Colors.deepOrange,
              ),
              title: Text('Instagram'),
              subtitle: Text('@jappytong'),
            ),
            const ListTile(
              leading: Icon(
                Icons.near_me,
                color: Colors.blue,
              ),
              title: Text('Twitter'),
              subtitle: Text('@imjaphetsteve'),
            ),
            const ListTile(
              leading: Icon(
                Icons.tiktok,
                color: Colors.black,
              ),
              title: Text('Tiktok'),
              subtitle: Text('@sterben.coffin'),
            ),
            const SizedBox(
              height: 40,
            ),
          ],
        ),
      ),
    );
  }
}


