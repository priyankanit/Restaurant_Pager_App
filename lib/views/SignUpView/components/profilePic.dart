import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restuarant_pager_app/constants/color_palette.dart';
import 'package:restuarant_pager_app/controllers/SignUpController/SignUpController.dart';

class ProfilePic extends StatefulWidget {
  const ProfilePic({super.key});

  @override
  State<ProfilePic> createState() => _ProfilePicState();
}

class _ProfilePicState extends State<ProfilePic> {
  final controller = Get.find<SignUpController>();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(1.0),
          child: Container(
            width: 90,
            height: 90,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: backgroundColor,
                width: 5,
              ),
              boxShadow: const [
                BoxShadow(
                  color: Color.fromRGBO(16, 24, 40, 0.06),
                  offset: Offset(0, 1),
                  blurRadius: 2,
                  spreadRadius: 0,
                ),
                BoxShadow(
                  color: Color.fromRGBO(16, 24, 40, 0.1),
                  offset: Offset(0, 1),
                  blurRadius: 3,
                  spreadRadius: 0,
                ),
              ],
            ),
            child: Obx(() => CircleAvatar(
                  backgroundColor: const Color.fromRGBO(247, 249, 250, 1),
                  radius: 36.5,
                  backgroundImage: controller.profilePic != null
                      ? FileImage(controller.profilePic!)
                      : null,
                  child: controller.profilePic == null
                      ? Text(
                          "SS",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.inter(
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                            height: 1.21,
                            color: Colors.black,
                          ),
                        )
                      : null,
                )),
          ),
        ),
        Positioned(
          top: 58,
          left: 62,
          child: Container(
            width: 30,
            height: 27,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border.all(
                color: const Color.fromRGBO(234, 236, 240, 1),
              ),
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(8),
            ),
            child: IconButton(
              onPressed: controller.selectImage,
              icon: SvgPicture.asset("assets/signUpAssets/edit.svg"),
              padding: const EdgeInsets.all(0),
            ),
          ),
        ),
      ],
    );
  }
}
