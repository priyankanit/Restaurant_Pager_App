// views/widgets/ticket_item.dart
import 'package:flutter/material.dart';
import 'package:get/get_common/get_reset.dart';
import 'package:restuarant_pager_app/models/tickets/ticket_model.dart';
import 'package:restuarant_pager_app/views/EditProfileView/components/EditProfileNameField.dart';

class TicketItem extends StatelessWidget {
  final Ticket ticket;

  const TicketItem({required this.ticket});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 0,
      margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 18.0),
      child: Padding(
        padding: const EdgeInsets.all(12.0), // Adjust padding for overall content
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '#${ticket.id}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0, // Adjust font size for ticket ID
                  ),
                ),
                const SizedBox(height: 5.0), // Space between ID and description
                Text(
                  ticket.description,
                  style: const TextStyle(
                    fontSize: 14.0, // Adjust font size for description
                  ),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              decoration: BoxDecoration(
                color: ticket.status.toLowerCase() == "open" ? Colors.orange.shade100 : Colors.green.shade100,
                borderRadius: BorderRadius.circular(8.0), // Adjust border radius for pill-like shape
              ),
              child: Text(
                ticket.status,
                style: TextStyle(
                  color: ticket.status.toLowerCase() == "open" ? Colors.deepOrange : Colors.green,
                  fontWeight: FontWeight.bold,
                  fontSize: 14.0, // Adjust font size for status text
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
