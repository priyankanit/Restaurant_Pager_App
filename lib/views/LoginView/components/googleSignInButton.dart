import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restuarant_pager_app/constants/color_palette.dart';
import 'package:restuarant_pager_app/views/UpdateNumberDetails/UpdateNumberDetails.dart';

class GoogleSignInButton extends StatelessWidget {
  const GoogleSignInButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: () {
        // handle google sign in

        // go to add email page
        Get.to(() => const UpdateNumberDetails(title: "Add Phone Number"));
      },
      icon: SvgPicture.asset(
        'assets/loginAssets/google.svg',
        height: 20,
        width: 20,
      ),
      label: Text(
        'Sign in with Google',
        style: GoogleFonts.inter(
          textStyle: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 16,
            height: 1,
            color: fontColor,
          ),
        ),
      ),
      style: TextButton.styleFrom(
        backgroundColor: backgroundColor,
        minimumSize: const Size(238, 44),
        shape: RoundedRectangleBorder(
          side: const BorderSide(
            color: Color.fromRGBO(217, 217, 217, 1),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.all(10),
      ),
    );
  }
}
