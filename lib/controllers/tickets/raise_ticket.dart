import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restuarant_pager_app/models/tickets/raise_ticket.dart';
import 'package:http/http.dart' as http;
import '../../utils/upload_to_firebase.dart';

class IssueTicketController {
  late final String ticketId;
  final url = Uri.parse('http://10.0.2.2:8000/ticket/?format=json');
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  IssueTicketModel ticket = IssueTicketModel(
    firstName: '',
    lastName: '',
    email: '',
    description: '',
    attachFile: ''
  );
  File? attachedFile; // For storing the picked image file

  Future<bool> submitTicket(BuildContext context) async {
    print('Submitting ticket without validation');
    // Save the form state directly without validation
    formKey.currentState?.save();
    String? fileUrl;

    // Handle file upload
    if (attachedFile != null) {
      fileUrl = await uploadFileToFirebase(attachedFile!);
      if (fileUrl != null) {
        ticket.attachFile = fileUrl; // Assign file URL if available
      } else {
        // Handle file upload failure
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('File upload failed'), backgroundColor: Colors.red),
        );
        return false;
      }
    }

    // Print request body for debugging
    print("Sending request to $url with body: ${jsonEncode({
      'first_name': ticket.firstName,
      'last_name': ticket.lastName,
      'email': ticket.email,
      'select_order': ticket.selectedOrder,
      'description': ticket.description,
      'attach_file': ticket.attachFile,
    })}");

    // Make POST request
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

    // Print response for debugging
    print("Response status: ${response.statusCode}");
    print("Response body: ${response.body}");

    if (response.statusCode == 201) {
      // Assuming ticket submission was successful
      // Now, search for the ticket ID using the provided details
      final success = await findTicketId(context);
      return success;
    } else {
      // Handle error
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Ticket submission failed'), backgroundColor: Colors.red),
      );
      return false;
    }
  }

  Future<bool> findTicketId(BuildContext context) async {
    // Construct a query to search for the ticket using your criteria
    final searchUrl = Uri.parse('http://10.0.2.2:8000/ticket/?first_name=${ticket.firstName}&last_name=${ticket.lastName}&email=${ticket.email}&description=${ticket.description}');

    final response = await http.get(searchUrl);

    // Print search response for debugging
    print("Search response status: ${response.statusCode}");
    print("Search response body: ${response.body}");

    if (response.statusCode == 200) {
      final List<dynamic> tickets = jsonDecode(response.body);
      // Assuming tickets is a list and you're interested in the first one
      if (tickets.isNotEmpty) {
        ticketId = tickets[0]['id'].toString(); // Change this according to your response structure
        return true;
      } else {
        // No tickets found
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No ticket found after submission'), backgroundColor: Colors.red),
        );
        return false;
      }
    } else {
      // Handle search error
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to retrieve ticket ID'), backgroundColor: Colors.red),
      );
      return false;
    }
  }
}
