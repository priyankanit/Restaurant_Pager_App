import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';

class QRCodeController extends GetxController {
  var qrCodeLink = ''.obs;
  var userName = ''.obs;
  var userId = 0.obs;

  Future<void> fetchCurrentUserDetails() async {
    final url = Uri.parse('http://10.0.2.2:8000/user/');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      List<dynamic> users = jsonDecode(response.body);
      final FirebaseAuth _auth = FirebaseAuth.instance;
      final User? currentUser = _auth.currentUser;

      if (currentUser != null) {
        final phone = currentUser.phoneNumber;

        for (var user in users) {
          if (user['phone_number'] == phone) {
            qrCodeLink.value = user['qr_code'];
            userName.value = user['username'];
            userId.value = user['id'];
            break;
          }
        }
      }
    } else {
      throw Exception('Failed to load users');
    }
  }
}
