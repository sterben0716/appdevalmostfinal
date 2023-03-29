import 'dart:io';
import 'package:appdevprac/home_screen.dart';
import 'package:appdevprac/userprofile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:path/path.dart' as Path;


class AuthController extends GetxController {
  String userUid = '';
  var varId= '';
  int? resendTokenId;
  bool phoneAuthCheck = false;
  dynamic credentials;

  var isDecided = false;

  decideRoute(){

    if(isDecided){
      return;
    }
    isDecided = true;
    print("called");

    User? user = FirebaseAuth.instance.currentUser;

    if(user != null){
      FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get()
          .then((value) {
        if(value.exists){
          Get.to(() =>HomeScreen());
        }else{
          Get.to(()=> UserProfile());
        }
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



}



