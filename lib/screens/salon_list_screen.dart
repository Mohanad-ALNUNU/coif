import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/salon_provider.dart';
import '../models/salon.dart';
import 'salon_profile_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SalonListScreen extends StatefulWidget {
  const SalonListScreen({super.key});

  @override
  State<SalonListScreen> createState() => _SalonListScreenState();
}

class _SalonListScreenState extends State<SalonListScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildSearchBar(context),
        _buildFilters(context),
        _buildSortOptions(context),
        Expanded(
          child: _buildSalonList(context),
        ),
      ],
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          hintText: l10n.searchHint,
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          filled: true,
          fillColor: Colors.grey[100],
        ),
        onChanged: (value) {
          setState(() {
            _searchQuery = value.toLowerCase();
          });
        },
      ),
    );
  }

  Widget _buildFilters(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          _FilterChip(
            label: l10n.all,
            filter: 'all',
          ),
          _FilterChip(
            label: l10n.hair,
            filter: 'hair',
          ),
          _FilterChip(
            label: l10n.nails,
            filter: 'nails',
          ),
          _FilterChip(
            label: l10n.skincare,
            filter: 'skincare',
          ),
          _FilterChip(
            label: l10n.makeup,
            filter: 'makeup',
          ),
          _FilterChip(
            label: l10n.spa,
            filter: 'spa',
          ),
        ],
      ),
    );
  }

  Widget _buildSortOptions(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Text(l10n.sortBy),
          const SizedBox(width: 8),
          DropdownButton<String>(
            value: Provider.of<SalonProvider>(context).sortBy,
            onChanged: (String? newValue) {
              if (newValue != null) {
                Provider.of<SalonProvider>(context, listen: false)
                    .setSortBy(newValue);
              }
            },
            items: [
              DropdownMenuItem(
                value: 'distance',
                child: Text(l10n.distance),
              ),
              DropdownMenuItem(
                value: 'rating',
                child: Text(l10n.rating),
              ),
              DropdownMenuItem(
                value: 'price',
                child: Text(l10n.price),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSalonList(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Consumer<SalonProvider>(
      builder: (context, salonProvider, child) {
        final salons = salonProvider.salons.where((salon) {
          final matchesSearch = _searchQuery.isEmpty ||
              salon.name.toLowerCase().contains(_searchQuery) ||
              salon.description.toLowerCase().contains(_searchQuery);
          return matchesSearch;
        }).toList();

        if (salons.isEmpty) {
          return Center(
            child: Text(l10n.noSalonsFound),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemCount: salons.length,
          itemBuilder: (context, index) {
            return _SalonCard(salon: salons[index]);
          },
        );
      },
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final String filter;

  const _FilterChip({
    required this.label,
    required this.filter,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: FilterChip(
        label: Text(label),
        selected: Provider.of<SalonProvider>(context).selectedFilter == filter,
        onSelected: (bool selected) {
          Provider.of<SalonProvider>(context, listen: false).setFilter(filter);
        },
      ),
    );
  }
}

class _SalonCard extends StatelessWidget {
  final Salon salon;

  const _SalonCard({required this.salon});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SalonProfileScreen(salon: salon),
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              salon.images[0],
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          salon.name,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ),
                      Row(
                        children: [
                          const Icon(Icons.star, color: Colors.amber),
                          Text(salon.rating.toString()),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.location_on, size: 16),
                      const SizedBox(width: 4),
                      Text(l10n.kmAway(salon.distance)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    salon.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
