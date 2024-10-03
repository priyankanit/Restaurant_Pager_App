class Ticket {
  final int id;
  final String firstName;
  final String lastName;
  final String email;
  final String selectOrder;
  final String attachFile;
  final String description;
  final DateTime dateTime;
  final String status;

  Ticket({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.selectOrder,
    required this.attachFile,
    required this.description,
    required this.dateTime,
    required this.status,
  });

  factory Ticket.fromJson(Map<String, dynamic> json) {
    return Ticket(
      id: json['id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      email: json['email'],
      selectOrder: json['select_order'],
      attachFile: json['attach_file'],
      description: json['description'],
      dateTime: DateTime.parse(json['date_time']),
      status: json['status'],
    );
  }
}
