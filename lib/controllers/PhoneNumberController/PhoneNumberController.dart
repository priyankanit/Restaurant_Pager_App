import 'package:get/get.dart';
import 'package:restuarant_pager_app/models/PhoneNumberModel/PhoneNumber.model.dart';

class PhoneNumberController extends GetxController {
  var phoneNumberModel =
      PhoneNumberModel(phoneNumber: "", countryCode: "+91").obs;

  var isButtonDisabled = true.obs;

  List<Map<String, String>> get countries => phoneNumberModel.value.countries;

  String get selectedCountryCode => phoneNumberModel.value.countryCode;

  void setSelectedCountryCode(String newCode) {
    phoneNumberModel.update((model) {
      model?.countryCode = newCode;
    });
  }

  String? validate() {
    if (!phoneNumberModel.value.isPhoneNumberValid()) {
      return "Invalid Phone Number";
    }
    return null;
  }

  void updatePhoneNumber(String number) {
    phoneNumberModel.update((model) {
      model?.phoneNumber = number;
      isButtonDisabled.value = !(model?.isPhoneNumberValid() ?? false);
    });
  }

  void clearPhoneNumber() {
    phoneNumberModel.update((model) {
      model?.phoneNumber = "";
      isButtonDisabled.value = true;
    });
  }

  // Function to get formatted phone number
  String getFormattedPhoneNumber() {
    return phoneNumberModel.value.getFormattedPhoneNumber();
  }
}
