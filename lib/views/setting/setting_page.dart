import 'package:flutter/material.dart';

import '../../widgets/alert_dialog.dart';
import 'components/setting_group.dart';
import 'components/setting_tile.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Center(
            child: Text(
          'Settings',
          style: TextStyle(fontWeight: FontWeight.w500),
        )),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SettingsGroup(
              settingsGroupTitle: 'Account',
              items: [
                SettingTile(
                  title: 'Profile',
                  icon: Icons.person_outline_rounded,
                  // onTap: () => Get.to(() => ProfilePage()),
                ),
                SettingTile(
                  title: 'Password',
                  icon: Icons.lock_outline_rounded,
                  // onTap: () => Get.to(() => PasswordPage()),
                ),
                SettingTile(
                  title: 'Notification',
                  icon: Icons.notifications_none_rounded,
                  // onTap: () => Get.to(() => NotificationPage()),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const SettingsGroup(
              settingsGroupTitle: 'More',
              items: [
                SettingTile(
                  title: 'Rate & Review',
                  icon: Icons.star_border_rounded,
                  // onTap: () => Get.to(() => RateReviewPage()),
                ),
                SettingTile(
                  title: 'Help',
                  icon: Icons.help_outline_rounded,
                  // onTap: () => Get.to(() => HelpPage()),
                ),
                SettingTile(
                  title: 'Raise Ticket',
                  icon: Icons.airplane_ticket_outlined,
                  // onTap: () => Get.to(() => RaiseTicketPage()),
                ),
              ],
            ),
            const Spacer(),
            Center(
              child: TextButton(
                onPressed: () {
                  // Handle logout action
                  //show a aleart dialog box for confrmation
                  showCustomAlertDialog(context);
                },
                child: const Text('Log Out',
                    style: TextStyle(fontSize: 14, color: Colors.grey)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// To show the dialog
void showCustomAlertDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return ReusableAlertDialog(
        title: 'Logout',
        icon: Icons.logout,
        subtitle: 'Are you sure you want to log out?',
        onYesPressed: () {
          // Handle Yes button action
          Navigator.of(context).pop();
        },
        onNoPressed: () {
          // Handle No button action
          Navigator.of(context).pop();
        },
        yesButtonText: 'Yes',
        noButtonText: 'No',
        backgroundColor:
            Colors.orange[200], // Custom background color if needed
      );
    },
  );
}
