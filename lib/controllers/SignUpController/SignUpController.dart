import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:restuarant_pager_app/controllers/EmailController/EmailController.dart';
import 'package:restuarant_pager_app/controllers/PhoneNumberController/PhoneNumberController.dart';
import 'package:restuarant_pager_app/controllers/UserController/UserController.dart';
import 'package:restuarant_pager_app/firebase/AuthMethods/AuthMethods.dart';
// import 'package:restuarant_pager_app/firebase/StorageMethods/StorageMethods.dart';
import 'package:restuarant_pager_app/models/PhoneNumberModel/PhoneNumber.model.dart';
import 'package:restuarant_pager_app/models/SignUpModel/SignUp.model.dart';
import 'package:restuarant_pager_app/utils/imagePicker.dart';
import 'package:restuarant_pager_app/utils/toastMessage.dart';
import 'package:restuarant_pager_app/views/LoginView/loginPage.dart';

class SignUpController extends GetxController {
  var signUpModel = SignUpModel().obs;
  PhoneNumberController phoneNumberController = Get.find<PhoneNumberController>();
  EmailController emailController = Get.put(EmailController());
  final _authMethods = Get.find<AuthMethods>();
  final userController = Get.find<UserController>();

  @override
  void onInit(){
    super.onInit();
    signUpModel.value.phoneNumber = PhoneNumberModel(phoneNumber: phoneNumberController.phoneNumber, countryCode: phoneNumberController.selectedCountryCode,);
    signUpModel.value.name = userController.name;
    emailController.emailAddress = userController.email;
    signUpModel.value.email = emailController.emailAddress;
  }

  String? get emailAdress => emailController.emailAddress;
  String? get phoneNumber => phoneNumberController.phoneNumber;
  String? get countryCode => signUpModel.value.phoneNumber!.countryCode;
  String? get countryFlag => phoneNumberController.selectedCountryFlag;
  String? get name => signUpModel.value.name;
  String? get dateOfBirth => signUpModel.value.dateOfBirth;
  String? get gender => signUpModel.value.gender;
  File? get profilePic => signUpModel.value.profilePic;
  bool? get whatsAppMessagePreference => signUpModel.value.sendMessageViaWhatsApp;

  Future<void> selectImage() async {
    final file = await pickImage(ImageSource.gallery);
    signUpModel.update((model) {
      model?.profilePic = file;
    });
  }

void submit(BuildContext context) async {
  signUpModel.value.phoneNumber = phoneNumberController.phoneNumberModel.value;
  signUpModel.value.email = emailController.emailAddress;
  final userData = Get.find<UserController>();


  // temporary -> may be backend handle upload

  // // upload profile pic to firebase if provided
  // String? downloadUrl;
  // if(profilePic != null){
  //   final res = await StorageMethods().uploadProfilePic(file: profilePic!, uid: userData.uid!);
  //   if(res.message == "success"){
  //     downloadUrl = res.data;
  //   }else{
  //     if(context.mounted){
  //       showToastMessage(context, res.message!);
  //     }
  //   }
  // }

  userData.updateUserDetails(
    name: name,
    dateOfBirth: dateOfBirth,
    gender: gender,
    phone: phoneNumberController.phoneNumberModel.value,
    // profilePic: downloadUrl,
    email: emailAdress,
    whatsAppMessagePreference: whatsAppMessagePreference,
  );


  // storing user data in backend
  final res = await _authMethods.createAccount(userData.user,profilePic);
  if(res.message == "success"){
    Get.offAllNamed('/dashboard');
  }else{
    if(context.mounted){
      print(res.message!);
      showToastMessage(context, res.message!);
    }
    userData.clearUserData();
    Get.off(() => const LoginPage());
  }

}

String? validateName() {
  if (signUpModel.value.name == null || signUpModel.value.name!.isEmpty) {
    return "Name can't be empty";
  }
  return null;
}

String? validatePhoneNumber(){
  return phoneNumberController.validate();
}

String? validateEmail(){
  if(!emailController.validate()){
    return "Invalid Email address";
  }
  return null;
}

String? validateDOB() {
  if (signUpModel.value.dateOfBirth == null || signUpModel.value.dateOfBirth!.isEmpty) {
    return "Please Mention Your DOB";
  }
  return null;
}


  void updateName(String name) {
    signUpModel.update((model) {
      model?.name = name;
    });
  }

  Future<void> selectDateOfBirth(BuildContext context) async {
    DateTime initialDate = DateTime.now();
    DateTime firstDate = DateTime(1900);
    DateTime lastDate = DateTime(2100);

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
    );

    if (picked != null && picked != initialDate) {
      signUpModel.update((model) {
        model?.dateOfBirth = "${picked.toLocal()}".split(' ')[0];
      });
    }
  }

  void updateGender(String? gender) {
    signUpModel.update((model) {
      model?.gender = gender;
    });
  }

  void updateEmail(String email) {
    emailController.updateEmailAddress(email);
  }

  void updateMessagePreferences(bool value) {
    signUpModel.update((model) {
      model?.sendMessageViaWhatsApp = value;
    });
  }

}
