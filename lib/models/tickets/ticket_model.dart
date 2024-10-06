class Ticket {
  final String id;
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
      id: json['id'].toString(),  // Ensure id is a string
      firstName: json['first_name'] as String? ?? '', // Use null-aware operator if needed
      lastName: json['last_name'] as String? ?? '',
      email: json['email'] as String? ?? '',
      selectOrder: json['select_order']?.toString() ?? '',  // Convert to string
      attachFile: json['attach_file'] as String? ?? '',
      description: json['description'] as String? ?? '',
      dateTime: DateTime.parse(json['date_time']),
      status: json['status'] as String? ?? 'Open',  // Ensure status is a string
    );
  }

}
