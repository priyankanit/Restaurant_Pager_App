import 'package:get/get.dart';
import 'package:restuarant_pager_app/models/tickets/ticket_model.dart';

class TicketHistoryController extends GetxController {
  var tickets = <TicketModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    // Fetch or generate your ticket data here
    tickets.addAll([
      TicketModel(id: "#12347", description: "Link not working", status: "Open"),
      TicketModel(id: "#12348", description: "Request for payout", status: "Open"),
      TicketModel(id: "#12349", description: "Unable to login", status: "Open"),
      TicketModel(id: "#12345", description: "Issue with payment", status: "Resolved"),
      TicketModel(id: "#12346", description: "Request for payout", status: "Resolved"),
    ]);
  }
}
