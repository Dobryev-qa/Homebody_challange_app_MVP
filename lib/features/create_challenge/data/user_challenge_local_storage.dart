import 'package:hive/hive.dart';
import '../../../core/constants/hive_boxes.dart';
import '../../../core/constants/user_challenge_keys.dart';
import '../domain/user_challenge.dart';

class UserChallengeLocalStorage {
  Future<List<UserChallenge>> loadChallenges() async {
    final box = await Hive.openBox(HiveBoxes.userBox);
    final list = box.get(UserChallengeKeys.userChallenges, defaultValue: []);

    final challenges = (list as List)
        .map((e) => UserChallenge.fromMap(Map<String, dynamic>.from(e)))
        .toList();
    
    print('📂 Loaded ${challenges.length} user challenges from storage');
    return challenges;
  }

  Future<void> addChallenge(UserChallenge challenge) async {
    print('💾 Adding user challenge: ${challenge.title}');
    final box = await Hive.openBox(HiveBoxes.userBox);
    final list = await loadChallenges();

    list.add(challenge);

    await box.put(
      UserChallengeKeys.userChallenges,
      list.map((e) => e.toMap()).toList(),
    );
    print('✅ User challenge saved. Total: ${list.length}');
  }
}
