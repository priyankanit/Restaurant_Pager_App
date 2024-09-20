import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart'; 
import 'package:restuarant_pager_app/constants/ColorPalette.dart';
import 'package:restuarant_pager_app/controllers/PhoneNumberController/PhoneNumberController.dart';
import 'package:restuarant_pager_app/firebase/AuthMethods/AuthMethods.dart';
import 'package:restuarant_pager_app/views/SignUpView/signUpPage.dart';
import 'package:restuarant_pager_app/views/VerifyPhoneNoUsingOTP/VerifyPhoneNoUsingOTP.dart';
import 'package:restuarant_pager_app/widgets/Button.dart';
import 'package:restuarant_pager_app/utils/toastMessage.dart';

class UpdateNumberDetails extends StatefulWidget {
  final String title;
  const UpdateNumberDetails({super.key, required this.title});

  @override
  State<UpdateNumberDetails> createState() => _UpdateNumberDetailsState();
}

class _UpdateNumberDetailsState extends State<UpdateNumberDetails> {
  final PhoneNumberController controller = Get.put(PhoneNumberController());
  final GlobalKey<FormFieldState<String>> _formFieldKey = GlobalKey<FormFieldState<String>>();
  late TextEditingController phoneController;
  @override
  void initState() {
    phoneController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    phoneController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColor,
        surfaceTintColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          widget.title,
          style: GoogleFonts.inter( 
            color: fontColor,
            fontWeight: FontWeight.w600,
            fontSize: 20,
            height: 1.25,
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(flex: 1),
              Text(
                "Enter a new phone number, and we will send an OTP for verification.",
                textAlign: TextAlign.center,
                style: GoogleFonts.inter( 
                  wordSpacing: 4,
                  color: const Color.fromRGBO(23, 23, 23, 1),
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                  height: 1.25,
                ),
              ),
              const SizedBox(height: 29),
              FormField<String>(
                key: _formFieldKey,
                validator: (value) => controller.validate(),
                builder: (state) {
                  return Column(
                    children: [
                      Container(
                        height: 40,
                        width: 287,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: state.hasError? Colors.red :const Color.fromRGBO(216, 218, 220, 1),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Obx(()=>DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  value: controller.selectedCountryCode,
                                  icon: const Icon(Icons.keyboard_arrow_down_outlined, color: Colors.black),
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
                                      controller.setSelectedCountryCode(newValue);
                                    }
                                  },
                                ),
                                ),
                              ),
                              const VerticalDivider(),
                              Expanded(
                                child: TextField(
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
                                  },
                                  onChanged: (text){
                                    controller.updatePhoneNumber(text);
                                  },
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.all(10),
                                  ),
                                ),
                              ),
                              if(phoneController.text.isNotEmpty)
                              IconButton(
                                onPressed: () {
                                  controller.clearPhoneNumber();
                                  setState(() {
                                    phoneController.text = "";
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
                              )
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
                }
              ),
              const Spacer(flex: 5),
              Obx(() => SizedBox(
                width: 272,
                child: Button(
                  onPressed: () async {
                    final res = await Get.find<AuthMethods>().getUserWithPhoneNumber(e164phoneNumber: controller.getE164FormattedPhoneNumber());
                    if(res.message == "success"){
                      if(context.mounted){
                        showToastMessage(context, "The phone number you entered is already in\nuse. Please provide a different phone number.");
                      }
                      return;
                    }

                    Get.to(() => VerifyPhoneNoUsingOTP(onVerified: (){
                      Get.off(const SignUpPage());
                    }));
                  },
                  text: "Send OTP",
                  disable: controller.isButtonDisabled.value,
                ),
              )),
              const Spacer(flex: 1),
            ],
          ),
        ),
      ),
    );
  }
}
