class User {
  final String id;
  final String name;
  final String email;
  final String phoneNumber;
  final int loyaltyPoints;
  final List<String> favoritesSalons;
  final List<Appointment> appointmentHistory;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.loyaltyPoints,
    required this.favoritesSalons,
    required this.appointmentHistory,
  });
}

class Appointment {
  final String id;
  final String salonId;
  final String salonName;
  final DateTime date;
  final List<String> services;
  final double totalAmount;
  final String status;

  Appointment({
    required this.id,
    required this.salonId,
    required this.salonName,
    required this.date,
    required this.services,
    required this.totalAmount,
    required this.status,
  });
}
