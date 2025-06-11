class Salon {
  final String id;
  final String name;
  final String address;
  final String description;
  final double rating;
  final List<String> images;
  final List<Service> services;
  final List<Review> reviews;
  final double distance;
  final Map<String, bool> serviceTypes;

  Salon({
    required this.id,
    required this.name,
    required this.address,
    required this.description,
    required this.rating,
    required this.images,
    required this.services,
    required this.reviews,
    required this.distance,
    required this.serviceTypes,
  });
}

class Service {
  final String name;
  final double price;
  final String description;
  final String category;

  Service({
    required this.name,
    required this.price,
    required this.description,
    required this.category,
  });
}

class Review {
  final String userId;
  final String userName;
  final double rating;
  final String comment;
  final DateTime date;

  Review({
    required this.userId,
    required this.userName,
    required this.rating,
    required this.comment,
    required this.date,
  });
}
