import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restuarant_pager_app/controllers/EditProfileController/EditProfileController.dart';

class EditProfilePicField extends StatefulWidget {
  const EditProfilePicField({super.key});

  @override
  State<EditProfilePicField> createState() => _EditProfilePicFieldState();
}

class _EditProfilePicFieldState extends State<EditProfilePicField> {
  final controller = Get.find<EditProfileController>();
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
            width: 106,
            height: 104.6,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: Obx(() => CircleAvatar(
                  backgroundColor: const Color.fromRGBO(247, 249, 250, 1),
                  radius: 36.5,
                  backgroundImage: controller.profilePic != null ? FileImage(controller.profilePic!):null,
                  child: controller.profilePic== null ? Text(
                          "SS",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.inter(
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                            height: 1.21,
                            color: Colors.black,
                          ),
                        ):null,
                )),
          ),
        ),
        Positioned(
          top: 72.6,
          left: 78,
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
