import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restuarant_pager_app/controllers/PhoneNumberController/PhoneNumberController.dart';
import 'package:restuarant_pager_app/controllers/UserController/UserController.dart';
import 'package:restuarant_pager_app/firebase/AuthMethods/AuthMethods.dart';
import 'package:restuarant_pager_app/models/OTPModel/OTP.model.dart';
import 'package:restuarant_pager_app/utils/toastMessage.dart';

class OTPController extends GetxController {
  final OTPModel otpModel = OTPModel();
  late Timer _timer;
  final _authMethods = Get.find<AuthMethods>();
  final phoneController = Get.find<PhoneNumberController>();
  TextEditingController pinputController = TextEditingController();
  RxInt timerText20s = 20.obs;
  RxInt timerText30s = 30.obs;
  bool? isVerified;

  // getters
  String? get otp => otpModel.otp;
  String? get verificationId => otpModel.verificationId;
  int? get resendToken => otpModel.resendToken;

  // setters
  set verificationId(String? id){
    otpModel.verificationId = id;
  }
  set resendToken(int? token){
    otpModel.resendToken = token;
  }
  @override
  void onInit() {
    super.onInit();
    startTimers();
  }

  void setOTP(String otp,bool isPhoneOTP,BuildContext context) async {
    otpModel.otp = otp;
    String? error;
    if(isPhoneOTP){
      error = await validatePhoneOTP();
    }else{
      // handle email OTP verfication
    }
    if(error != null){
      if(context.mounted){
        showToastMessage(context, error);
      }
    }
  }

  void startTimers() {
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      if (timerText20s.value > 0) {
        timerText20s.value--;
      }
      if (timerText30s.value > 0) {
        timerText30s.value--;
      }
      if (timerText20s.value == 0 && timerText30s.value == 0) {
        _timer.cancel();
      }
    });
  }

  void resetTimer() {
    timerText20s.value = 20;
    timerText30s.value = 30;
    startTimers();
  }

  Future<void> sendOTPtoPhone(BuildContext context)async{
    _authMethods.sentOTPtoPhone(phoneController.getE164FormattedPhoneNumber(), null, context);
  }

  Future<void> resendOTPtoPhone(BuildContext context)async{
    _authMethods.sentOTPtoPhone(phoneController.getE164FormattedPhoneNumber(), resendToken, context);
  }

  Future<String?> validatePhoneOTP() async {
    final res = await _authMethods.signInUsingPhoneNumber();
    if(res.message == "success"){
      final userController = Get.find<UserController>();
      User userData = res.data;
      userController.updateUserDetails(uid: userData.uid);
      isVerified = true;
      return null;
    }
    return res.message;
  }

  @override
  void onClose() {
    _timer.cancel();
    super.onClose();
  }
}
