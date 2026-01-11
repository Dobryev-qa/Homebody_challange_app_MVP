import 'package:flutter/material.dart';
import '../../active_challenges/data/challenge_local_storage.dart';
import '../../active_challenges/domain/challenge.dart';
import '../../create_challenge/data/user_challenge_local_storage.dart';
import '../../create_challenge/domain/user_challenge.dart';
import '../../../app/root_navigation.dart';
import '../domain/models/daily_quote.dart';
import '../domain/models/featured_challenge.dart';
import '../../../core/utils/app_refresh_notifier.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/theme/app_components.dart';

Future<void> activateFromFeatured({
  required BuildContext context,
  required FeaturedChallenge featured,
}) async {
  print('🔥 Activating featured challenge: ${featured.id}');
  
  final storage = ChallengeLocalStorage();

  final activeChallenges = await storage.loadActiveChallenges();
  print('📊 Current active challenges count: ${activeChallenges.length}');

  final exists = activeChallenges.any(
    (c) => c.id == featured.id,
  );

  if (!exists) {
    print('✅ Creating new challenge from featured: ${featured.title}');
    final challenge = Challenge(
      id: featured.id,
      title: featured.title,
      totalDays: featured.totalDays,
      currentDay: 1,
    );

    await storage.activateChallenge(challenge);
    print('💾 Challenge saved to storage');
    notifyAppRefresh();
  } else {
    print('ℹ️ Challenge already exists, just opening');
  }

  // Home не пушит экраны — только переключает вкладку
  RootNavigation.of(context).setTab(1);
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: appRefreshNotifier,
      builder: (_, __, ___) {
        return Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const _Header(),
                  const SizedBox(height: 16),
                  const _ChallengeOfMonth(),
                  const _QuoteOfDay(),
                  const SizedBox(height: 24),
                  const _FeaturedChallengesSection(),
                  const SizedBox(height: 24),
                  const _MyChallengesSection(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      child: Text(
        'HomeBody',
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
          fontSize: 28,
          fontWeight: FontWeight.w800,
          letterSpacing: 1.2,
        ),
      ),
    );
  }
}

class _ChallengeOfMonth extends StatelessWidget {
  const _ChallengeOfMonth();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: ChallengeLocalStorage().loadActiveChallenges(),
      builder: (context, snapshot) {
        final activeChallenges = snapshot.data ?? [];
        
        final existing = activeChallenges
            .where((c) => c.id == monthlyChallenge.id)
            .toList();
            
        final isActive = existing.isNotEmpty && !existing.first.isCompleted;
        final isCompleted = existing.isNotEmpty && existing.first.isCompleted;
        
        final buttonText = isCompleted
            ? 'Completed'
            : isActive
                ? 'Open'
                : 'Start challenge';
                
        final disabled = isCompleted;

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Challenge of the Month',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.7),
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  monthlyChallenge.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  monthlyChallenge.description,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: disabled ? Colors.grey : Colors.white,
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    onPressed: disabled ? null : () {
                      if (isActive) {
                        RootNavigation.of(context).setTab(1);
                      } else {
                        activateFromFeatured(
                          context: context,
                          featured: monthlyChallenge,
                        );
                      }
                    },
                    child: Text(buttonText),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _QuoteOfDay extends StatelessWidget {
  const _QuoteOfDay();

  @override
  Widget build(BuildContext context) {
    final quote = getTodayQuote();
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 0),
      child: AppCard(
        padding: const EdgeInsets.all(20),
        child: Text(
          quote.text,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            fontStyle: FontStyle.italic,
          ),
        ),
      ),
    );
  }
}

