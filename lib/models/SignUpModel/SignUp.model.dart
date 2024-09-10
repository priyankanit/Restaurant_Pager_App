import 'dart:io';

class SignUpModel {
  String? name;
  String? dateOfBirth;
  String? gender;
  String? phoneNumber;
  String? email;
  bool sendMessageViaWhatsApp = false;
  File? profilePic;


  SignUpModel({
    this.name,
    this.dateOfBirth,
    this.gender,
    this.phoneNumber,
    this.email,
  });
}
