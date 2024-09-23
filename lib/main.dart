import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restuarant_pager_app/views/pages/dashboard/dashboard.dart';
import 'package:restuarant_pager_app/views/pages/dashboard/dashboard_binding.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp( // GetMaterialApp is needed for GetX
      debugShowCheckedModeBanner: false,
      title: "DemoAppOnGetx",
      initialRoute: '/',
      getPages: [
        GetPage(
          name: '/',
          page: () =>const Dashboard(),
          binding: DashboardBinding(),
        ),
        
      ],
    );
  }
}