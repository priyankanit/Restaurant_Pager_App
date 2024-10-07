import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restuarant_pager_app/constants/color_palette.dart';
import 'package:restuarant_pager_app/controllers/OTPController/OTPContoller.dart';
import 'package:restuarant_pager_app/controllers/PhoneNumberController/PhoneNumberController.dart';
import 'package:restuarant_pager_app/widgets/Button.dart';
import 'package:restuarant_pager_app/widgets/OTPGrids.dart';

class OtpPageView extends StatefulWidget {
  const OtpPageView({super.key});

  @override
  State<OtpPageView> createState() => _OtpPageViewState();
}

class _OtpPageViewState extends State<OtpPageView> {
  late OTPController otpController;
  bool clicked = false;

  @override
  void initState() {
    Get.delete<OTPController>();
    otpController = Get.put(OTPController());
    otpController.sendOTPtoPhone(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: backgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "We’ve sent you a code",
              style: GoogleFonts.inter(
                textStyle: const TextStyle(
                  wordSpacing: 4,
                  color: fontColor,
                  fontWeight: FontWeight.w400,
                  fontSize: 24,
                  height: 1.25,
                ),
              ),
            ),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: "OTP sent to ",
                style: GoogleFonts.inter(
                  textStyle: const TextStyle(
                    wordSpacing: 4,
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    height: 1.21,
                    color: Color.fromRGBO(0, 0, 0, 0.7),
                  ),
                ),
                children: [
                  TextSpan(
                    text: Get.find<PhoneNumberController>().getFormattedPhoneNumber(),
                    style: GoogleFonts.inter(
                      textStyle: const TextStyle(
                        color: Color.fromRGBO(23, 23, 23, 1),
                        fontWeight: FontWeight.w400,
                        fontSize: 15,
                        height: 1.21,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            // Countdown timer for OTP resend
            Obx(() => Text(
              otpController.timerText20s > 0 ? "Resend code in ${otpController.timerText20s.value}" : "Resend code now",
              style: GoogleFonts.inter(
                textStyle: const TextStyle(
                  color: Color.fromRGBO(23, 23, 23, 1),
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  height: 1.21,
                ),
              ),
            )),
            const SizedBox(height: 20),
            const OTPGrids(isPhoneOTP: true,),
            const SizedBox(height: 40),
            Obx(
              () => RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: "Didn’t get the OTP? ",
                  style: GoogleFonts.inter(
                    textStyle: const TextStyle(
                      wordSpacing: 4,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      height: 1.21,
                      color: Color.fromRGBO(51, 51, 51, 1),
                    ),
                  ),
                  children: [
                    TextSpan(
                      text: otpController.timerText30s > 0? "Retry in ${otpController.timerText30s.value}s":"Retry",
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          // handle resend
                          if(otpController.timerText30s > 0) return;
                          otpController.resendOTPtoPhone(context);
                          otpController.resetTimer();
                        },
                      style: GoogleFonts.inter(
                        textStyle: const TextStyle(
                          color: Color.fromRGBO(142, 137, 137, 1),
                          fontWeight: FontWeight.w400,
                          fontSize: 15,
                          height: 1.21,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: 272,
              child: Button(
                onPressed: (){
                  setState(() {
                    clicked = true;
                  });
                  otpController.validatePhoneOTP();
                },
                text: "Verify",
                disable: clicked,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
