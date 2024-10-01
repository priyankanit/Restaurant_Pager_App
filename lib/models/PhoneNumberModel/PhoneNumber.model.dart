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
    {'name': 'India', 'code': '+91', 'icon': 'assets/phoneNumberAssets/india_icon.svg'},
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
