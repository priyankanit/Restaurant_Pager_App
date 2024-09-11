class IssueTicketModel {
  String firstName;
  String lastName;
  String email;
  String? selectedOrder;
  String? filePath;
  String description;

  IssueTicketModel({
    required this.firstName,
    required this.lastName,
    required this.email,
    this.selectedOrder,
    this.filePath,
    required this.description,
  });
}