// views/ticket_history_page.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restuarant_pager_app/controllers/tickets/ticket_history_controller.dart';
import 'package:restuarant_pager_app/widgets/ticket_history_card.dart';

import '../../controllers/notification/notification_settrings_controller.dart';
import '../notifaicatio/notifaication_view_page.dart';
import '../notifaicatio/notification_setting_page.dart';

class TicketHistoryPage extends StatelessWidget {
  final TicketController controller = Get.put(TicketController());
  final NotificationSettingsController settingsController =
      Get.find<NotificationSettingsController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xfff7f9fa),
        appBar: AppBar(
          backgroundColor: Color(0xfff7f9fa),
          title: Text(
            'Ticket history',
            style: TextStyle(fontWeight: FontWeight.w700),
          ),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Get.back(),
          ),
          actions: [
            //add settings page
            IconButton(
              icon: Icon(Icons.settings),
              onPressed: () {
                Get.to(() => SettingsPage());
              },
            ),
            IconButton(
              icon: Icon(Icons.notification_add),
              onPressed: () {
                //get.to NotificationView
                Get.to(NotificationView(
                  notificationsList: settingsController.notificationsList,
                ));
              },
            ),
          ],
        ),
        body: Obx(() {
          return ListView.builder(
            itemCount: controller.tickets.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  TicketItem(ticket: controller.tickets[index]),
                ],
              );
            },
          );
        }),
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.document_scanner_rounded),
              label: "",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.history),
              label: 'History',
            ),
          ],
          currentIndex: 0, // Set the current index as per your app flow
          onTap: (index) {},
        ),
      ),
    );
  }
}
