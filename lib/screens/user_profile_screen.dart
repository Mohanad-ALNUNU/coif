import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/language_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildProfileHeader(context),
            _buildProfileOptions(context),
            _buildAppointmentHistory(context),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader(BuildContext context) {
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
      child: SafeArea(
        child: Column(
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage(
                'assets/images/pexels-cottonbro-3993324.jpg',
              ),
            ),
            const SizedBox(height: 15),
            Text(
              l10n.userName,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              l10n.userEmail,
              style: TextStyle(
                color: Colors.white.withAlpha(204),
                fontSize: 16,
              ),
            ),
            Text(
              'Last updated: ${DateTime.now().toString().substring(0, 10)}',
              style: TextStyle(
                color: Colors.grey.withAlpha(204),
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileOptions(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.settings,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 15),
          _buildSettingTile(
            icon: Icons.person_outline,
            title: l10n.personalInfo,
            onTap: () {
              // Navigate to edit profile
            },
          ),
          _buildSettingTile(
            icon: Icons.notifications_outlined,
            title: l10n.notifications,
            onTap: () {
              // Navigate to notifications settings
            },
          ),
          _buildLanguageTile(context),
          _buildSettingTile(
            icon: Icons.help_outline,
            title: l10n.helpSupport,
            onTap: () {
              // Navigate to help section
            },
          ),
          _buildSettingTile(
            icon: Icons.exit_to_app,
            title: l10n.logout,
            onTap: () {
              // Handle logout
            },
          ),
        ],
      ),
    );
  }

  Widget _buildLanguageTile(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final languageProvider = Provider.of<LanguageProvider>(context);
    final selectedLanguage = LanguageProvider.supportedLanguages.firstWhere(
      (lang) => lang['code'] == languageProvider.currentLocale,
    );

    return ListTile(
      leading: const Icon(Icons.language_outlined),
      title: Text(l10n.language),
      subtitle: Text(selectedLanguage['name']!),
      trailing: const Icon(Icons.chevron_right),
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(l10n.language),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: LanguageProvider.supportedLanguages.map((language) {
                return ListTile(
                  title: Text(language['name']!),
                  trailing: language['code'] == languageProvider.currentLocale
                      ? const Icon(Icons.check, color: Colors.green)
                      : null,
                  onTap: () {
                    languageProvider
                        .setLocale(language['code']!);
                  },
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }

  Widget _buildSettingTile({
    required IconData icon,
    required String title,
    String? subtitle,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      subtitle: subtitle != null ? Text(subtitle) : null,
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }

  Widget _buildAppointmentHistory(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.recentAppointments,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 15),
          _buildAppointmentTile(
            context: context,
            salonName: l10n.salonGlamourBeauty,
            service: l10n.hairColoring,
            date: l10n.date1,
            status: l10n.completed,
            statusColor: Colors.green,
          ),
          _buildAppointmentTile(
            context: context,
            salonName: l10n.salonZenSpa,
            service: l10n.fullBodyMassage,
            date: l10n.date2,
            status: l10n.completed,
            statusColor: Colors.green,
          ),
          _buildAppointmentTile(
            context: context,
            salonName: l10n.salonNailArt,
            service: l10n.manicurePedicure,
            date: l10n.date3,
            status: l10n.upcoming,
            statusColor: Colors.blue,
          ),
        ],
      ),
    );
  }

  Widget _buildAppointmentTile({
    required BuildContext context,
    required String salonName,
    required String service,
    required String date,
    required String status,
    required Color statusColor,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 15),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  salonName,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    status,
                    style: TextStyle(
                      color: statusColor,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              service,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              date,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
