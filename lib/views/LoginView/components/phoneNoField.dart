import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restuarant_pager_app/constants/color_palette.dart';
import 'package:restuarant_pager_app/controllers/PhoneNumberController/PhoneNumberController.dart';
import 'package:restuarant_pager_app/views/OTPView/otpPage.dart';
import 'package:restuarant_pager_app/views/SignUpView/signUpPage.dart';
import 'package:restuarant_pager_app/widgets/Button.dart';

class PhoneNoField extends StatefulWidget {
  const PhoneNoField({super.key});

  @override
  State<PhoneNoField> createState() => _PhoneNoFieldState();
}

class _PhoneNoFieldState extends State<PhoneNoField> {
  final PhoneNumberController controller = Get.put(PhoneNumberController());
  final GlobalKey<FormFieldState<String>> _formFieldKey =
      GlobalKey<FormFieldState<String>>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FormField<String>(
          key: _formFieldKey,
          validator: (value) => controller.validate(),
          builder: (state) {
            return Column(
              children: [
                Container(
                  height: 38,
                  width: 315,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        DropdownButtonHideUnderline(
                          child: Obx(() => DropdownButton<String>(
                                value: controller.selectedCountryCode,
                                icon: const Icon(
                                    Icons.keyboard_arrow_down_outlined,
                                    color: Colors.black),
                                dropdownColor: backgroundColor,
                                borderRadius: BorderRadius.circular(4),
                                items: controller.countries.map((country) {
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
                                            textStyle: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              color: fontColor,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }).toList(),
                                onChanged: (String? newValue) {
                                  controller.setSelectedCountryCode(newValue!);
                                },
                              )),
                        ),
                        const VerticalDivider(),
                        Expanded(
                          child: TextField(
                            cursorColor: fontColor,
                            keyboardType: TextInputType.phone,
                            inputFormatters: <TextInputFormatter>[
                              LengthLimitingTextInputFormatter(10),
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.all(10),
                            ),
                            onChanged: (number) {
                              controller.updatePhoneNumber(number);
                            },
                            onEditingComplete: () {
                              _formFieldKey.currentState!.validate();
                            },
                          ),
                        ),
                      ],
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
        ),
        const SizedBox(height: 24),
        SizedBox(
          width: 315,
          child: Button(
            onPressed: () {
              if (controller.isButtonDisabled.value) return;
              Get.to(OtpPageView(
                onVerified: () {
                  Get.to(const SignUpPage());
                },
              ));
            },
            text: 'Continue',
          ),
        ),
      ],
    );
  }
}
