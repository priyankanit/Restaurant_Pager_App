import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:restuarant_pager_app/models/PhoneNumberModel/PhoneNumber.model.dart';
import 'package:restuarant_pager_app/models/ResponseModel/ResponseModel.dart';
import 'package:restuarant_pager_app/models/UserModel/UserModel.dart';
import 'package:restuarant_pager_app/utils/imagePicker.dart';
import 'package:dio/dio.dart' as dio;

void main(){
  runApp(const Test());
}

class Test extends StatelessWidget {
  const Test({super.key});

    Future<ResponseModel> createAccount(UserModel user,File? profilePic) async {
    final dio.Dio _dio = dio.Dio();
    String res = "some error occurred";
    try {
      // await _firestore.collection("users").doc(user.uid).set(user.toMap());
      // // for fast check
      // await _firestore
      //     .collection("phone_numbers")
      //     .doc(user.phone!.getE164FormattedPhoneNumber())
      //     .set({"uid": user.uid});
      // res = "success";

      dio.FormData formData = dio.FormData.fromMap({
        'uid': user.uid,
        'username': user.name,
        'email': user.email,
        'phone_number': user.phone?.getE164FormattedPhoneNumber(),
        'profile_image': profilePic != null
            ? await dio.MultipartFile.fromFile(
                profilePic.path,
                filename: profilePic.path.split('/').last,
              )
            : null,
        'gender': user.gender,
        'date_of_birth': user.dateOfBirth,
        'is_active': user.whatsAppMessagePreference
      });
      debugPrint(formData.fields.toString());

      final response = await _dio.post(
        "http://10.0.2.2:8000/user/",
        data: formData,
      );

      if(response.statusCode == 200){
        res = "success";
      }else{
        res = response.statusMessage ?? res;
      }
    } 
    catch (error) {
      res = error.toString();
    }

    return ResponseModel(message: res);
  }

  void handleClick() async {
    final userData = UserModel(
    dateOfBirth: "2024-09-20",
    email: "djdas000000@outlook.com",
    gender: "Male",
    whatsAppMessagePreference: true,
    phone: PhoneNumberModel(countryCode: "+91",phoneNumber: "9898989898"),
    uid: "1b4db7eb-4057-5ddf-91e0-36dec72071f5",
    name: "user"
    );
    
    final file = await pickImage(ImageSource.gallery);
    final res = await createAccount(userData, file);

    debugPrint("print error : ${res.message}" );
    
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: ElevatedButton(onPressed: handleClick, child: const Text("send request")),
        ),
      ),
    );
  }
}