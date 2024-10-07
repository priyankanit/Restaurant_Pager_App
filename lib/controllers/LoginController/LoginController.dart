import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:restuarant_pager_app/controllers/UserController/UserController.dart';
import 'package:restuarant_pager_app/controllers/PhoneNumberController/PhoneNumberController.dart';
import 'package:restuarant_pager_app/firebase/AuthMethods/AuthMethods.dart';
import 'package:restuarant_pager_app/utils/toastMessage.dart';
import 'package:restuarant_pager_app/views/OTPView/otpPage.dart';

class LoginController extends GetxController {
  final _authMethods = Get.find<AuthMethods>();
  final userController = Get.find<UserController>();
  PhoneNumberController phoneNumberController = Get.put(PhoneNumberController());

  String? get phoneNumber => phoneNumberController.phoneNumber;
  String? get selectedCountryCode => phoneNumberController.selectedCountryCode;
  String? get selectedCountryFlag => phoneNumberController.selectedCountryFlag;
  List<Map<String, String>> get countries => phoneNumberController.countries;
  bool get isButtonDisabled => phoneNumberController.isButtonDisabled.value;
  

  void updatePhoneNumber(String number){
    phoneNumberController.updatePhoneNumber(number);
  }

  void setSelectedCountryCode(String countryCode){
    phoneNumberController.setSelectedCountryCode(countryCode);
  }

  String? validatePhoneNumber(){
    return phoneNumberController.validate();
  }
  void phoneSignIn(BuildContext context) async {
    debugPrint("inside phone sign in");
    if (isButtonDisabled) return;
    Get.to(() => const OtpPageView());
  }
  void googleSignIn(BuildContext context) async {
    debugPrint("inside google sign in");
    final res = await _authMethods.signInWithGoogle();
    if(res.message != "success") {
      debugPrint("google sign in error : ${res.message}");
      if(context.mounted){
        showToastMessage(context, res.message!);
      }
    }
  }

}
