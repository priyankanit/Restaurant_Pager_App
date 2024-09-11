import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restuarant_pager_app/constants/color_palette.dart';
import 'package:restuarant_pager_app/controllers/SignUpController/SignUpController.dart';

class EmailField extends StatefulWidget {
  const EmailField({super.key});

  @override
  State<EmailField> createState() => _EmailFieldState();
}

class _EmailFieldState extends State<EmailField> {
  final controller = Get.find<SignUpController>();
  late TextEditingController emailController;
  FocusNode focusNode = FocusNode();
  bool isFocused = false;
  bool isEditing = false;

  @override
  void initState() {
    emailController = TextEditingController();
    focusNode.addListener(() {
      setState(() {
        isFocused = focusNode.hasFocus;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FormField<String>(
      validator: (value) => controller.validateEmail(),
      builder: (state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Email Id",
              style: GoogleFonts.inter(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: const Color.fromRGBO(32, 37, 56, 1),
              ),
            ),
            const SizedBox(height: 13),
            Focus(
              focusNode: focusNode,
              child: GestureDetector(
                onTap: () {
                  focusNode.requestFocus();
                },
                child: Container(
                  width: double.infinity,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: state.hasError
                          ? Colors.red
                          : isFocused
                              ? themeColor
                              : const Color.fromRGBO(216, 218, 220, 1),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: emailController,
                          cursorColor: fontColor,
                          style: GoogleFonts.inter(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                          maxLines: 1,
                          textAlignVertical: TextAlignVertical.center,
                          decoration: InputDecoration(
                            hintText: "Enter your email",
                            hintStyle: GoogleFonts.inter(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: const Color.fromRGBO(128, 128, 128, 1),
                            ),
                            fillColor: Colors.white,
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                          ),
                          keyboardType: TextInputType.emailAddress,
                          onEditingComplete: () {
                            controller.updateEmail(emailController.text);
                            setState(() {
                              isEditing = false;
                            });
                          },
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          readOnly: !isEditing,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            isEditing = true;
                          });
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
