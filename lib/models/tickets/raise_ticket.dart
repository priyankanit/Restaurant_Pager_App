class IssueTicketModel {
  String firstName;
  String lastName;
  String email;
  String? selectedOrder;
  String? attachFile;
  String description;

  IssueTicketModel({
    required this.firstName,
    required this.lastName,
    required this.email,
    this.selectedOrder,
    required this.description,
    required this.attachFile,
  });
}