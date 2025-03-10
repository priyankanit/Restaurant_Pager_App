import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';
import 'package:restuarant_pager_app/controllers/OTPController/OTPContoller.dart';
import 'package:restuarant_pager_app/controllers/PhoneNumberController/PhoneNumberController.dart';
import 'package:restuarant_pager_app/widgets/Button.dart';

class VerifyPhoneNoUsingOTP extends StatefulWidget {
  final Function() onVerified;
  const VerifyPhoneNoUsingOTP({super.key, required this.onVerified});

  @override
  State<VerifyPhoneNoUsingOTP> createState() => _VerifyPhoneNoUsingOTPState();
}

class _VerifyPhoneNoUsingOTPState extends State<VerifyPhoneNoUsingOTP> {
  late OTPController otpController;

  @override
  void initState() {
    Get.delete<OTPController>();
    otpController = Get.put(OTPController());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Verify existing account",
          style: GoogleFonts.inter(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 20,
            height: 1.25,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Please verify your new account\ninformation",
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                wordSpacing: 4,
                color: const Color.fromRGBO(23, 23, 23, 1),
                fontWeight: FontWeight.w400,
                fontSize: 16,
                height: 1.25,
              ),
            ),
            const SizedBox(height: 10),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: "OTP sent to ",
                style: GoogleFonts.inter(
                  wordSpacing: 4,
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  height: 1.21,
                  color: const Color.fromRGBO(0, 0, 0, 0.7),
                ),
                children: [
                  TextSpan(
                    text: Get.find<PhoneNumberController>()
                        .getFormattedPhoneNumber(),
                    style: GoogleFonts.inter(
                      color: const Color.fromRGBO(23, 23, 23, 1),
                      fontWeight: FontWeight.w400,
                      fontSize: 15,
                      height: 1.21,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),

            // Resend OTP countdown
            Obx(() => Text(
                  otpController.timerText20s > 0
                      ? "Resend code in ${otpController.timerText20s.value}"
                      : "Resend code now",
                  style: GoogleFonts.inter(
                    color: const Color.fromRGBO(23, 23, 23, 1),
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    height: 1.21,
                  ),
                )),

            const SizedBox(height: 20),

            // Pinput for OTP input
            Pinput(
              mainAxisAlignment: MainAxisAlignment.center,
              length: 4, // The number of OTP digits
              defaultPinTheme: PinTheme(
                width: 72,
                height: 72,
                textStyle: GoogleFonts.inter(
                  fontSize: 24,
                  color: const Color.fromRGBO(23, 23, 23, 1),
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
                textStyle: GoogleFonts.inter(
                  fontSize: 24,
                  color: const Color.fromRGBO(23, 23, 23, 1),
                  fontWeight: FontWeight.w600,
                ),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color.fromRGBO(255, 160, 114, 1),
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onCompleted: (otp) {
                otpController.setOTP(otp);
              },
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 6),

            // Retry countdown text
            Obx(
              () => RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: "Didn’t get the OTP? ",
                  style: GoogleFonts.inter(
                    wordSpacing: 4,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    height: 1.21,
                    color: const Color.fromRGBO(51, 51, 51, 1),
                  ),
                  children: [
                    TextSpan(
                      text: otpController.timerText30s > 0
                          ? "Retry in ${otpController.timerText30s.value}s"
                          : "Retry",
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          // handle resend
                          otpController.resetTimer();
                        },
                      style: GoogleFonts.inter(
                        color: const Color.fromRGBO(142, 137, 137, 1),
                        fontWeight: FontWeight.w400,
                        fontSize: 15,
                        height: 1.21,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),

            // Submit button
            SizedBox(
              width: 272,
              child: Button(
                onPressed: () {
                  if (otpController.isVerified != null &&
                      otpController.isVerified!) {
                    widget.onVerified();
                  }
                },
                text: "Submit",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
