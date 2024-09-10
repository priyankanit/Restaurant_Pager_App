import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurant_pager/models/OTPModel/OTP.model.dart';

class OTPController extends GetxController {
  final OTPModel otpModel = OTPModel();
  late Timer _timer;

  // Observables for reactive state management
  RxInt timerText20s = 20.obs;
  RxInt timerText30s = 30.obs;
  bool? isVerified;
  RxList<String> pins = List.filled(4, "").obs;

  // Getter for OTP from the model
  String get otp => otpModel.otp;

  @override
  void onInit() {
    super.onInit();
    startTimers();
  }

  // Set OTP in the model
  void setOTP(String otp) {
    otpModel.otp = otp;
  }

  // Start timers for resend logic
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

  // Reset the resend timer
  void resetTimer() {
    timerText20s.value = 20;
    timerText30s.value = 30;
    startTimers();
  }

  String? validate() {
    debugPrint(otp);
    if(otp.length != 4){
      isVerified = false;
      return "OTP not matched";
    }
    // fetch otp and check
    isVerified = true;
    return null;
  }

  @override
  void onClose() {
    _timer.cancel();
    super.onClose();
  }
}
