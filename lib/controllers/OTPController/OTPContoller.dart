import 'dart:async';
import 'package:get/get.dart';
import 'package:restuarant_pager_app/models/OTPModel/OTP.model.dart';

class OTPController extends GetxController {
  final OTPModel otpModel = OTPModel();
  late Timer _timer;

  RxInt timerText20s = 20.obs;
  RxInt timerText30s = 30.obs;
  bool? isVerified;
  RxList<String> pins = List.filled(4, "").obs;

  String get otp => otpModel.otp;

  @override
  void onInit() {
    super.onInit();
    startTimers();
  }

  void setOTP(String otp) {
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

  String? validate() {
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
