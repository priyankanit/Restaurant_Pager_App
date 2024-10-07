import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:restuarant_pager_app/controllers/UserController/UserController.dart';
import 'package:restuarant_pager_app/firebase/AuthMethods/AuthMethods.dart';
import 'package:restuarant_pager_app/models/ResponseModel/ResponseModel.dart';
import 'package:restuarant_pager_app/views/LinkAccountPage/LinkAccountPage.dart';
import 'package:restuarant_pager_app/views/UpdateNumberDetails/UpdateNumberDetails.dart';

class SplashScreenController extends GetxController {
  @override
  void onReady() {
    _initializeApp();
    super.onReady();
  }

  Future<void> _initializeApp() async {
    await Future.delayed(const Duration(seconds: 5)); // will remove in production

    final authMethods = Get.find<AuthMethods>();
    final userController = Get.find<UserController>();

    // Listen to auth state changes
    authMethods.authChanges.listen((user) async {
      if (user != null) {
        // If a user is signed in, fetch user data
        try {
          final ResponseModel response = await authMethods.getUserData();
          if (response.message == "success") {
            // User data found, navigate to dashboard
            Get.offAllNamed('/dashboard');
          } else if(userController.phoneNumber != null){
            final res = authMethods.fetchUserAccounts();
             // if user's phone number is linked to multiple account
            if(res.message == 'success' && res.data.length > 1){
              Get.to(() => LinkAccountPage(accounts: res.data));
            }
            // Error retrieving user data, navigate to sign up page to get details and register at backend
            Get.offAllNamed('/signup');
          }else{
            Get.off(() => const UpdateNumberDetails(title: "Add Phone Number"));
          }
        } catch (error) {
          if (kDebugMode) debugPrint('Error fetching user data: $error');
          Get.offAllNamed('/login');
        }
      } else {
        if(authMethods.loggedIn){
          authMethods.loggedIn = false;
          // show login page after logging out
          Get.offAllNamed('/login');
        }else{
          // new user
          Get.offAllNamed('/boarding_screens');
        }
      }
    });
  }
}
