import 'dart:convert';
import 'package:restuarant_pager_app/models/PhoneNumberModel/PhoneNumber.model.dart';

class UserModel {
  String? uid;
  String? name;
  String? dateOfBirth;
  String? gender;
  PhoneNumberModel? phone;
  String? email;
  String? profilePic;
  bool? whatsAppMessagePreference;

  UserModel({
    this.uid,
    this.name,
    this.dateOfBirth,
    this.gender,
    this.phone,
    this.email,
    this.profilePic,
    this.whatsAppMessagePreference = false,
  });

  UserModel copyWith({
    String? uid,
    String? name,
    String? dateOfBirth,
    String? gender,
    PhoneNumberModel? phone,
    String? email,
    String? profilePic,
    bool? whatsAppMessagePreference,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      gender: gender ?? this.gender,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      profilePic: profilePic ?? this.profilePic,
      whatsAppMessagePreference: whatsAppMessagePreference ?? this.whatsAppMessagePreference,
    );
  }

  Map<String, dynamic> toMap() {
    // according to backend
    return <String, dynamic>{
      'uid': uid,
      'username': name,
      'date_of_birth': dateOfBirth,
      'gender': gender,
      'phone_number': phone?.toMap(),
      'email': email,
      'profile_image': profilePic,
      'is_active': whatsAppMessagePreference,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] as String,
      name: map['username'] as String,
      dateOfBirth: map['date_of_birth'] as String,
      gender: map['gender'] as String,
      phone: PhoneNumberModel.fromMap(map['phone_number'] as Map<String,dynamic>),
      email: map['email'] as String,
      profilePic: map['profile_image'] as String,
      whatsAppMessagePreference: map['is_active'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(uid: $uid, name: $name, dateOfBirth: $dateOfBirth, gender: $gender, phone: $phone, email: $email, profilePic: $profilePic, whatsAppMessagePreference: $whatsAppMessagePreference)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.uid == uid &&
      other.name == name &&
      other.dateOfBirth == dateOfBirth &&
      other.gender == gender &&
      other.phone == phone &&
      other.email == email &&
      other.profilePic == profilePic &&
      other.whatsAppMessagePreference == whatsAppMessagePreference;
  }

  @override
  int get hashCode {
    return uid.hashCode ^
      name.hashCode ^
      dateOfBirth.hashCode ^
      gender.hashCode ^
      phone.hashCode ^
      email.hashCode ^
      profilePic.hashCode ^
      whatsAppMessagePreference.hashCode;
  }
}
