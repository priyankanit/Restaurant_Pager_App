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

  void clearAll(){
    setUser('');
  }
}