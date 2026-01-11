import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'core/localization/app_localizations.dart';
import 'core/theme/app_theme.dart';
import 'features/splash/presentation/splash_page.dart';

class HomebodyApp extends StatelessWidget {
  const HomebodyApp({super.key});

  Locale _resolveLocale(Locale? deviceLocale) {
    if (deviceLocale == null) {
      return const Locale('en');
    }

    if (deviceLocale.languageCode == 'ru') {
      return const Locale('ru');
    }

    return const Locale('en');
  }

  @override
  Widget build(BuildContext context) {
    final systemLocale = _resolveLocale(PlatformDispatcher.instance.locale);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Homebody Challenge',
      locale: systemLocale,
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      theme: AppTheme.darkTheme,
      themeMode: ThemeMode.dark,
      home: const SplashPage(),
    );
  }
}
