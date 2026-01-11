import 'package:flutter/material.dart';
import '../data/challenge_local_storage.dart';
import '../domain/challenge.dart';
import 'active_challenge_detail_page.dart';
import '../../../core/utils/app_refresh_notifier.dart';

class ActiveChallengesPage extends StatefulWidget {
  const ActiveChallengesPage({super.key});

  @override
  State<ActiveChallengesPage> createState() => _ActiveChallengesPageState();
}

class _ActiveChallengesPageState extends State<ActiveChallengesPage> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: appRefreshNotifier,
      builder: (_, __, ___) {
        return Scaffold(
          body: SafeArea(
            child: FutureBuilder<List<Challenge>>(
              future: ChallengeLocalStorage().loadActiveChallenges(),
              builder: (context, snapshot) {
                final challenges = snapshot.data ?? [];
                print('🎯 Active screen received ${challenges.length} challenges');

                final active =
                    challenges.where((c) => !c.isCompleted).toList();
                final completed =
                    challenges.where((c) => c.isCompleted).toList();
                
                print('📊 Active: ${active.length}, Completed: ${completed.length}');

                if (challenges.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('No active challenges'),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () => setState(() {}),
                          child: const Text('Refresh'),
                        ),
                      ],
                    ),
                  );
                }

            return ListView(
              padding: const EdgeInsets.all(16),
              children: [
                if (active.isNotEmpty) ...[
                  const _SectionTitle('Active'),
                  const SizedBox(height: 8),
                  ...active.map(
                    (c) => _ChallengeTile(
                      challenge: c,
                      onTap: () {
                        Navigator.of(context).pushNamed(
                          '/detail',
                          arguments: c.id,
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
                if (completed.isNotEmpty) ...[
                  const _SectionTitle('Completed'),
                  const SizedBox(height: 8),
                  ...completed.map(
                    (c) => _ChallengeTile(
                      challenge: c,
                      onTap: () {
                        Navigator.of(context).pushNamed(
                          '/detail',
                          arguments: c.id,
                        );
                      },
                    ),
                  ),
                ],
              ],
            );
          },
        ),
      ),
    );
      },
    );
  }
}

/* ===== UI ===== */

class _SectionTitle extends StatelessWidget {
  final String text;
  const _SectionTitle(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class _ChallengeTile extends StatelessWidget {
  final Challenge challenge;
  final VoidCallback onTap;
  final bool completed;

  const _ChallengeTile({
    required this.challenge,
    required this.onTap,
    this.completed = false,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(challenge.title),
        subtitle: Text(
          completed
              ? 'Completed'
              : '${challenge.currentDay}/${challenge.totalDays} days',
        ),
        trailing: Icon(
          completed ? Icons.check_circle : Icons.chevron_right,
          color: completed ? Colors.green : null,
        ),
        onTap: onTap,
      ),
    );
  }
}
