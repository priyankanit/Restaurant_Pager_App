import 'package:dio/dio.dart' as dio;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:restuarant_pager_app/controllers/OTPController/OTPContoller.dart';
import 'package:restuarant_pager_app/controllers/UserController/UserController.dart';
import 'package:restuarant_pager_app/models/ResponseModel/ResponseModel.dart';
import 'package:restuarant_pager_app/models/UserModel/UserModel.dart';
import 'package:restuarant_pager_app/utils/toastMessage.dart';
import 'package:restuarant_pager_app/views/LinkAccountPage/components/AccountCard.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final UserController userController = Get.put(UserController(),permanent: true);
  final dio.Dio _dio = dio.Dio();
  bool loggedIn = false;

  Stream<User?> get authChanges => _auth.authStateChanges();
  User? get user => _auth.currentUser;

  // http://10.0.2.2:8000 for emulation
  // replace with your machine ip address to test on real device
  Map<String, String> routes = {
    "create_user": "http://10.0.2.2:8000/user/",
    "get_user": "http://10.0.2.2:8000/user_check/",
    "email_otp": "http://10.0.2.2:8000/otp/",
    "update_user": "http://10.0.2.2:8000/user/"
  };

  Future<ResponseModel> signInWithGoogle() async {
    String res = "some error occurred";
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn(scopes: [
        "email", // only request email
      ]).signIn();

      // Check if the user canceled the sign-in
      if (googleUser == null) {
        return ResponseModel(message: "Sign-in aborted by user", data: null);
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      User? user = userCredential.user;

      if (user != null) {
        userController.updateUserDetails(
            uid: user.uid, email: user.email, name: user.displayName);
        res = "success";
      }
    } on FirebaseAuthException catch (error) {
      res = error.message ?? error.toString();
    }
    return ResponseModel(message: res);
  }

  Future<ResponseModel> signInUsingPhoneNumber() async {
    final otpController = Get.find<OTPController>();
    String res = "some error occurred";
    try {
      String verificationId = otpController.verificationId!;
      final credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: otpController.otp!,
      );
      if (userController.uid == null) {
        final userCredential = await _auth.signInWithCredential(credential);
        User? user = userCredential.user;
        if (user != null) {
          userController.updateUserDetails(uid: user.uid);
          res = "success";
        }
      } else {
        await user?.linkWithCredential(credential);
      }
    } catch (error) {
      if (error is FirebaseAuthException) {
        res = error.message ?? "Verification failed. Please try again.";
      } else {
        res = "An unexpected error occurred: $error";
      }
    }
    return ResponseModel(message: res, data: user);
  }

  Future<ResponseModel> sentOTPtoEmail(String email) async {
    String res = "some error occurred";
    String? otp;
    try {
      final response = await _dio.post(routes['email_otp']!, data: {
        "email": email,
      });
      if (response.statusCode == 200) {
        otp = response.data['msg'].toString();
        res = "success";
      }
    } catch (error) {
      res = error.toString();
    }
    return ResponseModel(message: res, data: otp);
  }

  void sentOTPtoPhone(
      String e164phoneNumber, int? resendToken, BuildContext context) async {
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
            showToastMessage(
                context, "Invalid phone number. Please check and try again.");
          } else if (e.code == 'too-many-requests') {
            showToastMessage(
                context, "Too many requests. Please try again later.");
          } else if (e.code == 'network-request-failed') {
            showToastMessage(context,
                "Network error. Please check your connection and try again.");
          } else if (e.code == 'quota-exceeded') {
            showToastMessage(context,
                "SMS quota exceeded for this project. Try again later.");
          } else if (e.code == 'app-not-authorized') {
            showToastMessage(context,
                "App is not authorized to use Firebase Authentication.");
          } else if (e.code == 'invalid-verification-code') {
            showToastMessage(context, "Invalid verification code.");
          } else {
            showToastMessage(context, "An unknown error occurred.");
          }
        },
        codeSent: (String verificationId, int? resendToken) {
          otpController.verificationId = verificationId;
          otpController.resendToken = resendToken;
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          otpController.verificationId = verificationId;
          // You can add additional logic here if needed
        },
        forceResendingToken: resendToken, // resend otp
      );
    } catch (error) {
      if (context.mounted) {
        showToastMessage(context, "An unexpected error occurred: $error");
      }
    }
  }

    Future<ResponseModel> createAccount(UserModel user) async {
    String res = "some error occurred";
    try {
      final data = {
        'uid': user.uid,
        'username': user.name,
        'email': user.email,
        'phone_number': user.phone?.getE164FormattedPhoneNumber(),
        'profile_image': user.profilePic,
        'gender': user.gender?.toLowerCase(),
        'date_of_birth': user.dateOfBirth,
        'is_active': user.whatsAppMessagePreference,
        'password':"temp"
      };

      final response = await _dio.post(
        routes['create_user']!,
        data: data,
      );

      if (response.statusCode == 201) {
        loggedIn = true;
        res = "success";
      } else {
        res = response.statusMessage ?? res;
      }
    } catch (error) {
      res = error.toString();
    }

    return ResponseModel(message: res);
  }

  Future<ResponseModel> getUserData() async {
    String res = "some error occurred";
    try {
      String? email = user?.email;
      String? phoneNumber = user?.phoneNumber;
      late ResponseModel response;

      if (email != null || phoneNumber != null) {
        if (email != null) {
          response = await getUserWithEmail(email: email);
        } else if (phoneNumber != null) {
          response = await getUserWithPhoneNumber(e164phoneNumber: phoneNumber);
        }

        if (response.message == "success") {
          userController.setUser(response.data);
          userController.updateUserDetails(uid: user!.uid);
          loggedIn = true;
          res = "success";
        } else {
          res = response.message!;
        }
      } else {
        res = "user not found";
      }
    } catch (error) {
      res = error.toString();
    }

    return ResponseModel(message: res);
  }

  Future<ResponseModel> getUserWithEmail({required String email}) async {
    String res = "some error occurred";
    UserModel? user;
    try {
      final data = {
        'email': email,
      };
      final response = await _dio.post(
        routes['get_user']!,
        data: data,
        options: dio.Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );
      if (response.statusCode == 200) {
        user = UserModel.fromMap(response.data);
        res = "success";
      } else if (response.statusCode == 404) {
        res = "user not found";
      } else {
        res = response.statusMessage ?? res;
      }
    } catch (error) {
      res = error.toString();
    }
    return ResponseModel(message: res, data: user);
  }

  Future<ResponseModel> getUserWithPhoneNumber(
      {required String e164phoneNumber}) async {
    String res = "some error occurred";
    UserModel? user;
    try {
      final data = {'phone_number': e164phoneNumber};
      final response = await _dio.post(
        routes['get_user']!,
        data: data,
        options: dio.Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );
      if (response.statusCode == 200) {
        user = UserModel.fromMap(response.data);
        res = "success";
      } else if (response.statusCode == 404) {
        res = "user not found";
      } else {
        res = response.statusMessage ?? res;
      }
    } catch (error) {
      res = error.toString();
    }
    return ResponseModel(message: res, data: user);
  }

  ResponseModel fetchUserAccounts() {
    String res = "some error occurred";
    List<AccountCard> accounts = [];
    try {
      if (user != null) {
        for (final providerData in user!.providerData) {
          String? provider;
          switch (providerData.providerId) {
            case 'google.com':
              provider = 'google';
              break;
            case 'facebook.com':
              provider = 'facebook';
              break;
            case 'password':
              provider = 'email';
              break;
            default:
              provider = providerData.providerId;
          }

          // add to list if required data is available to us
          if (providerData.displayName != null && providerData.email != null) {
            accounts.add(
              AccountCard(
                name: providerData.displayName!,
                mail: providerData.email!,
                provider: provider,
              ),
            );
          }
        }
        res = "success";
      }
    } catch (error) {
      res = error.toString();
    }
    return ResponseModel(message: res, data: accounts);
  }

  Future<ResponseModel> updateUser(UserModel newData) async {
    String res = "some error occurred";
    try{
       final data = {
        'uid': newData.uid,
        'username': newData.name,
        'email': newData.email,
        'phone_number': newData.phone?.getE164FormattedPhoneNumber(),
        'profile_image': newData.profilePic,
        'gender': newData.gender?.toLowerCase(),
        'date_of_birth': newData.dateOfBirth,
        'is_active': newData.whatsAppMessagePreference,
        'password':"temp"
      };

      final response = await _dio.post(
        '${routes['update_user']!}/${userController.id}',
        data: data,
      );

      if (response.statusCode == 200) {
        res = "success";
      } else {
        res = response.statusMessage ?? res;
      }
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
