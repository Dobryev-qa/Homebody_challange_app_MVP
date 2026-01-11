import 'package:hive/hive.dart';
import '../constants/hive_boxes.dart';
import 'app_theme_mode.dart';

class ThemeLocalStorage {
  static const _key = 'theme_mode';

  Future<void> save(AppThemeMode mode) async {
    final box = await Hive.openBox(HiveBoxes.userBox);
    await box.put(_key, mode.name);
  }

  Future<AppThemeMode> load() async {
    final box = await Hive.openBox(HiveBoxes.userBox);
    final value = box.get(_key);

    return AppThemeMode.values.firstWhere(
      (e) => e.name == value,
      orElse: () => AppThemeMode.system,
    );
  }
}
