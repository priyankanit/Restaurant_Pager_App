import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:pinput/pinput.dart';
import 'package:restuarant_pager_app/controllers/OTPController/OTPContoller.dart';
//import 'package:restuarant_pager_app/utils/reteriveOTPfromSMS.dart';
// import 'package:smart_auth/smart_auth.dart';

class OTPGrids extends StatefulWidget {
  final bool isPhoneOTP;
  const OTPGrids({
    super.key,
    required this.isPhoneOTP,
  });

  @override
  State<OTPGrids> createState() => _OTPGridsState();
}

class _OTPGridsState extends State<OTPGrids> {
  // late final RetrieveOTPFromSMS reteriver;
  final otpController = Get.find<OTPController>();
  @override
  void initState() {
    // reteriver = RetrieveOTPFromSMS(SmartAuth());
    super.initState();
  }

    @override
  void dispose() {
    // reteriver.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 17),
      child: Pinput(
        controller: otpController.pinputController,
        pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        length: 6, // The number of OTP digits
        defaultPinTheme: PinTheme(
          width: 64,
          height: 64,
          textStyle: const TextStyle(
            fontSize: 24,
            color: Color.fromRGBO(23, 23, 23, 1),
            fontWeight: FontWeight.w600,
          ),
          decoration: BoxDecoration(
            border: Border.all(
              color: const Color.fromRGBO(205, 207, 212, 1),
            ),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        focusedPinTheme: PinTheme(
          width: 72,
          height: 72,
          textStyle: const TextStyle(
            fontSize: 24,
            color: Color.fromRGBO(23, 23, 23, 1),
            fontWeight: FontWeight.w600,
          ),
          decoration: BoxDecoration(
            border: Border.all(
              color: const Color.fromRGBO(255, 160, 114, 1),
            ),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        onCompleted:(otp) => otpController.setOTP(otp),
        keyboardType: TextInputType.number,
      ),
    );
  }
}
