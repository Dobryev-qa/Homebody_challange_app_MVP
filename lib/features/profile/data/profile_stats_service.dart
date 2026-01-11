import 'package:hive/hive.dart';
import '../../../core/constants/hive_boxes.dart';
import '../../../core/constants/challenge_keys.dart';
import '../../active_challenges/domain/challenge.dart';
import '../domain/profile_stats.dart';

class ProfileStatsService {
  Future<ProfileStats> calculate() async {
    final box = await Hive.openBox(HiveBoxes.userBox);
    final list =
        box.get(ChallengeKeys.activeChallenges, defaultValue: []);

    final challenges = (list as List)
        .map((e) => Challenge.fromMap(Map<String, dynamic>.from(e)))
        .toList();

    final completed =
        challenges.where((c) => c.isCompleted).length;

    // --- streak logic ---
    final dates = challenges
        .where((c) => c.lastActionDate != null)
        .map((c) => c.lastActionDate!)
        .toList()
      ..sort((a, b) => b.compareTo(a));

    int currentStreak = 0;
    int bestStreak = 0;

    DateTime? prev;

    for (final d in dates) {
      if (prev == null) {
        currentStreak = 1;
        bestStreak = 1;
      } else {
        final diff = prev.difference(d).inDays;
        if (diff == 1) {
          currentStreak++;
          if (currentStreak > bestStreak) {
            bestStreak = currentStreak;
          }
        } else {
          break;
        }
      }
      prev = d;
    }

    return ProfileStats(
      completedChallenges: completed,
      currentStreak: currentStreak,
      bestStreak: bestStreak,
    );
  }
}
