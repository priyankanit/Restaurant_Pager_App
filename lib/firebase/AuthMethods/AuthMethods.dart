import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:restuarant_pager_app/controllers/OTPController/OTPContoller.dart';
import 'package:restuarant_pager_app/controllers/UserController/UserController.dart';
import 'package:restuarant_pager_app/models/ResponseModel/ResponseModel.dart';
import 'package:restuarant_pager_app/models/UserModel/UserModel.dart';
import 'package:restuarant_pager_app/utils/toastMessage.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final UserController userController = Get.put(UserController());

  Stream<User?> get authChanges => _auth.authStateChanges();
  User? get user => _auth.currentUser;

  Future<ResponseModel> signInWithGoogle() async {
    String res = "some error occurred";
    User? user;
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn(scopes: [
        "email",// only request email
      ]).signIn();

      // Check if the user canceled the sign-in
      if (googleUser == null) {
        return ResponseModel(message: "Sign-in aborted by user", data: null);
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential userCredential = await _auth.signInWithCredential(credential);
      user = userCredential.user;

      if (user != null) {
        res = "success";
      }
    } on FirebaseAuthException catch (error) {
      res = error.message ?? error.toString();
    }
    return ResponseModel(message: res,data:user);
  }

Future<ResponseModel> signInUsingPhoneNumber()async{
  final otpController = Get.find<OTPController>();
  String res = "some error occurred";
  User? user;
  try {
    String verificationId = otpController.verificationId!;
    final credential = PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: otpController.otp ?? "",
    );
    final userCredential = await _auth.signInWithCredential(credential);
    user = userCredential.user;
    res = "success";
  } catch (error) {
    if (error is FirebaseAuthException) {
      res = error.message ?? "Verification failed. Please try again.";
    } else {
      res = "An unexpected error occurred: $error";
    }
  }
  return ResponseModel(message: res,data: user);
}

void sentOTPtoPhone(String e164phoneNumber,int? resendToken, BuildContext context) async {
  final otpController = Get.find<OTPController>();
  try {
    await _auth.verifyPhoneNumber(
      phoneNumber: e164phoneNumber,
      timeout: const Duration(seconds: 60),
      verificationCompleted: (PhoneAuthCredential credential) async {
        otpController.pinputController.text = credential.smsCode ?? "";
      },
      verificationFailed: (FirebaseAuthException e) {
        if (e.code == 'invalid-phone-number') {
          showToastMessage(context, "Invalid phone number. Please check and try again.");
        } else if (e.code == 'too-many-requests') {
          showToastMessage(context, "Too many requests. Please try again later.");
        } else if (e.code == 'network-request-failed') {
          showToastMessage(context, "Network error. Please check your connection and try again.");
        } else if (e.code == 'quota-exceeded') {
          showToastMessage(context, "SMS quota exceeded for this project. Try again later.");
        } else if (e.code == 'app-not-authorized') {
          showToastMessage(context, "App is not authorized to use Firebase Authentication.");
        } else if (e.code == 'invalid-verification-code') {
          showToastMessage(context, "Invalid verification code.");
        } else {
          showToastMessage(context, e.message ?? "An unknown error occurred.");
        }
      },
      codeSent: (String verificationId, int? resendToken) {
        otpController.verificationId = verificationId;
        otpController.resendToken = resendToken;
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        // You can add additional logic here if needed
      },
      forceResendingToken: resendToken, // resend otp 
    );
  } catch (error) {
    if(context.mounted){
      showToastMessage(context, "An unexpected error occurred: $error");
    }
  }
}


    Future<ResponseModel> getUserData()async{
    String res = "some error occurred";
    try{
      // String? uid = await _localStorage.getUid();
      String? uid = user?.uid;
      if(uid != null){
        final res2 = await getUserWithUid(uid: uid);
        if(res2.message == "success"){
          UserModel userData = res2.data;
          userController.setUser(userData);
          res = "success";
        }else{
          res = res2.message!;
        }
      }else{
        res = "user not found";
      }
    }catch(error){
      res = error.toString();
    }
    return ResponseModel(message: res);
  }

  // firestore temporary methods

  Future<ResponseModel> createAccount(UserModel user)async{
    String res = "some error occurred";
    try{
      await _firestore.collection("users").doc(user.uid).set(user.toMap());
      // for fast check 
      await _firestore.collection("phone_numbers").doc(user.phone!.getE164FormattedPhoneNumber()).set({
        "uid" : user.uid
      });
      res = "success";
    }catch(error){
      res = error.toString();
    }

    return ResponseModel(message: res);
  }

  Future<ResponseModel> getUserWithUid({required String uid}) async {
    String res = "some error occurred";
    UserModel? user;
    try{
      final snapshot = await _firestore.collection("users").doc(uid).get();
      final data = snapshot.data();
      if(snapshot.exists && data != null){
        user = UserModel.fromMap(data);
        res = "success";
      }else{
        res = "user not found";
      }
    }catch(error){
      res = error.toString();
    }
    return ResponseModel(message: res,data: user);
  }

  Future<ResponseModel> getUserWithPhoneNumber({required String e164phoneNumber})async{
    String res = "some error occurred";
    UserModel? user;
    try{
      final snapshot = await _firestore.collection("phone_numbers").doc(e164phoneNumber).get();
      final data = snapshot.data();
      if(snapshot.exists && data != null){
        final response = await getUserWithUid(uid: data["uid"]);
        if(response.message == "success"){
          user = response.data;
          res = "success";
        }else{
          res = response.message!;
        }
      }else{
        res = "user not found";
      }
    }catch(error){
      res = error.toString();
    }
    return ResponseModel(message: res,data : user);
  }

  Future<ResponseModel> updateUser(UserModel newData) async {
    String res = "some error occurred";
    try{
      await _firestore.collection("users").doc(newData.uid).update(newData.toMap());
      res = "success";
    }catch(error){
      res = error.toString();
    }
    return ResponseModel(message: res);
  }

  Future<ResponseModel> signOut() async {
    String res = "some error occurred";
    try {
      _auth.signOut();
      userController.clearUserData();
      res = "success";
    } catch (error) {
      res = error.toString();
    }
    return ResponseModel(message: res);
  }
}