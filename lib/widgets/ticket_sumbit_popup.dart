import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../views/tickets/ticket_history.dart';

class TicketSubmitPopup extends StatelessWidget {
  final String ticketId;

  const TicketSubmitPopup({
    super.key,
    required this.ticketId,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Stack(
          children: [
            // Column for content, without Positioned
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Ticket ID display
                Text(
                  "#$ticketId",
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),

                // Confirmation message
                const Text(
                  "Will be solved within 12 hrs",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),

            // Close button positioned at the top right
            Positioned(
              right: 0,
              top: 0,
              child: GestureDetector(
                onTap: () {
                  Get.offAll(() => TicketHistoryPage());
                },
                child: CircleAvatar(
                  radius: 12,
                  backgroundColor: Colors.red[50],
                  child: const Icon(Icons.close, color: Colors.orangeAccent),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
