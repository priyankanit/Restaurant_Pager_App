import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controllers/notification/notification_settrings_controller.dart';
import 'firebase/firebase_api.dart';
import 'firebase_options.dart';
import 'views/pages/dashboard/dashboard.dart';
import 'views/pages/dashboard/dashboard_binding.dart';
import 'views/tickets/raise_ticket.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Get.put(NotificationSettingsController()); 
  await FirebaseApi().initNotifications();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "Restuarant Pager App",
      // home: SubmitIssuePage(),
      initialRoute: '/',
      getPages: [
        GetPage(
          name: '/',
          page: () => const Dashboard(),
          binding: DashboardBinding(),
        )
      ],
    );
  }
}
