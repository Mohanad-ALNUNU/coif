import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'salon_list_screen.dart';
import 'loyalty_screen.dart';
import 'user_profile_screen.dart';
import 'salon_dashboard_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    
    return Scaffold(
      appBar: AppBar(
        title: Text(_selectedIndex == 0 
          ? l10n.appTitle 
          : _selectedIndex == 1 
            ? l10n.recentAppointments 
            : l10n.settings),
        elevation: 0,
        actions: _selectedIndex == 0
            ? [
                IconButton(
                  icon: const Icon(Icons.business),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SalonDashboardScreen(),
                      ),
                    );
                  },
                ),
              ]
            : null,
      ),
      body: _buildBody(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.home),
            label: l10n.appTitle,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.card_giftcard),
            label: l10n.recentAppointments,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.person),
            label: l10n.settings,
          ),
        ],
      ),
    );
  }

  Widget _buildBody() {
    return IndexedStack(
      index: _selectedIndex,
      children: const [
        SalonListScreen(),
        LoyaltyScreen(),
        UserProfileScreen(),
      ],
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
