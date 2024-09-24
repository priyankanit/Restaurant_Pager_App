import 'package:delightful_toast/delight_toast.dart';
import 'package:delightful_toast/toast/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void showToastMessage(BuildContext context, String message) {
  DelightToastBar(
    builder: (context) {
      return Container(
          margin: const EdgeInsets.symmetric(horizontal: 40),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: const Color.fromRGBO(255, 244, 237, 1),
            borderRadius: BorderRadius.circular(16),
          ),
          child: IntrinsicHeight(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(
                  Icons.circle,
                  color: Colors.white,
                  size: 24,
                ),
                const SizedBox(width: 10,),
                Expanded(
                  child: Text(
                    message,
                    style: GoogleFonts.inter(
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                      color: const Color.fromRGBO(23, 23, 23, 1),
                    ),
                  ),
                )
              ],
            ),
          ));
    },
    position: DelightSnackbarPosition.top,
    autoDismiss: true,
  ).show(context);
}
