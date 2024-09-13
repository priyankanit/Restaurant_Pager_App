class PhoneNumberModel {
  String? phoneNumber;
  String countryCode;

  PhoneNumberModel({required this.phoneNumber, required this.countryCode});

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

  // Function to get the complete formatted phone number
  String getFormattedPhoneNumber() {
    return '$countryCode $phoneNumber';
  }
}