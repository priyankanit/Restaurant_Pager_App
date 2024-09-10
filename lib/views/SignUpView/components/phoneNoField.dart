import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restaurant_pager/constants/ColorPalette.dart';
import 'package:restaurant_pager/controllers/SignUpController/SignUpController.dart';

class PhoneNoField extends StatefulWidget {
  const PhoneNoField({super.key});

  @override
  State<PhoneNoField> createState() => _PhoneNoFieldState();
}

class _PhoneNoFieldState extends State<PhoneNoField> {
  final controller = Get.find<SignUpController>();
  late TextEditingController phoneController;
  final FocusNode focusNode = FocusNode();
  final GlobalKey<FormFieldState<String>> _formFieldKey = GlobalKey<FormFieldState<String>>();
  bool isFocused = false;
  bool isEditing = false;

  @override
  void initState() {
    phoneController = TextEditingController();
    focusNode.addListener(() {
      setState(() {
        isFocused = focusNode.hasFocus;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    phoneController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FormField<String>(
      key: _formFieldKey,
      validator: (value) => controller.validatePhoneNumber(),
      builder: (state) {
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
            Focus(
              focusNode: focusNode,
              child: Container(
                height: 40,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: state.hasError
                        ? Colors.red
                        : isFocused
                            ? themeColor
                            : const Color.fromRGBO(216, 218, 220, 1),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                  child: GestureDetector(
                    onTap: () => focusNode.requestFocus(),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Obx(
                          () => DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: controller.phoneNumberController.selectedCountryCode,
                              icon: const Icon(Icons.keyboard_arrow_down_outlined, color: Colors.black),
                              dropdownColor: backgroundColor,
                              borderRadius: BorderRadius.circular(4),
                              items: controller.phoneNumberController.countries.map((country) {
                                return DropdownMenuItem<String>(
                                  value: country['code'],
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(
                                        country['icon']!,
                                        fit: BoxFit.contain,
                                        height: 16,
                                        width: 16,
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        country['code']!,
                                        style: GoogleFonts.inter(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: fontColor,
                                          height: 1.21,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                if (newValue != null) {
                                  controller.phoneNumberController.setSelectedCountryCode(newValue);
                                  state.didChange(newValue);
                                }
                              },
                            ),
                          ),
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
                            onEditingComplete: () {
                              _formFieldKey.currentState!.validate();
                              setState(() {
                                isEditing = false;
                              });
                            },
                            onChanged: (number) => controller.updatePhoneNumber(number),
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.all(10),
                            ),
                            readOnly: !isEditing,
                          ),
                        ),
                        SizedBox(
                          width: 30,
                          child: TextButton(
                            onPressed: () {
                              setState(() {
                                isEditing = true;
                              });
                            },
                            style: TextButton.styleFrom(
                              surfaceTintColor: Colors.transparent,
                              backgroundColor: backgroundColor,
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
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            if (state.hasError)
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Text(
                  state.errorText ?? "",
                  style: GoogleFonts.inter(
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
