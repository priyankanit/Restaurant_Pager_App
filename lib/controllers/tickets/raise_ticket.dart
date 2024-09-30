import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:restuarant_pager_app/models/tickets/raise_ticket.dart';
import 'package:http/http.dart' as http;
import '../../utils/upload_to_firebase.dart';

class IssueTicketController {
  final url = Uri.parse('http://10.0.2.2:8000/ticket/?format=json');
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  IssueTicketModel ticket = IssueTicketModel(
    firstName: '',
    lastName: '',
    email: '',
    description: '',
    attachFile: '',
  );
  File? attachedFile;  // For storing the picked image file

  Future<bool> submitTicket(BuildContext context) async {
    print('Submitting ticket without validation');
    // Save the form state directly without validation
    formKey.currentState?.save();
    String? fileUrl;
    if (attachedFile != null) {
      fileUrl = await uploadFileToFirebase(attachedFile!);
      if (fileUrl != null) {
        ticket.attachFile = fileUrl;  // Assign file URL if available
      } else {
        // Handle file upload failure
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('File upload failed'), backgroundColor: Colors.red),
        );
        return false;
      }
    }
    print("Sending request to $url with body: ${jsonEncode({
      'first_name': ticket.firstName,
      'last_name': ticket.lastName,
      'email': ticket.email,
      'select_order': ticket.selectedOrder,
      'description': ticket.description,
      'attach_file': ticket.attachFile,
    })}");

    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'first_name': ticket.firstName,
        'last_name': ticket.lastName,
        'email': ticket.email,
        'select_order': ticket.selectedOrder,
        'description': ticket.description,
        'attach_file': ticket.attachFile,
      }),
    );

    print("Response status: ${response.statusCode}");
    print("Response body: ${response.body}");

    if (response.statusCode == 201) {
      // Handle success
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Ticket submitted successfully')),
      );
      return true;
    } else {
      // Handle error
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Ticket submission failed'), backgroundColor: Colors.red),
      );
      return false;
    }
  }
}
