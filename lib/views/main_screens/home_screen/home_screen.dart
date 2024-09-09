import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:restuarant_pager_app/controllers/pages_controller/home_controller/home_controller.dart';

class HomeScreen extends GetView<HomeController> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("${controller.title}"),
      ),
    );
  }
}
