import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:restuarant_pager_app/models/EditProfileModel/EditProfile.model.dart';
import 'package:restuarant_pager_app/models/PhoneNumberModel/PhoneNumber.model.dart';
import 'package:restuarant_pager_app/utils/imagePicker.dart';

class EditProfileController extends GetxController {
  var model = EditProfileModel(
    //temporary
    phoneNumber: PhoneNumberModel(
      phoneNumber: "98765 43210",
      countryCode: "+91",
    ),
    email: "Sahib19@gmail.com",
  ).obs;

  @override
  void onReady() {
    // Populate fields with previous data (fetch from database or API)

  }

  // Getters
  File? get profilePic => model.value.profilePic;
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
    model.update((model) {
      model?.profilePic = file;
    });
  }

  void submit() {
    // Handle submission logic
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
