import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:pinput/pinput.dart';
import 'package:restaurant_pager/controllers/OTPController/OTPContoller.dart';
import 'package:restaurant_pager/utils/reteriveOTPfromSMS.dart';
import 'package:smart_auth/smart_auth.dart';

class OTPGrids extends StatefulWidget {

  const OTPGrids({super.key});

  @override
  State<OTPGrids> createState() => _OTPGridsState();
}

class _OTPGridsState extends State<OTPGrids> {
  OTPController controller = Get.find<OTPController>();
  late final RetrieveOTPFromSMS reteriver;
  final otpController = Get.find<OTPController>();
  @override
  void initState() {
    reteriver = RetrieveOTPFromSMS(SmartAuth());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 327,
      child: Pinput(
        smsRetriever: reteriver,
        validator: (value) => otpController.validate(),
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        length: 4, // The number of OTP digits
        defaultPinTheme: PinTheme(
          width: 72,
          height: 72,
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
        onCompleted: controller.setOTP,
        keyboardType: TextInputType.number,
      ),
    );
  }
}
