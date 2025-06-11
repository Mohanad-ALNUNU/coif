import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'providers/language_provider.dart';
import 'providers/salon_provider.dart';
import 'screens/home_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LanguageProvider()),
      ],
      child: Consumer<LanguageProvider>(
        builder: (context, languageProvider, child) {
          return MaterialApp(
            title: 'Tifawin',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
            ),
            locale: Locale(languageProvider.currentLocale),
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: AppLocalizations.supportedLocales,
            home: MultiProvider(
              providers: [
                ChangeNotifierProvider(
                  create: (context) {
                    final provider = SalonProvider();
                    // Initialize after the MaterialApp is created
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      provider.loadDummyData(context);
                    });
                    return provider;
                  },
                ),
              ],
              child: const HomeScreen(),
            ),
          );
        },
      ),
    );
  }
}
