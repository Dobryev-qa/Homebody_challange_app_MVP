import 'package:flutter/material.dart';
import '../data/challenge_local_storage.dart';
import '../domain/challenge.dart';

class ActiveChallengeDetailPage extends StatefulWidget {
  final String challengeId;

  const ActiveChallengeDetailPage({
    super.key,
    required this.challengeId,
  });

  @override
  State<ActiveChallengeDetailPage> createState() =>
      _ActiveChallengeDetailPageState();
}

class _ActiveChallengeDetailPageState
    extends State<ActiveChallengeDetailPage> {
  final _storage = ChallengeLocalStorage();
  Challenge? _challenge;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final c = await _storage.loadById(widget.challengeId);
    setState(() {
      _challenge = c;
    });
  }

  Future<void> _complete() async {
    final updated =
        await _storage.completeDay(widget.challengeId);
    setState(() {
      _challenge = updated;
    });
  }

  Future<void> _skip() async {
    final updated =
        await _storage.skipDay(widget.challengeId);
    setState(() {
      _challenge = updated;
    });
  }

  int _getRepsToday(Challenge challenge) {
    final repsToday = challenge.increasing == true
        ? (challenge.reps ?? 10) + challenge.currentDay - 1
        : (challenge.reps ?? 10);
    return repsToday;
  }

  @override
  Widget build(BuildContext context) {
    final challenge = _challenge;

    if (challenge == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (challenge.isCompleted) {
      return Scaffold(
        appBar: AppBar(title: Text(challenge.title)),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.emoji_events, size: 64, color: Colors.amber),
              SizedBox(height: 16),
              Text(
                'Challenge completed 🎉',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'Great job! You finished this challenge.',
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    }

    final canActToday =
      !challenge.isCompleted && _storage.canActToday(challenge);

    return Scaffold(
      appBar: AppBar(title: Text(challenge.title)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Today's workout block
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Today\'s workout',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                '${challenge.sets ?? 3} × ${_getRepsToday(challenge)} ${challenge.exercise ?? 'exercise'}',
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 24),
          _Calendar(
            totalDays: challenge.totalDays,
            currentDay: challenge.currentDay,
          ),
          const SizedBox(height: 24),
          _Progress(
            currentDay: challenge.currentDay,
            totalDays: challenge.totalDays,
          ),
          const SizedBox(height: 24),
          _Actions(
            disabled: !canActToday,
            onComplete: _complete,
            onSkip: _skip,
          ),
        ],
      ),
    );
  }
}

/* ===== reused UI blocks ===== */

class _Calendar extends StatelessWidget {
  final int totalDays;
  final int currentDay;

  const _Calendar({
    required this.totalDays,
    required this.currentDay,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: totalDays,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
      ),
      itemBuilder: (context, index) {
        final day = index + 1;

        Color color;
        if (day < currentDay) {
          color = Colors.green;
        } else if (day == currentDay) {
          color = Colors.redAccent;
        } else {
          color = Colors.grey.shade800;
        }

        return Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(day.toString()),
        );
      },
    );
  }
}

class _Progress extends StatelessWidget {
  final int currentDay;
  final int totalDays;

  const _Progress({
    required this.currentDay,
    required this.totalDays,
  });

  @override
  Widget build(BuildContext context) {
    return LinearProgressIndicator(
      value: currentDay / totalDays,
      color: Colors.redAccent,
      backgroundColor: Colors.grey,
    );
  }
}

class _Actions extends StatelessWidget {
  final bool disabled;
  final VoidCallback onComplete;
  final VoidCallback onSkip;

  const _Actions({
    required this.disabled,
    required this.onComplete,
    required this.onSkip,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: disabled ? null : onSkip,
            child: const Text('Skip'),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: ElevatedButton(
            onPressed: disabled ? null : onComplete,
            child: const Text('Completed'),
          ),
        ),
      ],
    );
  }
}
