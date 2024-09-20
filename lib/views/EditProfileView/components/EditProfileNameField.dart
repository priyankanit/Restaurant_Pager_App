import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restuarant_pager_app/constants/color_palette.dart';
import 'package:restuarant_pager_app/controllers/EditProfileController/EditProfileController.dart';

class EditProfileNameField extends StatefulWidget {
  const EditProfileNameField({super.key});

  @override
  State<EditProfileNameField> createState() => _EditProfileNameFieldState();
}

class _EditProfileNameFieldState extends State<EditProfileNameField> {
  late TextEditingController nameController;
  final EditProfileController controller = Get.find<EditProfileController>();
  late FocusNode _focusNode;
  bool isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    nameController = TextEditingController(text: controller.name ?? "");
    _focusNode.addListener(() {
      setState(() {
        isFocused = _focusNode.hasFocus;
      });
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      nameController.text = controller.name ?? "";
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FormField<String>(
      validator: (value) => controller.validateName(),
      builder: (state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Name",
              style: GoogleFonts.inter(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: const Color.fromRGBO(32, 37, 56, 1),
              ),
            ),
            const SizedBox(height: 13),
            Focus(
              focusNode: _focusNode,
              child: GestureDetector(
                onTap: () {
                  _focusNode.requestFocus();
                },
                child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: state.hasError ? Colors.red : isFocused ? themeColor : const Color.fromRGBO(216, 218, 220, 1),
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: nameController,
                          cursorColor: fontColor,
                          style: GoogleFonts.inter(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                          maxLines: 1,
                          textAlignVertical: TextAlignVertical.center,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Enter your name here",
                            hintStyle: GoogleFonts.inter(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: const Color.fromRGBO(128, 128, 128, 1),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                          ),
                          onChanged: (text) {
                            controller.updateName(text);
                          },
                        ),
                      ),
                      if (nameController.text.isNotEmpty)
                        IconButton(
                          onPressed: () {
                            controller.updateName("");
                            setState(() {
                              nameController.text = "";
                            });
                          },
                          icon: const Icon(
                            Icons.close,
                            size: 15,
                          ),
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(
                            maxWidth: 40,
                            maxHeight: 40,
                          ),
                          style: IconButton.styleFrom(
                            shape: const CircleBorder(),
                            backgroundColor: const Color.fromRGBO(255, 244, 237, 0.5),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
            if (state.hasError)
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Text(
                  state.errorText ?? "",
                  style: const TextStyle(
                    color: Colors.red,
                    fontSize: 12,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
