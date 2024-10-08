// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class PhoneNumberModel {
  String? phoneNumber;
  String countryCode;

  PhoneNumberModel({
    this.phoneNumber,
    required this.countryCode,
  });

static const List<Map<String, String>> _countries = [
  {'name': 'India', 'code': '+91', 'icon': 'assets/phoneNumberAssets/in.svg'},
  {'name': 'United States', 'code': '+01', 'icon': 'assets/phoneNumberAssets/us.svg'},
  {'name': 'United Kingdom', 'code': '+44', 'icon': 'assets/phoneNumberAssets/gb.svg'},
  {'name': 'Germany', 'code': '+49', 'icon': 'assets/phoneNumberAssets/de.svg'},
  {'name': 'Canada', 'code': '+1', 'icon': 'assets/phoneNumberAssets/ca.svg'},
  {'name': 'Australia', 'code': '+61', 'icon': 'assets/phoneNumberAssets/au.svg'},
  {'name': 'France', 'code': '+33', 'icon': 'assets/phoneNumberAssets/fr.svg'},
  {'name': 'Japan', 'code': '+81', 'icon': 'assets/phoneNumberAssets/jp.svg'},
  {'name': 'China', 'code': '+86', 'icon': 'assets/phoneNumberAssets/cn.svg'},
  {'name': 'Brazil', 'code': '+55', 'icon': 'assets/phoneNumberAssets/br.svg'},
  {'name': 'South Africa', 'code': '+27', 'icon': 'assets/phoneNumberAssets/za.svg'},
  {'name': 'Russia', 'code': '+7', 'icon': 'assets/phoneNumberAssets/ru.svg'},
  {'name': 'Mexico', 'code': '+52', 'icon': 'assets/phoneNumberAssets/mx.svg'},
  {'name': 'Argentina', 'code': '+54', 'icon': 'assets/phoneNumberAssets/ar.svg'},
  {'name': 'Italy', 'code': '+39', 'icon': 'assets/phoneNumberAssets/it.svg'},
  {'name': 'Spain', 'code': '+34', 'icon': 'assets/phoneNumberAssets/es.svg'},
  {'name': 'Netherlands', 'code': '+31', 'icon': 'assets/phoneNumberAssets/nl.svg'},
  {'name': 'Sweden', 'code': '+46', 'icon': 'assets/phoneNumberAssets/se.svg'},
  {'name': 'Switzerland', 'code': '+41', 'icon': 'assets/phoneNumberAssets/ch.svg'},
  {'name': 'Norway', 'code': '+47', 'icon': 'assets/phoneNumberAssets/no.svg'},
  {'name': 'Denmark', 'code': '+45', 'icon': 'assets/phoneNumberAssets/dk.svg'},
  {'name': 'Finland', 'code': '+358', 'icon': 'assets/phoneNumberAssets/fi.svg'},
  {'name': 'Belgium', 'code': '+32', 'icon': 'assets/phoneNumberAssets/be.svg'},
  {'name': 'Ireland', 'code': '+353', 'icon': 'assets/phoneNumberAssets/ie.svg'},
  {'name': 'New Zealand', 'code': '+64', 'icon': 'assets/phoneNumberAssets/nz.svg'},
  {'name': 'South Korea', 'code': '+82', 'icon': 'assets/phoneNumberAssets/kr.svg'},
  {'name': 'Singapore', 'code': '+65', 'icon': 'assets/phoneNumberAssets/sg.svg'},
  {'name': 'Malaysia', 'code': '+60', 'icon': 'assets/phoneNumberAssets/my.svg'},
  {'name': 'Philippines', 'code': '+63', 'icon': 'assets/phoneNumberAssets/ph.svg'},
  {'name': 'Thailand', 'code': '+66', 'icon': 'assets/phoneNumberAssets/th.svg'},
  {'name': 'Vietnam', 'code': '+84', 'icon': 'assets/phoneNumberAssets/vn.svg'},
];


  List<Map<String, String>> get countries => _countries;


  // Function to check if the phone number is valid
  bool isPhoneNumberValid() {
    if(phoneNumber == null) return false;
    return phoneNumber!.length == 10
    && phoneNumber!.startsWith(RegExp(r'[6-9]'));
  }

  // Function to check if the phone number is valid
 String? getFormattedPhoneNumber() {
  if (phoneNumber != null && phoneNumber!.length >= 10) {
    return '$countryCode ${phoneNumber!.substring(0, 5)} ${phoneNumber!.substring(5)}';
  }
  return null;
}

  String getE164FormattedPhoneNumber(){
    return '$countryCode$phoneNumber';
  }

  PhoneNumberModel copyWith({
    String? phoneNumber,
    String? countryCode,
  }) {
    return PhoneNumberModel(
      phoneNumber: phoneNumber ?? this.phoneNumber,
      countryCode: countryCode ?? this.countryCode,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'phone_number': phoneNumber,
      'country_code': countryCode,
    };
  }

  factory PhoneNumberModel.fromMap(Map<String, dynamic> map) {
    return PhoneNumberModel(
      phoneNumber: map['phone_number'] != null ? map['phone_number'] as String : null,
      countryCode: map['country_code'] as String,
    );
  }

// Method to fill country code and phone number from an E.164 formatted number
factory PhoneNumberModel.fillFromE164(String e164FormattedNumber) {
  for (var country in _countries) {
    final code = country['code']!;
    if (e164FormattedNumber.startsWith(code)) {
      final parsedPhoneNumber = e164FormattedNumber.substring(code.length);
      return PhoneNumberModel(
        countryCode: code,
        phoneNumber: parsedPhoneNumber,
      );
    }
  }
  throw Exception('Country code not found for the given number');
}


  String toJson() => json.encode(toMap());

  factory PhoneNumberModel.fromJson(String source) => PhoneNumberModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'PhoneNumberModel(phoneNumber: $phoneNumber, countryCode: $countryCode)';

  @override
  bool operator ==(covariant PhoneNumberModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.phoneNumber == phoneNumber &&
      other.countryCode == countryCode;
  }

  @override
  int get hashCode => phoneNumber.hashCode ^ countryCode.hashCode;
}
