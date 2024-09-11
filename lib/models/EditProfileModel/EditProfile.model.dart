import 'dart:io';

import '../PhoneNumberModel/PhoneNumber.model.dart';

class EditProfileModel {
  String? name;
  String? dateOfBirth;
  String? gender;
  PhoneNumberModel? phoneNumber;
  String? email;
  File? profilePic; // need to upload and store download url

  static const List<String> _genders = [
    "Male", "Female","Other"
  ];

  List<String> get genders => _genders;

  EditProfileModel({
    this.name,
    this.dateOfBirth,
    this.gender,
    this.phoneNumber,
    this.email,
  });
}