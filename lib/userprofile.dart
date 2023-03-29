import 'dart:io';
import 'package:path/path.dart' as Path;
import 'package:appdevprac/home_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';


class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  TextEditingController emailController = TextEditingController();
  TextEditingController usernameController = TextEditingController();

  final ImagePicker _picker = ImagePicker();
  File? selectedImage;

  getImage(ImageSource source)async{
    final XFile? image = await _picker.pickImage(source: source);
    if(image!=null){
      selectedImage = File(image.path);
      setState(() {

      });
    }
  }

  uploadImage(File image)async{

    String imageUrl = '';
    String fileName = Path.basename(image.path);
    var reference = FirebaseStorage.instance
    .ref()
    .child('users/$fileName');
    UploadTask uploadTask = reference.putFile(image);
    TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
    await taskSnapshot.ref.getDownloadURL().then(
          (value) {
      imageUrl = value;
      print("Download URL: $value");
    },
    );
    return imageUrl;
  }
  
  storeUserInfo()async{
    String url = await uploadImage(selectedImage!);
    String uid = FirebaseAuth.instance.currentUser!.uid;
    FirebaseFirestore.instance.collection('users').doc(uid).set({
      'image': url,
      'name': usernameController.text,
      'email': emailController.text
    }).then((value) {
      usernameController.clear();
      emailController.clear();
      setState(() {
        isLoading = false;
      });
      Get.to(() => HomeScreen());
    });
  }

  bool isLoading = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Profile"),
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
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: Get.height * 0.4,

              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: InkWell(
                      onTap: (){
                        getImage(ImageSource.camera);
                      },
                      child: selectedImage == null? Container(
                        width: 120,
                        height: 120,
                        margin: EdgeInsets.only(bottom: 20),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.greenAccent
                        ),
                        child: Center(child: Icon(Icons.camera_alt_outlined,size: 40,color: Colors.blueGrey,),),
                      ):
                      Container(
                        width: 120,
                        height: 120,
                        margin: EdgeInsets.only(bottom: 20),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: FileImage(selectedImage!)
                          ),
                            shape: BoxShape.circle,
                            color: Colors.greenAccent
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 23),
              child: Column(
                children: [
                  TextFieldWidget('Email', Icons.alternate_email_outlined, emailController),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFieldWidget('Username', Icons.person_outlined, usernameController),
                  const SizedBox(
                    height: 10,
                  ),
                  isLoading?Center(child: CircularProgressIndicator(),) :editButton('Submit', (){
                    setState(() {
                      isLoading = true;
                    });
                    storeUserInfo();
                  }),
                ],
              ),
            )
          ],
        ),
      ),
    );

  }
}

TextFieldWidget(String title,IconData iconData,TextEditingController controller){
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(title, style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w600,color: Colors.black26),),
      const SizedBox(
        height: 6,
      ),
      Container(
        width: Get.width,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              spreadRadius: 1,
              blurRadius: 1
            )
          ],
          borderRadius: BorderRadius.circular(8)
        ),
        child: TextField(
          controller: controller,
          style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w600,color: Colors.black26),
          decoration: InputDecoration(

            prefixIcon: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Icon(iconData,color: Colors.greenAccent,),
            ),
          ),
        ),
      )
    ],
  );
}

Widget editButton(String title,Function onPressed){
  return MaterialButton(
    minWidth: Get.width,
    height: 50,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(5)
    ),
    color: Colors.greenAccent,
    onPressed: ()=>onPressed(),
    child: Text(title,style: GoogleFonts.poppins(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.black26),),
  );
}
