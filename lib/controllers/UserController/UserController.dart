import 'package:get/get.dart';
import 'package:restuarant_pager_app/models/PhoneNumberModel/PhoneNumber.model.dart';
import 'package:restuarant_pager_app/models/UserModel/UserModel.dart';

class UserController extends GetxController {
  Rx<UserModel> currentUser = UserModel().obs;

  UserModel get user => currentUser.value;
  String? get name => currentUser.value.name;
  String? get phoneNumber => currentUser.value.phone?.getE164FormattedPhoneNumber();
  String? get email => currentUser.value.email;
  String? get gender => currentUser.value.gender;
  String? get profilePic => currentUser.value.profilePic;
  String? get dateOfBirth => currentUser.value.dateOfBirth;
  String? get uid => currentUser.value.uid;

  void setUser(UserModel user){
    currentUser.value = user;
  }

  void updateUserDetails({
    String? uid,
    String? name,
    String? dateOfBirth,
    String? gender,
    PhoneNumberModel? phone,
    String? email,
    String? profilePic,
    bool? whatsAppMessagePreference,
  }) {
    currentUser.value.copyWith(
      uid: uid,
      name: name,
      dateOfBirth: dateOfBirth,
      gender: gender,
      phone: phone,
      email: email,
      profilePic: profilePic,
      whatsAppMessagePreference: whatsAppMessagePreference,
    );
  }

  void clearUserData(){
    currentUser.value = UserModel();
  }
}
