class FeaturedChallenge {
  final String id;
  final String title;
  final String description;
  final String exercise;
  final int totalDays;
  final String level;

  const FeaturedChallenge({
    required this.id,
    required this.title,
    required this.description,
    required this.exercise,
    required this.totalDays,
    required this.level,
  });
}

const monthlyChallenge = FeaturedChallenge(
  id: 'monthly_pushups_50',
  title: '50 Push-ups',
  description: 'Build a daily habit and strengthen your upper body.',
  exercise: 'Push-ups',
  totalDays: 30,
  level: 'All Levels',
);

const featuredChallenges = [
  FeaturedChallenge(
    id: 'squats_beginner',
    title: 'Beginner Squats',
    description: 'Build leg strength step by step.',
    exercise: 'Squats',
    totalDays: 14,
    level: 'Beginner',
  ),
  FeaturedChallenge(
    id: 'core_plank',
    title: 'Core Stability',
    description: 'Improve core strength and posture.',
    exercise: 'Plank',
    totalDays: 14,
    level: 'Beginner',
  ),
  FeaturedChallenge(
    id: 'daily_abs',
    title: 'Daily Abs',
    description: 'Strengthen your core every day.',
    exercise: 'Abs',
    totalDays: 21,
    level: 'Intermediate',
  ),
  FeaturedChallenge(
    id: 'pullups_progress',
    title: 'Pull-up Progress',
    description: 'Build strength for pull-ups.',
    exercise: 'Pull-ups',
    totalDays: 30,
    level: 'Intermediate',
  ),
  FeaturedChallenge(
    id: 'full_body_basics',
    title: 'Full Body Basics',
    description: 'Simple daily full-body routine.',
    exercise: 'Mixed',
    totalDays: 21,
    level: 'Beginner',
  ),
];
