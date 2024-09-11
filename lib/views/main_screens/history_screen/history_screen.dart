import 'package:flutter/material.dart';
import "package:get/get.dart";
import 'package:restuarant_pager_app/controllers/pages_controller/history_controller/history_controller.dart';

class HistoryScreen extends GetView<HistoryController> {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Text(controller.title),
        ),
      ),
    );
  }
}
