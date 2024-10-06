import 'package:firebase_auth/firebase_'
    ''
    'auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restuarant_pager_app/constants/color_palette.dart';
import 'package:restuarant_pager_app/firebase/AuthMethods/AuthMethods.dart';
import 'package:restuarant_pager_app/routes/routes.dart';
import 'package:restuarant_pager_app/views/splashScreen/splash_screen.dart';
import 'package:restuarant_pager_app/views/tickets/raise_ticket.dart';
import 'package:restuarant_pager_app/views/tickets/ticket_history.dart';
import 'controllers/notification/notification_settrings_controller.dart';
import 'firebase/firebase_api.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  Get.put(NotificationSettingsController());
  await FirebaseApi().initNotifications();
  FirebaseAuth.instance.setLanguageCode('en'); // Set it to the desired locale

  // Initialize necessary services
  Get.put(AuthMethods());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: GetMaterialApp(
        title: "Restaurant Pager App",
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: backgroundColor,
          textTheme: GoogleFonts.interTextTheme(
            Theme.of(context).textTheme,
          ),
        ),
        home: SubmitIssuePage(),
        getPages: AppRoutes.routes,
      ),
    );
  }
}
