import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restuarant_pager_app/views/pages/dashboard/dashboard.dart';
import 'package:restuarant_pager_app/views/pages/dashboard/dashboard_binding.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp( // GetMaterialApp is needed for GetX
      title: "DemoAppOnGetx",
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