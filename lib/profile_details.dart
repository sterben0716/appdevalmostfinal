import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:appdevprac/home_screen.dart';

class ProfileDetails extends StatelessWidget {
  const ProfileDetails({Key? key}) : super(key: key);



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
              "About me",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 40,
            ),
            Row(
              children: const [
                Icon(
                  Icons.person,
                  color: Colors.green,
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  "Info",
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
              leading: Icon(Icons.drive_file_rename_outline,
              color: Colors.green,),
              title: Text('Name:'),
              subtitle: Text('Japhet Steve Gayosa Ong'),
            ),
            const ListTile(
              leading: Icon(Icons.email_outlined,
              color: Colors.green,),
              title: Text('Email:'),
              subtitle: Text('japhetsteve0716@gmail.com'),
            ),
            const ListTile(
              leading: Icon(Icons.favorite_outlined,
              color: Colors.green,),
              title: Text('Age:'),
              subtitle: Text('21'),
            ),
            const ListTile(
              leading: Icon(Icons.account_circle_outlined,
              color: Colors.green,),
              title: Text('Gender:'),
              subtitle: Text('Male'),
            ),
            const ListTile(
              leading: Icon(Icons.home,
              color: Colors.green,),
              title: Text('Address:'),
              subtitle: Text('Manolo Fortich, Bukidnon'),
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


