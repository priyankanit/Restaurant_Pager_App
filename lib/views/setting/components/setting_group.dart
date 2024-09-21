import 'package:flutter/material.dart';

class SettingsGroup extends StatelessWidget {
  final String settingsGroupTitle;
  final List<Widget> items;

  const SettingsGroup({super.key, 
    required this.settingsGroupTitle,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          settingsGroupTitle,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        ...items,
      ],
    );
  }
}