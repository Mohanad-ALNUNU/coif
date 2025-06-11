import 'package:flutter/foundation.dart';
import 'package:faker/faker.dart';
import '../models/salon.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/widgets.dart';

class SalonProvider with ChangeNotifier {
  final List<Salon> _salons = [];
  String selectedFilter = 'all';
  String sortBy = 'distance';

  List<Salon> get salons {
    var filteredSalons = List<Salon>.from(_salons);
    if (selectedFilter != 'all') {
      filteredSalons = filteredSalons
          .where((salon) => salon.serviceTypes[selectedFilter] ?? false)
          .toList();
    }

    switch (sortBy) {
      case 'distance':
        filteredSalons.sort((a, b) => a.distance.compareTo(b.distance));
        break;
      case 'rating':
        filteredSalons.sort((a, b) => b.rating.compareTo(a.rating));
        break;
      case 'price':
        filteredSalons.sort((a, b) {
          double aAvgPrice = a.services.fold(0.0, (sum, service) => sum + service.price) / a.services.length;
          double bAvgPrice = b.services.fold(0.0, (sum, service) => sum + service.price) / b.services.length;
          return aAvgPrice.compareTo(bAvgPrice);
        });
        break;
    }

    return filteredSalons;
  }

  void setFilter(String filter) {
    selectedFilter = filter;
    notifyListeners();
  }

  void setSortBy(String newSortBy) {
    sortBy = newSortBy;
    notifyListeners();
  }

  void loadDummyData(BuildContext context) {
    final faker = Faker();
    final serviceTypes = ['hair', 'nails', 'skincare', 'makeup', 'spa'];
    final l10n = AppLocalizations.of(context)!;
    
    final localImages = [
      'assets/images/pexels-juliano-astc-1623739-12416650.jpg',
      'assets/images/pexels-zakaria-hanif-755378-28191473.jpg',
      'assets/images/pexels-toni-guy-pondicherry-404397363-18367694.jpg',
      'assets/images/pexels-noyami-170979394-19959538.jpg',
      'assets/images/pexels-reneterp-12774831.jpg',
      'assets/images/pexels-pixabay-36469.jpg',
      'assets/images/pexels-alipazani-3094065.jpg',
      'assets/images/pexels-amiresel-3912572.jpg',
      'assets/images/pexels-n-voitkevich-8467970.jpg',
      'assets/images/pexels-amiresel-4372511.jpg',
      'assets/images/pexels-rdne-7755461.jpg',
      'assets/images/pexels-cottonbro-3997391.jpg',
      'assets/images/pexels-cottonbro-3993324.jpg',
      'assets/images/pexels-cottonbro-3993449.jpg',
      'assets/images/pexels-john-tekeridis-21837-14256897.jpg',
      'assets/images/pexels-oleksandra-23349891.jpg',
      'assets/images/pexels-polina-tankilevitch-3738379.jpg',
      'assets/images/pexels-marvin-malmis-ponce-272683079-12891485.jpg',
      'assets/images/pexels-neomi-drewel-374578391-20593206.jpg',
      'assets/images/pexels-deni-priyo-3550015-10028672.jpg',
    ];
    
    final serviceNames = {
      'hair': [l10n.hairColoring],
      'nails': [l10n.manicurePedicure],
      'spa': [l10n.fullBodyMassage],
    };
    
    for (int i = 0; i < 20; i++) {
      final services = List.generate(
        5,
        (index) {
          final category = serviceTypes[faker.randomGenerator.integer(serviceTypes.length)];
          final serviceName = serviceNames[category]?.isNotEmpty == true
              ? serviceNames[category]![faker.randomGenerator.integer(serviceNames[category]!.length)]
              : faker.lorem.words(2).join(' ');
          
          return Service(
            name: serviceName,
            price: double.parse((50.0 + faker.randomGenerator.decimal() * 150).toStringAsFixed(2)),
            description: faker.lorem.sentence(),
            category: category,
          );
        },
      );

      final reviews = List.generate(
        faker.randomGenerator.integer(10) + 5,
        (index) => Review(
          userId: faker.guid.guid(),
          userName: faker.person.name(),
          rating: faker.randomGenerator.decimal() * 3 + 2, // Rating between 2 and 5
          comment: faker.lorem.sentence(),
          date: DateTime.now().subtract(Duration(days: faker.randomGenerator.integer(60))),
        ),
      );

      final salon = Salon(
        id: faker.guid.guid(),
        name: '${faker.company.name()} Beauty Salon',
        address: faker.address.streetAddress() + ', Casablanca',
        description: faker.lorem.sentences(3).join(' '),
        rating: double.parse((reviews.fold(0.0, (sum, review) => sum + review.rating) / reviews.length).toStringAsFixed(1)),
        images: [localImages[i]], // Use one image per salon
        services: services,
        reviews: reviews,
        distance: double.parse((0.5 + faker.randomGenerator.decimal() * 9.5).toStringAsFixed(1)),
        serviceTypes: Map.fromEntries(
          serviceTypes.map((type) => MapEntry(type, faker.randomGenerator.boolean())),
        ),
      );

      _salons.add(salon);
    }
    notifyListeners();
  }
}
