import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

Future<String?> uploadFileToFirebase(File file) async {
  try {
    final storageRef = FirebaseStorage.instance
        .ref()
        .child('uploads/${DateTime.now().millisecondsSinceEpoch}.png');
    UploadTask uploadTask = storageRef.putFile(file);

    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  } catch (e) {
    print('Error uploading file: $e');
    return null;
  }
}
