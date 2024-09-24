import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restuarant_pager_app/firebase/AuthMethods/AuthMethods.dart';
import 'package:restuarant_pager_app/models/ResponseModel/ResponseModel.dart';

class SplashScreenController extends GetxController {
  static const int seconds = 5;

  @override
  void onReady() {
    _initializeApp();
    super.onReady();
  }

  Future<void> _initializeApp() async {
    await Future.delayed(const Duration(seconds: seconds));

    final authMethods = Get.find<AuthMethods>();

    // Listen to auth state changes
    authMethods.authChanges.listen((user) async {
      if (user != null) {
        // If a user is signed in, fetch user data
        try {
          final ResponseModel response = await authMethods.getUserData();
          if (response.message == "success") {
            // User data found, navigate to dashboard
            Get.offAllNamed('/dashboard');
          } else {
            // Error retrieving user data, navigate to login
            Get.offAllNamed('/login');
          }
        } catch (e) {
          debugPrint('Error fetching user data: $e');
          Get.offAllNamed('/login');
        }
      } else {
        Get.offAllNamed('/boarding_screens');
      }
    });
  }
}
