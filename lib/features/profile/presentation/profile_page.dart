import 'package:flutter/material.dart';
import '../data/profile_stats_service.dart';
import '../domain/profile_stats.dart';
import '../../../core/constants/user_local_storage.dart';
import '../../../core/theme/theme_notifier.dart';
import '../../../core/theme/theme_local_storage.dart';
import '../../../core/theme/app_theme_mode.dart';
import '../../../core/theme/app_components.dart';
import '../../../core/theme/app_theme.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
          future: Future.wait([
            UserLocalStorage().getOrCreateOfflineId(),
            ProfileStatsService().calculate(),
          ]),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              print('❌ ProfilePage error: ${snapshot.error}');
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error, color: Colors.red, size: 48),
                    const SizedBox(height: 16),
                    Text('Error loading profile: ${snapshot.error}'),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () => Navigator.of(context).pushReplacementNamed('/'),
                      child: const Text('Go to Home'),
                    ),
                  ],
                ),
              );
            }

            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }

            final offlineId = snapshot.data![0] as String;
            final stats = snapshot.data![1] as ProfileStats;

            return ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Text(
                  'Profile',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1.2,
                  ),
                ),
                const SizedBox(height: 24),

                AppCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Offline ID',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontSize: 12,
                          letterSpacing: 1.1,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        offlineId,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // Appearance section
                AppCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Appearance',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 16),

                      _ThemeOption(
                        title: 'System',
                        value: AppThemeMode.system,
                      ),
                      _ThemeOption(
                        title: 'Light',
                        value: AppThemeMode.light,
                      ),
                      _ThemeOption(
                        title: 'Dark',
                        value: AppThemeMode.dark,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                Row(
                  children: [
                    Expanded(
                      child: _StatCard(
                        label: 'Completed\nChallenges',
                        value: stats.completedChallenges.toString(),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _StatCard(
                        label: 'Current\nStreak',
                        value: '${stats.currentStreak} days',
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                _StatCard(
                  label: 'Best Streak',
                  value: '${stats.bestStreak} days',
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

/* ===== UI ===== */

class _StatCard extends StatelessWidget {
  final String label;
  final String value;

  const _StatCard({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        children: [
          Text(
            value,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontSize: 22,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              fontSize: 12,
              letterSpacing: 1.1,
            ),
          ),
        ],
      ),
    );
  }
}

class _ThemeOption extends StatelessWidget {
  final String title;
  final AppThemeMode value;

  const _ThemeOption({
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<AppThemeMode>(
      valueListenable: themeModeNotifier,
      builder: (_, current, __) {
        final selected = current == value;

        return ListTile(
          title: Text(
            title,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          trailing: selected
              ? const Icon(Icons.check, color: AppColors.primary)
              : null,
          onTap: () async {
            themeModeNotifier.value = value;
            await ThemeLocalStorage().save(value);
          },
        );
      },
    );
  }
}
