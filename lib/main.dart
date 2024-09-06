import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'views/onboarding/boarding_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp( // GetMaterialApp is needed for GetX
      home: BoardingScreen(),
    );
  }
}