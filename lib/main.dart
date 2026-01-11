import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'app.dart';
import 'core/theme/theme_local_storage.dart';
import 'core/theme/theme_notifier.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  // Загрузка сохраненной темы
  final storedTheme = await ThemeLocalStorage().load();
  themeModeNotifier.value = storedTheme;

  runApp(const HomebodyApp());
}
