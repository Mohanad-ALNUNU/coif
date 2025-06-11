import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoyaltyScreen extends StatelessWidget {
  const LoyaltyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildLoyaltyHeader(context),
            _buildCurrentOffers(context),
            _buildLoyaltyHistory(context),
          ],
        ),
      ),
    );
  }

  Widget _buildLoyaltyHeader(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: Column(
        children: [
          Text(
            l10n.loyaltyPoints,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.star,
                  color: Theme.of(context).colorScheme.primary,
                  size: 30,
                ),
                const SizedBox(width: 10),
                const Text(
                  '750',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  ' ${l10n.points}',
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCurrentOffers(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.currentOffers,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 15),
          _buildOfferCard(
            context: context,
            title: l10n.hairTreatmentOffer,
            points: 500,
            validUntil: l10n.validUntil('June 1, 2025'),
            color: Colors.pink.shade100,
          ),
          _buildOfferCard(
            context: context,
            title: l10n.freeManicureOffer,
            points: 750,
            validUntil: l10n.validUntil('May 30, 2025'),
            color: Colors.purple.shade100,
          ),
          _buildOfferCard(
            context: context,
            title: l10n.spaDayOffer,
            points: 1000,
            validUntil: l10n.validUntil('May 25, 2025'),
            color: Colors.blue.shade100,
          ),
        ],
      ),
    );
  }

  Widget _buildOfferCard({
    required BuildContext context,
    required String title,
    required int points,
    required String validUntil,
    required Color color,
  }) {
    final l10n = AppLocalizations.of(context)!;
    return Card(
      margin: const EdgeInsets.only(bottom: 15),
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: color.withOpacity(0.3),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '$points ${l10n.points}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Implement redemption logic
                  },
                  child: Text(l10n.redeem),
                ),
              ],
            ),
            const SizedBox(height: 5),
            Text(
              validUntil,
              style: TextStyle(
                color: Colors.grey.withOpacity(0.8),
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoyaltyHistory(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.pointsHistory,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 15),
          _buildHistoryItem(
            context: context,
            title: l10n.hairColoringService,
            points: '+50',
            date: 'May 10, 2025',
          ),
          _buildHistoryItem(
            context: context,
            title: l10n.spaTreatment,
            points: '+75',
            date: 'May 5, 2025',
          ),
          _buildHistoryItem(
            context: context,
            title: l10n.manicureRedemption,
            points: '-500',
            date: 'April 28, 2025',
            isRedemption: true,
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryItem({
    required BuildContext context,
    required String title,
    required String points,
    required String date,
    bool isRedemption = false,
  }) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(title),
      subtitle: Text(date),
      trailing: Text(
        points,
        style: TextStyle(
          color: isRedemption ? Colors.red : Colors.green,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
