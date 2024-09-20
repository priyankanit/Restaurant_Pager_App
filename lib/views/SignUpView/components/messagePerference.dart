import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restuarant_pager_app/constants/color_palette.dart';
import 'package:restuarant_pager_app/controllers/SignUpController/SignUpController.dart';

class MessagePerference extends StatefulWidget {
  const MessagePerference({super.key});

  @override
  State<MessagePerference> createState() => _MessagePerferenceState();
}

class _MessagePerferenceState extends State<MessagePerference> {
  final controller = Get.find<SignUpController>();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SvgPicture.asset(
          "assets/signUpAssets/whatsapp.svg",
          height: 24,
          width: 24,
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: Text(
            "Send me updates on whatsapp",
            style: GoogleFonts.inter(
                fontSize: 12, fontWeight: FontWeight.w500, color: Colors.black),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Obx(
          () => Checkbox(
            value: controller.signUpModel.value.sendMessageViaWhatsApp,
            onChanged: (value) {
              controller.updateMessagePreferences(value ?? false);
            },
            checkColor: Colors.white,
            activeColor: themeColor,
          ),
        )
      ],
    ));
  }
}
