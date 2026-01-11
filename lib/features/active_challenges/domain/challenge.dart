class Challenge {
  final String id;
  final String title;
  final int totalDays;
  final int currentDay;
  final DateTime? lastActionDate;
  final String? exercise;
  final int? sets;
  final int? reps;
  final bool? increasing;

  const Challenge({
    required this.id,
    required this.title,
    required this.totalDays,
    required this.currentDay,
    this.lastActionDate,
    this.exercise,
    this.sets,
    this.reps,
    this.increasing,
  });

  Challenge copyWith({
    int? currentDay,
    DateTime? lastActionDate,
  }) {
    return Challenge(
      id: id,
      title: title,
      totalDays: totalDays,
      currentDay: currentDay ?? this.currentDay,
      lastActionDate: lastActionDate ?? this.lastActionDate,
      exercise: exercise,
      sets: sets,
      reps: reps,
      increasing: increasing,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'totalDays': totalDays,
      'currentDay': currentDay,
      'lastActionDate': lastActionDate?.toIso8601String(),
      'exercise': exercise,
      'sets': sets,
      'reps': reps,
      'increasing': increasing,
    };
  }

  factory Challenge.fromMap(Map<dynamic, dynamic> map) {
    return Challenge(
      id: map['id'] as String,
      title: map['title'] as String,
      totalDays: map['totalDays'] as int,
      currentDay: map['currentDay'] as int,
      lastActionDate: map['lastActionDate'] != null
          ? DateTime.parse(map['lastActionDate'] as String)
          : null,
      exercise: map['exercise'] as String?,
      sets: map['sets'] as int?,
      reps: map['reps'] as int?,
      increasing: map['increasing'] as bool?,
    );
  }

  bool get isCompleted => currentDay >= totalDays;
}
