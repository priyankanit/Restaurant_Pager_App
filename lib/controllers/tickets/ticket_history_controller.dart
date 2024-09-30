import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:restuarant_pager_app/models/tickets/ticket_model.dart';

class TicketController extends GetxController {
  var tickets = <Ticket>[].obs; // Observable list of tickets.
  var isLoading = true.obs;

  @override
  void onInit() {
    fetchTickets(); // Fetch tickets when the controller is initialized.
    super.onInit();
  }

  Future<void> fetchTickets() async {
    isLoading.value = true; // Set loading state to true.
    try {
      print('start fetching tickets');
      final response = await http.get(Uri.parse('http://10.0.2.2:8000/ticket/?format=json'));
      print('end fetching tickets');
      if (response.statusCode == 200) {
        print('inside if');
        print(response.body);
        List jsonResponse = json.decode(response.body);
        tickets.value = jsonResponse.map((ticket) => Ticket.fromJson(ticket)).toList();
      } else {
        // Handle the error response
        Get.snackbar('Error', 'Failed to load tickets');
      }
    } catch (e) {
      // Handle network error
      Get.snackbar('Error', 'An error occurred: $e');
    } finally {
      isLoading.value = false; // Set loading state to false.
    }
  }
}
