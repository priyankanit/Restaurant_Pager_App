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
    try {
      final ResponseModel response = await authMethods.getUserData();
      if (response.message == "user not found") {
        Get.offAllNamed('/boarding_screens');
      } else if (response.message == "success") {
        Get.offAllNamed('/dashboard');
      } else {
        Get.offAllNamed('/login');
      }
    } catch (e) {
      debugPrint('Error initializing app: $e');
      Get.offAllNamed('/login');
    }
  }
}
