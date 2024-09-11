import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:restuarant_pager_app/views/tickets/ticket_history.dart';

import 'controllers/notification/notification_settrings_controller.dart';
import 'firebase/firebase_api.dart';
import 'firebase_options.dart';

void main() async{
   WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Get.put(NotificationSettingsController()); // Initialize GetX controller
  await FirebaseApi().initNotifications();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp( // GetMaterialApp is needed for GetX
      home: TicketHistoryPage(),
    );
  }
}