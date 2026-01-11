class DailyQuote {
  final int dayIndex;
  final String text;

  const DailyQuote({
    required this.dayIndex,
    required this.text,
  });
}

const dailyQuotes = [
  DailyQuote(
    dayIndex: 0,
    text: 'Small steps every day build strong habits.',
  ),
  DailyQuote(
    dayIndex: 1,
    text: 'You don\'t need motivation. You need consistency.',
  ),
  DailyQuote(
    dayIndex: 2,
    text: 'Today is a good day to show up for yourself.',
  ),
  DailyQuote(
    dayIndex: 3,
    text: 'Progress is quiet. Keep going.',
  ),
  DailyQuote(
    dayIndex: 4,
    text: 'Your body remembers every effort.',
  ),
  DailyQuote(
    dayIndex: 5,
    text: 'Discipline beats excuses.',
  ),
  DailyQuote(
    dayIndex: 6,
    text: 'One workout won\'t change everything. Many will.',
  ),
  DailyQuote(
    dayIndex: 7,
    text: 'You are stronger than yesterday.',
  ),
  DailyQuote(
    dayIndex: 8,
    text: 'Consistency creates results.',
  ),
  DailyQuote(
    dayIndex: 9,
    text: 'Finish what you started.',
  ),
];

DailyQuote getTodayQuote() {
  final todayIndex = DateTime.now().day % dailyQuotes.length;
  return dailyQuotes[todayIndex];
}