class _FeaturedChallengesSection extends StatelessWidget {
  const _FeaturedChallengesSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(16, 24, 16, 12),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Featured challenges',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        FutureBuilder(
          future: ChallengeLocalStorage().loadActiveChallenges(),
          builder: (context, snapshot) {
            final activeChallenges = snapshot.data ?? [];
            
            return SizedBox(
              height: 140,
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                scrollDirection: Axis.horizontal,
                itemCount: featuredChallenges.length,
                separatorBuilder: (_, __) => const SizedBox(width: 12),
                itemBuilder: (context, index) {
                  final c = featuredChallenges[index];
                  
                  final active = activeChallenges
                      .where((a) => a.id == c.id)
                      .toList();
                  
                  final isActive = active.isNotEmpty && !active.first.isCompleted;
                  final isCompleted = active.isNotEmpty && active.first.isCompleted;
                  
                  final buttonText = isCompleted
                      ? 'Completed'
                      : isActive
                          ? 'Open'
                          : 'Start';
                  
                  final disabled = isCompleted;

                  return Container(
                    width: 220,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1A1A1A),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          c.title,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          c.description,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 13,
                            color: Colors.grey,
                          ),
                        ),
                        const Spacer(),
                        Row(
                          children: [
                            Text(
                              c.level,
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.redAccent,
                              ),
                            ),
                            const Spacer(),
                            ElevatedButton(
                              onPressed: disabled ? null : () {
                                activateFromFeatured(
                                  context: context,
                                  featured: c,
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: disabled 
                                    ? Colors.grey 
                                    : Colors.redAccent,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12, 
                                  vertical: 4
                                ),
                                minimumSize: Size.zero,
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                              child: Text(
                                buttonText,
                                style: const TextStyle(fontSize: 12),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            );
          },
        ),
      ],
    );
  }
}


class _MyChallengesSection extends StatelessWidget {
  const _MyChallengesSection();

  @override
  Widget build(BuildContext context) {
    final userStorage = UserChallengeLocalStorage();
    final activeStorage = ChallengeLocalStorage();

    return ValueListenableBuilder(
      valueListenable: appRefreshNotifier,
      builder: (_, __, ___) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 24, 16, 12),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'My challenges',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            FutureBuilder(
              future: Future.wait([
                userStorage.loadChallenges(),
                activeStorage.loadActiveChallenges(),
              ]),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const SizedBox.shrink();
                }

                final userChallenges = snapshot.data![0] as List<UserChallenge>;
                final activeChallenges = snapshot.data![1] as List<Challenge>;

            if (userChallenges.isEmpty) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: AppCard(
                  child: Column(
                    children: [
                      Icon(Icons.add_circle_outline,
                          size: 40, color: AppColors.textMuted),
                      const SizedBox(height: 8),
                      Text(
                        'Your personal challenges appear here',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const SizedBox(height: 12),
                      PrimaryButton(
                        text: 'Create challenge',
                        onTap: () {
                          RootNavigation.of(context).setTab(2); // Create tab
                        },
                      ),
                    ],
                  ),
                ),
              );
            }

            return SizedBox(
              height: 160,
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                scrollDirection: Axis.horizontal,
                itemCount: userChallenges.length,
                separatorBuilder: (_, __) => const SizedBox(width: 12),
                itemBuilder: (context, index) {
                  final uc = userChallenges[index];

                  final active = activeChallenges
                      .where((a) => a.id == uc.id)
                      .toList();

                  final isActive = active.isNotEmpty && !active.first.isCompleted;
                  final isCompleted =
                      active.isNotEmpty && active.first.isCompleted;

                  return SizedBox(
                    width: 220,
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1A1A1A),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            uc.title,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Spacer(),
                          Row(
                            children: [
                              Text(
                                isCompleted
                                    ? 'Completed'
                                    : isActive
                                        ? 'Active'
                                        : 'Not active',
                                style: TextStyle(
                                  color: isCompleted
                                      ? Colors.green
                                      : isActive
                                          ? Colors.redAccent
                                          : Colors.grey,
                                ),
                              ),
                              const Spacer(),
                              ElevatedButton(
                                onPressed: isCompleted ? null : () {
                                  if (isActive) {
                                    RootNavigation.of(context).setTab(1);
                                  } else {
                                    final challenge = Challenge(
                                      id: uc.id,
                                      title: uc.title,
                                      totalDays: uc.totalDays,
                                      currentDay: 1,
                                      // ВАЖНО: прокидываем параметры
                                      exercise: uc.exercise,
                                      sets: uc.sets,
                                      reps: uc.reps,
                                      increasing: uc.increasing,
                                    );
                                    
                                    activeStorage.activateChallenge(challenge).then((_) {
                                      if (context.mounted) {
                                        RootNavigation.of(context).setTab(1);
                                      }
                                    });
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: isCompleted 
                                      ? Colors.grey 
                                      : Colors.redAccent,
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12, 
                                    vertical: 4
                                  ),
                                  minimumSize: Size.zero,
                                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                ),
                                child: Text(
                                  isCompleted
                                      ? 'Completed'
                                      : isActive
                                          ? 'Open'
                                          : 'Start',
                                  style: const TextStyle(fontSize: 12),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ],
    );
      },
    );
  }
}

