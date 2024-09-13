import 'package:get/get.dart';
import 'package:restuarant_pager_app/models/PhoneNumberModel/PhoneNumber.model.dart';

class LoginController extends GetxController {
  var phoneNumberModel = PhoneNumberModel(phoneNumber: "", countryCode: "+91").obs;

  var isButtonDisabled = true.obs;

  void setCountryCode(String newCode) {
    phoneNumberModel.update((model) {
      model?.countryCode = newCode;
    });
  }

  void setPhoneNumber(String number) {
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
