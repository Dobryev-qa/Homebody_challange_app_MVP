class UserChallenge {
  final String id;
  final String title;
  final int totalDays;
  final String mode; // quick / pro
  final String exercise;
  final int sets;
  final int reps;
  final bool increasing;

  const UserChallenge({
    required this.id,
    required this.title,
    required this.totalDays,
    required this.mode,
    required this.exercise,
    required this.sets,
    required this.reps,
    required this.increasing,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'totalDays': totalDays,
      'mode': mode,
      'exercise': exercise,
      'sets': sets,
      'reps': reps,
      'increasing': increasing,
    };
  }

  factory UserChallenge.fromMap(Map<dynamic, dynamic> map) {
    return UserChallenge(
      id: map['id'],
      title: map['title'],
      totalDays: map['totalDays'],
      mode: map['mode'],
      exercise: map['exercise'],
      sets: map['sets'],
      reps: map['reps'],
      increasing: map['increasing'],
    );
  }
}
