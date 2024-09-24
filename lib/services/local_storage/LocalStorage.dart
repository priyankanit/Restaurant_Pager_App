import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {

  void setUser(String uid)async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('x-auth-uid', uid);
  }

  Future<String?> getUid()async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? uid = preferences.getString('x-auth-uid');
    return uid;
  }

  void setPhoneNumber(String e164phoneNumber) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('x-auth-phone', e164phoneNumber);
  }

  Future<String?> getPhoneNumber() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString('x-auth-phone');
  }

  Future<bool> clearAll()async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.clear();
  }
}