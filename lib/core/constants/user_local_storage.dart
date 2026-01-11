import 'package:hive/hive.dart';
import 'hive_boxes.dart';
import 'user_keys.dart';

class UserLocalStorage {
  Future<String> getOrCreateOfflineId() async {
    final box = await Hive.openBox(HiveBoxes.userBox);

    final existingId = box.get(UserKeys.offlineId) as String?;
    if (existingId != null) {
      return existingId;
    }

    final newId = DateTime.now().millisecondsSinceEpoch.toString();
    await box.put(UserKeys.offlineId, newId);
    return newId;
  }
}
