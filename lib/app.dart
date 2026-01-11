import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'core/localization/app_localizations.dart';
import 'core/theme/theme_notifier.dart';
import 'core/theme/app_themes.dart';
import 'core/theme/app_theme_mode.dart';
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

  ThemeMode _mapThemeMode(AppThemeMode mode) {
    switch (mode) {
      case AppThemeMode.light:
        return ThemeMode.light;
      case AppThemeMode.dark:
        return ThemeMode.dark;
      case AppThemeMode.system:
      default:
        return ThemeMode.system;
    }
  }

  @override
  Widget build(BuildContext context) {
    final systemLocale = _resolveLocale(PlatformDispatcher.instance.locale);

    return ValueListenableBuilder<AppThemeMode>(
      valueListenable: themeModeNotifier,
      builder: (_, mode, __) {
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
          theme: AppThemes.lightTheme,
          darkTheme: AppThemes.darkTheme,
          themeMode: _mapThemeMode(mode),
          home: const SplashPage(),
        );
      },
    );
  }
}
