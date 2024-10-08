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
  int? get id => currentUser.value.id;

  void setUser(UserModel user) {
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
    int? id,
  }) {
    // Create a new UserModel instance with updated values
    UserModel updatedUser = currentUser.value.copyWith(
      uid: uid ?? currentUser.value.uid,
      name: name ?? currentUser.value.name,
      dateOfBirth: dateOfBirth ?? currentUser.value.dateOfBirth,
      gender: gender ?? currentUser.value.gender,
      phone: phone ?? currentUser.value.phone,
      email: email ?? currentUser.value.email,
      profilePic: profilePic ?? currentUser.value.profilePic,
      whatsAppMessagePreference: whatsAppMessagePreference ?? currentUser.value.whatsAppMessagePreference,
      id: id ?? currentUser.value.id,
    );

    // Update the observable
    currentUser.value = updatedUser;
  }

  void clearUserData() {
    currentUser.value = UserModel(); // Reset to a new UserModel instance
  }
}
