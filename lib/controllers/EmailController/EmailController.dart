import 'package:get/get.dart';
import 'package:restuarant_pager_app/models/EmailModel/Email.model.dart';

class EmailController extends GetxController {
  var emailModel = EmailModel().obs;

  var isButtonDisabled = true.obs;

  String? get emailAddress => emailModel.value.emailAddress;

  void updateEmailAddress(String email) {
    emailModel.update((model) {
      model?.emailAddress = email;
      isButtonDisabled.value = !(model?.isEmailValid() ?? false);
    });
  }
  bool validate(){
    return emailModel.value.isEmailValid();
  }
  void clearEmailAddress() {
    emailModel.update((model) {
      model?.emailAddress = "";
      isButtonDisabled.value = true;
    });
  }
}
