import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restuarant_pager_app/constants/color_palette.dart';
import 'package:restuarant_pager_app/firebase/AuthMethods/AuthMethods.dart';
import 'package:restuarant_pager_app/routes/routes.dart';
import 'package:restuarant_pager_app/services/auth_services/AuthServices.dart';
import 'package:restuarant_pager_app/views/LoginView/loginPage.dart';
import 'package:restuarant_pager_app/views/pages/onboarding/boarding_screen.dart';
import 'package:restuarant_pager_app/views/splashScreen/splash_screen.dart';
import 'controllers/notification/notification_settrings_controller.dart';
import 'firebase/firebase_api.dart';
import 'firebase_options.dart';
import 'views/pages/dashboard/dashboard.dart';
import 'views/pages/dashboard/dashboard_binding.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  Get.put(NotificationSettingsController());
  await FirebaseApi().initNotifications();

  // Initialize necessary services
  Get.put(AuthMethods());
  Get.put(AuthServices());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "Restaurant Pager App",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: backgroundColor,
        textTheme: GoogleFonts.interTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      home: const SplashScreen(), 
      getPages: AppRoutes.routes,
    );
  }
}


