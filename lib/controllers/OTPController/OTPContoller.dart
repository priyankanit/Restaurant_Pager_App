import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restuarant_pager_app/controllers/EmailController/EmailController.dart';
import 'package:restuarant_pager_app/controllers/PhoneNumberController/PhoneNumberController.dart';
import 'package:restuarant_pager_app/controllers/SignUpController/SignUpController.dart';
import 'package:restuarant_pager_app/controllers/UserController/UserController.dart';
import 'package:restuarant_pager_app/firebase/AuthMethods/AuthMethods.dart';
import 'package:restuarant_pager_app/models/OTPModel/OTP.model.dart';
import 'package:restuarant_pager_app/models/PhoneNumberModel/PhoneNumber.model.dart';

class OTPController extends GetxController {
  final OTPModel otpModel = OTPModel();
  late Timer _timer;
  String _emailOTP = '';
  final _authMethods = Get.find<AuthMethods>();
  final phoneController = Get.find<PhoneNumberController>();
  final userController = Get.find<UserController>();
  TextEditingController pinputController = TextEditingController();
  RxInt timerText20s = 20.obs;
  RxInt timerText30s = 30.obs;

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

  void setOTP(String otp) async {
    otpModel.otp = otp;
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
    userController.updateUserDetails(phone: PhoneNumberModel(countryCode: phoneController.selectedCountryCode,phoneNumber: phoneController.phoneNumber));
    _authMethods.sentOTPtoPhone(phoneController.getE164FormattedPhoneNumber(), null, context);
  }

  Future<void> sendOTPtoEmail()async{
    final res = await _authMethods.sentOTPtoEmail(Get.find<EmailController>().emailAddress!);
    if(res.message == "success"){
      _emailOTP = res.data!;
    }
  }

  Future<void> resendOTPtoPhone(BuildContext context)async{
    _authMethods.sentOTPtoPhone(phoneController.getE164FormattedPhoneNumber(), resendToken, context);
  }

  void validatePhoneOTP() async {
    final res = await _authMethods.signInUsingPhoneNumber();
    if(res.message == "success"){
      // extract user data
      User userData = res.data;
      userController.updateUserDetails(uid: userData.uid);
    }else{
      // error in authentication , go to login screen
      Get.offAllNamed('/login');
    }
  }

  void validateEmailOTP() {
    if(_emailOTP.trim() == otp?.trim()){
      // email is verified , submit user data
      Get.find<SignUpController>().submit();
      // goto home screen
      Get.offAllNamed('/dashboard');
    }else{
      // error in authentication , go to signup page
      Get.offAllNamed('/signup');
    }
  }

  @override
  void onClose() {
    _timer.cancel();
    super.onClose();
  }
}
