import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restuarant_pager_app/constants/color_palette.dart';
import 'package:restuarant_pager_app/controllers/SignUpController/SignUpController.dart';
import 'package:restuarant_pager_app/views/UpdateNumberDetails/UpdateNumberDetails.dart';

class PhoneNoField extends StatefulWidget {
  const PhoneNoField({super.key});

  @override
  State<PhoneNoField> createState() =>
      _PhoneNoFieldState();
}

class _PhoneNoFieldState extends State<PhoneNoField> {
  late SignUpController controller;
  late TextEditingController phoneController;

  @override
  void initState() {
    controller = Get.find<SignUpController>();
    phoneController = TextEditingController();
    phoneController.text = controller.phoneNumber ?? "";
    super.initState();
  }

  @override
  void dispose() {
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Phone number",
          style: GoogleFonts.inter(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: const Color.fromRGBO(32, 37, 56, 1),
          ),
        ),
        const SizedBox(height: 13),
        Container(
          height: 40,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color:const Color.fromRGBO(216, 218, 220, 1),
            ),
          ),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    SvgPicture.asset(
                      controller.countryFlag!,
                      fit: BoxFit.fill,
                      height: 12,
                      width: 12,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      controller.countryCode!,
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: fontColor,
                        height: 1.21,
                      ),
                    ),
                  ],
                ),
                const VerticalDivider(),
                Expanded(
                  child: TextFormField(
                    controller: phoneController,
                    keyboardType: TextInputType.phone,
                    textAlign: TextAlign.start,
                    textAlignVertical: TextAlignVertical.center,
                    cursorColor: const Color.fromRGBO(0, 0, 0, 0.7),
                    inputFormatters: <TextInputFormatter>[
                      LengthLimitingTextInputFormatter(10),
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(10),
                    ),
                    readOnly: true,
                  ),
                ),
                SizedBox(
                  width: 30,
                  child: TextButton(
                    onPressed: () {
                      Get.to(() => const UpdateNumberDetails(title: "Change Phone Number"));
                    },
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                    ),
                    child: Text(
                      "Edit",
                      style: GoogleFonts.inter(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: themeColor,
                      ),
                    ),
                        ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
