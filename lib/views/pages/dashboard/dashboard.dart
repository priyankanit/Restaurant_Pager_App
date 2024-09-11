import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restuarant_pager_app/controllers/dashboard_controller/dashboard_controller.dart';
import 'package:restuarant_pager_app/views/main_screens/history_screen/history_screen.dart';
import 'package:restuarant_pager_app/views/main_screens/home_screen/home_screen.dart';
import 'package:restuarant_pager_app/widgets/custom_bottomNavbar.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(builder: (controller) {
      return Scaffold(
        body: IndexedStack(
          index: controller.tabIndex.value,
          children: const [
            HomeScreen(),
             HistoryScreen(),
          ],
        ),
        bottomNavigationBar: CustomBottomNavBar(
          selectedIndex: controller.tabIndex.value,
          onItemTapped: controller.changeTabIndex,
        ),
      );
    });
  }
}
