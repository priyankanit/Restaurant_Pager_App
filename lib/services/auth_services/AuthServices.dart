import 'package:restuarant_pager_app/models/ResponseModel/ResponseModel.dart';
import 'package:restuarant_pager_app/models/UserModel/UserModel.dart';
import 'package:http/http.dart' as http;

class AuthServices {
  final host = "http://127.0.0.1:8000";

  Future<ResponseModel> signUpUser(UserModel userData) async {
    String res = "some error occurred";
    final uri = Uri.parse("$host/request_registration_user/");
    try {
      final response = await http.post(
        uri,
        headers: {"Content-Type": "application/json"},
        body: userData.toJson(),
      );
      // handle different cases
      switch(response.statusCode){

        case 200:
        res = "success";
        break;

        default:
        res = response.body;
        break;
      }
    } catch (error) {
      res = error.toString();
    }
    return ResponseModel(message: res);
  }
}
