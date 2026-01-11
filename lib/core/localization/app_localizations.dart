import 'dart:ui';

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static const supportedLocales = [
    Locale('en'),
    Locale('ru'),
  ];

  static AppLocalizations of(Locale locale) {
    return AppLocalizations(locale);
  }

  String get appTitle {
    switch (locale.languageCode) {
      case 'ru':
        return 'Homebody Challenge';
      default:
        return 'Homebody Challenge';
    }
  }

  String get home {
    return locale.languageCode == 'ru' ? 'Главная' : 'Home';
  }

  String get active {
    return locale.languageCode == 'ru' ? 'Активные' : 'Active';
  }

  String get create {
    return locale.languageCode == 'ru' ? 'Создать' : 'Create';
  }

  String get profile {
    return locale.languageCode == 'ru' ? 'Профиль' : 'Profile';
  }
}
