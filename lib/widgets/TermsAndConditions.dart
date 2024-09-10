import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restaurant_pager/constants/ColorPalette.dart';

class TermsAndConditons extends StatelessWidget {
  const TermsAndConditons({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        text: 'By creating an account or signing in, you\n agree to our ',
        style: GoogleFonts.inter(
          textStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            height: 1.25,
            color: Color.fromRGBO(0, 0, 0, 0.7),
          ),
        ),
        children: [
          TextSpan(
            text: 'Terms and Conditions',
            style: GoogleFonts.inter(
              textStyle: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                decoration: TextDecoration.underline,
                color: fontColor,
                height: 1.21,
              ),
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                // handle terms and conditions tap
              },
          ),
          const TextSpan(
            text: '.',
            style: TextStyle(
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
