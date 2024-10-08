import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:restuarant_pager_app/models/ResponseModel/ResponseModel.dart';
import 'package:firebase_auth/firebase_auth.dart'; 

class StorageMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  // adding profile pic of user to firebase storage
  Future<ResponseModel> uploadProfilePic({required File file}) async {
    String res = "some error occured";
    String? downloadUrl;
    try {
      // creating location to our firebase storage
      Reference ref = _storage.ref().child("profile_pics").child(_auth.currentUser!.uid);  

      // putting in `File` format -> Upload task like a future but not future
      UploadTask uploadTask = ref.putFile(file);

      TaskSnapshot snapshot = await uploadTask;
      downloadUrl = await snapshot.ref.getDownloadURL();
      res = "success";
    }catch(error){
      res = error.toString();
    }
    return ResponseModel(message: res,data: downloadUrl);
  }
}