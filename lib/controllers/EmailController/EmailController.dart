import 'package:get/get.dart';
import 'package:restaurant_pager/models/EmailModel/Email.model.dart';

class EmailController extends GetxController {
  var emailModel = EmailModel(emailAddress: "").obs;

  var isButtonDisabled = true.obs;

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

  String getFormattedEmailAddress() {
    return emailModel.value.getFormattedEmailAddress();
  }
}
