import 'package:flutter/material.dart';

import '../../models/notification/notification_model.dart';
import 'package:intl/intl.dart';

class NotificationView extends StatelessWidget {
  final List<NotificationModel> notificationsList;

  const NotificationView({super.key, required this.notificationsList});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
      ),
      body: ListView.builder(
        itemCount: notificationsList.length,
        itemBuilder: (context, index) {
          final notification = notificationsList[index];
          return ListTile(
            title: Text(notification.notificationAbout),
            subtitle: Text(notification.notificationMessage),
            trailing: Text(
              DateFormat('yyyy-MM-dd – kk:mm').format(notification.notificationTime),
            ),
          );
        },
      ),
    );
  }
}
