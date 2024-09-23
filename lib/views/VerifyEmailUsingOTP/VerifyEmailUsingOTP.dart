import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restuarant_pager_app/constants/ColorPalette.dart';
import 'package:restuarant_pager_app/controllers/EmailController/EmailController.dart';
import 'package:restuarant_pager_app/controllers/OTPController/OTPContoller.dart';
import 'package:restuarant_pager_app/widgets/Button.dart';
import 'package:restuarant_pager_app/widgets/OTPGrids.dart';

class VerifyEmailUsingOTP extends StatefulWidget {
  final Function() onVerified;
  const VerifyEmailUsingOTP({super.key, required this.onVerified});

  @override
  State<VerifyEmailUsingOTP> createState() => _VerifyEmailUsingOTPState();
}

class _VerifyEmailUsingOTPState extends State<VerifyEmailUsingOTP> {
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
        backgroundColor: backgroundColor,
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
        surfaceTintColor: Colors.transparent,
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "We’ve sent you a code",
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                color: const Color.fromRGBO(23,23,23,1),
                fontWeight: FontWeight.w400,
                fontSize: 16,
                height: 1.25,
              ),
            ),
            const SizedBox(height: 15),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: "OTP sent to ",
                style: GoogleFonts.inter(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  height: 1.21,
                  color: const Color.fromRGBO(0, 0, 0, 0.7),
                ),
                children: [
                  TextSpan(
                    text: Get.find<EmailController>().emailAddress,
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
            const SizedBox(height: 32),

            // Resend OTP countdown
            Obx(() => Text(
              otpController.timerText20s > 0 ? "Resend code in ${otpController.timerText20s.value}" : "Resend code now",
              style: GoogleFonts.inter(
                color: const Color.fromRGBO(23, 23, 23, 1),
                fontWeight: FontWeight.w400,
                fontSize: 14,
                height: 1.21,
              ),
            )),

            const SizedBox(height: 24),

            // Pinput for OTP input
            const OTPGrids(),
            const SizedBox(height: 25),

            // Retry countdown text
            Obx(
              () => RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: "Didn’t get the OTP? ",
                  style: GoogleFonts.inter(
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
                  if ( otpController.isVerified != null && otpController.isVerified!) {
                    widget.onVerified(); // test  
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
