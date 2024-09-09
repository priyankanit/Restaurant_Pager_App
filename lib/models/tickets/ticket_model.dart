class TicketModel {
  final String id;
  final String description;
  final String status; // "Open" or "Resolved"

  TicketModel({
    required this.id,
    required this.description,
    required this.status,
  });
}