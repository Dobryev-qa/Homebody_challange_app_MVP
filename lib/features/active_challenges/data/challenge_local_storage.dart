import 'package:hive/hive.dart';
import '../../../core/constants/hive_boxes.dart';
import '../../../core/constants/challenge_keys.dart';
import '../domain/challenge.dart';

class ChallengeLocalStorage {
  Future<List<Challenge>> loadActiveChallenges() async {
    final box = await Hive.openBox(HiveBoxes.userBox);
    final list =
        box.get(ChallengeKeys.activeChallenges, defaultValue: []);

    final challenges = (list as List)
        .map((e) => Challenge.fromMap(Map<String, dynamic>.from(e)))
        .toList();
    
    print('📂 Loaded ${challenges.length} active challenges from storage');
    return challenges;
  }

  Future<void> saveActiveChallenges(List<Challenge> challenges) async {
    final box = await Hive.openBox(HiveBoxes.userBox);
    await box.put(
      ChallengeKeys.activeChallenges,
      challenges.map((c) => c.toMap()).toList(),
    );
    print('💾 Saved ${challenges.length} challenges to storage');
  }

  Future<void> activateChallenge(Challenge challenge) async {
    print('🎯 Activating challenge: ${challenge.id}');
    final list = await loadActiveChallenges();

    final exists = list.any((c) => c.id == challenge.id);
    if (exists) {
      print('⚠️ Challenge ${challenge.id} already exists in storage');
      return;
    }

    list.add(challenge);
    await saveActiveChallenges(list);
    print('✅ Challenge ${challenge.id} added to active list');
  }

  Future<Challenge?> loadById(String id) async {
    final list = await loadActiveChallenges();
    try {
      return list.firstWhere((c) => c.id == id);
    } catch (_) {
      return null;
    }
  }

  Future<void> updateChallenge(Challenge updated) async {
    final list = await loadActiveChallenges();

    final index = list.indexWhere((c) => c.id == updated.id);
    if (index == -1) return;

    list[index] = updated;
    await saveActiveChallenges(list);
  }

  bool canActToday(Challenge challenge) {
    if (challenge.lastActionDate == null) return true;

    final now = DateTime.now();
    final d = challenge.lastActionDate!;
    return !(d.year == now.year &&
        d.month == now.month &&
        d.day == now.day);
  }

  Future<Challenge?> completeDay(String id) async {
    final challenge = await loadById(id);
    if (challenge == null) return null;

    if (challenge.isCompleted) return challenge;
    if (!canActToday(challenge)) return challenge;
    if (challenge.currentDay >= challenge.totalDays) return challenge;

    final updated = challenge.copyWith(
      currentDay: challenge.currentDay + 1,
      lastActionDate: DateTime.now(),
    );

    await updateChallenge(updated);
    return updated;
  }

  Future<Challenge?> skipDay(String id) async {
    return completeDay(id);
  }
}
