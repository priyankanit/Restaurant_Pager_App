import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:restuarant_pager_app/controllers/UserController/UserController.dart';
import 'package:restuarant_pager_app/firebase/AuthMethods/AuthMethods.dart';
import 'package:restuarant_pager_app/firebase/StorageMethods/StorageMethods.dart';
import 'package:restuarant_pager_app/models/EditProfileModel/EditProfile.model.dart';
import 'package:restuarant_pager_app/utils/imagePicker.dart';
import 'package:restuarant_pager_app/utils/toastMessage.dart';

class EditProfileController extends GetxController {
  var model = EditProfileModel().obs;
  final userController = Get.find<UserController>();
  File? _selectedPic;

  @override
  void onInit(){
    super.onInit();
    model.update((model){
      model?.dateOfBirth = userController.dateOfBirth;
      model?.name = userController.name;
      model?.gender = userController.gender;
      model?.email = userController.email;
      model?.profilePic = userController.profilePic;
    });
  }

  // Getters
  String? get profilePic => model.value.profilePic;
  File? get selectedPic => _selectedPic;
  String? get gender => model.value.gender;
  String? get dateOfBirth => model.value.dateOfBirth;
  String? get name => model.value.name;
  String? get emailAddress => model.value.email;
  String? get phoneNumber => model.value.phoneNumber?.phoneNumber;
  String? get countryCode => model.value.phoneNumber?.countryCode;

  String? get countryFlag {
    final selectedCode = countryCode;
    final country = model.value.phoneNumber?.countries.firstWhere(
      (country) => country['code'] == selectedCode,
      orElse: () => {},
    );
    return country?['icon']; 
  }

  Future<void> selectImage() async {
    final file = await pickImage(ImageSource.gallery);
    _selectedPic = file;
  }

  void submit(BuildContext context) async {
    final authMethods = Get.find<AuthMethods>();
    // upload profile pic if given
    String? downloadUrl;
    if(_selectedPic != null){
      final res = await StorageMethods().uploadProfilePic(file: _selectedPic!, uid: userController.uid!);
      if(res.message == "success"){
        downloadUrl = res.data;
      }else{
        if(context.mounted){
          showToastMessage(context, "Error uploading file");
        }
      }
    }
    // update model
    model.update((model){
      model?.profilePic = downloadUrl ?? profilePic;
    });

    userController.updateUserDetails(name: name,dateOfBirth: dateOfBirth,profilePic: profilePic,gender: gender,);
    final res = await authMethods.updateUser(userController.user);
    if(res.message != "success"){
      if(context.mounted) showToastMessage(context, "Error updating details");
    }
  }

  String? validateName() {
    if (model.value.name == null || model.value.name!.isEmpty) {
      return "Name can't be empty";
    }
    return null;
  }

  String? validateDOB() {
    if (model.value.dateOfBirth == null || model.value.dateOfBirth!.isEmpty) {
      return "Please Mention Your DOB";
    }
    return null;
  }

  void updateName(String name) {
    model.update((model) {
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
      model.update((model) {
        model?.dateOfBirth = "${picked.toLocal()}".split(' ')[0];
      });
    }
  }

  void clearDateOfBirth(){
    model.value.dateOfBirth = null;
  }

  void updateGender(String? gender) {
    model.update((model) {
      model?.gender = gender;
    });
  }
}
