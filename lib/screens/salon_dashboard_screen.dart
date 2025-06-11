import 'package:flutter/material.dart';
import 'package:faker/faker.dart' hide Color;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SalonDashboardScreen extends StatelessWidget {
  const SalonDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.salonDashboard),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildDashboardHeader(context),
            _buildAppointmentsSection(context),
            _buildServicesSection(context),
          ],
        ),
      ),
    );
  }

  Widget _buildDashboardHeader(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      padding: const EdgeInsets.all(20),
      color: Colors.grey[100],
      child: Row(
        children: [
          Expanded(
            child: _buildStatCard(
              title: l10n.todaysAppointments,
              value: '12',
              icon: Icons.calendar_today,
              color: Colors.blue.shade400,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: _buildStatCard(
              title: l10n.totalReviews,
              value: '248',
              icon: Icons.star,
              color: Colors.amber.shade400,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: _buildStatCard(
              title: l10n.averageRating,
              value: '4.8',
              icon: Icons.thumb_up,
              color: Colors.green.shade400,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withAlpha(204),
            spreadRadius: 1,
            blurRadius: 5,
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 30),
          const SizedBox(height: 10),
          Text(
            value,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey.withAlpha(204),
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppointmentsSection(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final faker = Faker();
    final appointments = List.generate(
      5,
      (index) => {
        'name': faker.person.name(),
        'service': faker.randomGenerator.element([
          l10n.haircutStyling,
          l10n.manicurePedicure,
          l10n.hairColoring,
          l10n.facialTreatments,
          l10n.fullBodyMassage,
        ]),
        'time': faker.date.time(),
      },
    );

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                l10n.todaysSchedule,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton(
                onPressed: () {
                  // Navigate to full schedule
                },
                child: Text(l10n.viewAll),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Text(
                l10n.contactSalonBooking,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          ...appointments.map((appointment) => Card(
                child: ListTile(
                  leading: const CircleAvatar(
                    child: Icon(Icons.person),
                  ),
                  title: Text(appointment['name'] as String),
                  subtitle: Text(appointment['service'] as String),
                  trailing: Text(appointment['time'] as String),
                ),
              )),
        ],
      ),
    );
  }

  Widget _buildServicesSection(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.servicesOverview,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 15),
          _buildServiceCard(
            context: context,
            serviceName: l10n.haircutStyling,
            bookings: 45,
            growth: 12,
          ),
          _buildServiceCard(
            context: context,
            serviceName: l10n.hairColoring,
            bookings: 32,
            growth: 8,
          ),
          _buildServiceCard(
            context: context,
            serviceName: l10n.manicurePedicure,
            bookings: 28,
            growth: -3,
          ),
          _buildServiceCard(
            context: context,
            serviceName: l10n.facialTreatments,
            bookings: 20,
            growth: 15,
          ),
        ],
      ),
    );
  }

  Widget _buildServiceCard({
    required BuildContext context,
    required String serviceName,
    required int bookings,
    required int growth,
  }) {
    final l10n = AppLocalizations.of(context)!;
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    serviceName,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    l10n.bookingsThisMonth(bookings),
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 4,
              ),
              decoration: BoxDecoration(
                color: growth >= 0 ? Colors.green[50] : Colors.red[50],
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                '${growth >= 0 ? '+' : ''}$growth%',
                style: TextStyle(
                  color: growth >= 0 ? Colors.green : Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
