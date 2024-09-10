// controllers/issue_ticket_controller.dart
import 'package:flutter/material.dart';
import 'package:restuarant_pager_app/models/tickets/raise_ticket.dart';

class IssueTicketController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  IssueTicketModel ticket = IssueTicketModel(
    firstName: '',
    lastName: '',
    email: '',
    description: '',
  );

  void submitTicket(BuildContext context) {
    if (formKey.currentState?.validate() ?? false) {
      formKey.currentState?.save();
      // Implement ticket submission logic here
      // e.g., send ticket to server, show confirmation, etc.
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Ticket submitted successfully')),
      );
    }
  }
}
