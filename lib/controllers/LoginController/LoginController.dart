import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:restuarant_pager_app/controllers/UserController/UserController.dart';
import 'package:restuarant_pager_app/controllers/PhoneNumberController/PhoneNumberController.dart';
import 'package:restuarant_pager_app/firebase/AuthMethods/AuthMethods.dart';
import 'package:restuarant_pager_app/utils/toastMessage.dart';
import 'package:restuarant_pager_app/views/OTPView/otpPage.dart';
import 'package:restuarant_pager_app/views/SignUpView/signUpPage.dart';
import 'package:restuarant_pager_app/views/UpdateNumberDetails/UpdateNumberDetails.dart';

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
    if(isButtonDisabled) return;
    final res = await _authMethods.getUserWithPhoneNumber(e164phoneNumber: phoneNumberController.getE164FormattedPhoneNumber());
    if(res.message == "success"){
      userController.setUser(res.data);
      // go to home screen
      Get.offNamed('/dashboard');
    }else if(res.message == "user not found"){
      Get.to(()=> OtpPageView(onVerified: (){
        Get.to(() => const SignUpPage());
      },));
    }else{
      if(context.mounted){
        showToastMessage(context, res.message!);
      }
      userController.clearUserData();
    }
  }
  void googleSignIn(BuildContext context) async {
    final res = await _authMethods.signInWithGoogle();
    if (res.message == "success") {
      User user = res.data;
        userController.updateUserDetails(uid: user.uid,email: user.email);
        final res2 = await _authMethods.getUserWithUid(uid: user.uid);
        if (res2.message == "user not found") {
          Get.to(() => const UpdateNumberDetails(title: "Add Phone Number"));
        } else {
          userController.setUser(res2.data);
          Get.offNamed('/dashboard');
          // go to home screen
        }
    } else {
      if(context.mounted){
        showToastMessage(context, res.message!); // we can also show snack bar if it preferred
      }
    }
  }

}
