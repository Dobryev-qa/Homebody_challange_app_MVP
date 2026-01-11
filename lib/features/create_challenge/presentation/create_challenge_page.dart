import 'package:flutter/material.dart';
import '../data/user_challenge_local_storage.dart';
import '../domain/user_challenge.dart';
import '../../../core/utils/app_refresh_notifier.dart';

class CreateChallengePage extends StatelessWidget {
  const CreateChallengePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const Text(
              'Create Challenge',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            _ModeCard(
              title: 'Quick Start',
              description: 'Create a challenge in a few steps',
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const _QuickStartPage()),
                );
              },
            ),
            const SizedBox(height: 16),
            _ModeCard(
              title: 'Pro',
              description: 'Full control over challenge parameters',
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const _ProPage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _ModeCard extends StatelessWidget {
  final String title;
  final String description;
  final VoidCallback onTap;

  const _ModeCard({
    required this.title,
    required this.description,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: _Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(description, style: const TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}

class _QuickStartPage extends StatefulWidget {
  const _QuickStartPage();

  @override
  State<_QuickStartPage> createState() => _QuickStartPageState();
}

class _QuickStartPageState extends State<_QuickStartPage> {
  String _exercise = 'Push-ups';
  int _days = 30;
  int _sets = 3;
  int _reps = 10;
  bool _increasing = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Quick Start')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const _Section(title: 'Exercise'),
          _Chips(
            options: const ['Push-ups', 'Squats', 'Plank', 'Abs'],
            onSelected: (v) {
              setState(() {
                _exercise = v;
              });
            },
          ),
          const SizedBox(height: 16),

          const _Section(title: 'Duration'),
          _Chips(
            options: const ['7', '14', '30'],
            onSelected: (v) {
              setState(() {
                _days = int.parse(v);
              });
            },
          ),
          const SizedBox(height: 16),

          const _Section(title: 'Sets'),
          _Chips(
            options: const ['2', '3', '4', '5'],
            onSelected: (v) {
              setState(() {
                _sets = int.parse(v);
              });
            },
          ),
          const SizedBox(height: 16),

          const _Section(title: 'Reps per set'),
          _Chips(
            options: const ['5', '10', '15', '20', '25'],
            onSelected: (v) {
              setState(() {
                _reps = int.parse(v);
              });
            },
          ),
          const SizedBox(height: 16),

          const _Section(title: 'Load'),
          _Chips(
            options: const ['Fixed', 'Increasing'],
            onSelected: (v) {
              setState(() {
                _increasing = v == 'Increasing';
              });
            },
          ),
          const SizedBox(height: 24),

          ElevatedButton(
            onPressed: () async {
              if (_sets <= 0 || _reps <= 0 || _days <= 0) return;
              
              print('🔨 Creating user challenge...');
              final challenge = UserChallenge(
                id: DateTime.now().millisecondsSinceEpoch.toString(),
                title: '$_exercise Challenge',
                totalDays: _days,
                mode: 'quick',
                exercise: _exercise,
                sets: _sets,
                reps: _reps,
                increasing: _increasing,
              );

              await UserChallengeLocalStorage().addChallenge(challenge);
              print('✅ User challenge saved: ${challenge.id}');
              notifyAppRefresh();

              if (!context.mounted) return;
              Navigator.pop(context);
            },
            child: const Text('Create'),
          ),
        ],
      ),
    );
  }
}

class _ProPage extends StatefulWidget {
  const _ProPage();

  @override
  State<_ProPage> createState() => _ProPageState();
}

class _ProPageState extends State<_ProPage> {
  String _exercise = 'Mixed';
  double _days = 30;
  int _sets = 4;
  int _reps = 12;
  bool _increasing = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pro')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _Section(title: 'Exercise'),
          _Chips(
            options: const ['Push-ups', 'Squats', 'Plank', 'Pull-ups', 'Mixed'],
            onSelected: (v) {
              setState(() {
                _exercise = v;
              });
            },
          ),
          const SizedBox(height: 16),
          _Section(title: 'Duration (days)'),
          Slider(
            value: _days,
            min: 7,
            max: 365,
            divisions: 358,
            label: _days.round().toString(),
            onChanged: (v) {
              setState(() {
                _days = v;
              });
            },
          ),
          const SizedBox(height: 16),
          _Section(title: 'Sets'),
          _Chips(
            options: const ['1', '2', '3', '4', '5'],
            onSelected: (v) {
              setState(() {
                _sets = int.parse(v);
              });
            },
          ),
          const SizedBox(height: 16),
          _Section(title: 'Reps per set'),
          _Chips(
            options: const ['5', '10', '15', '20', '25'],
            onSelected: (v) {
              setState(() {
                _reps = int.parse(v);
              });
            },
          ),
          const SizedBox(height: 16),
          _Section(title: 'Load'),
          _Chips(
            options: const ['Fixed', 'Increasing'],
            onSelected: (v) {
              setState(() {
                _increasing = v == 'Increasing';
              });
            },
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () async {
              final challenge = UserChallenge(
                id: DateTime.now().millisecondsSinceEpoch.toString(),
                title: 'Pro $_exercise Challenge',
                totalDays: _days.round(),
                mode: 'pro',
                exercise: _exercise,
                sets: _sets,
                reps: _reps,
                increasing: _increasing,
              );

              await UserChallengeLocalStorage().addChallenge(challenge);
              notifyAppRefresh();

              if (!context.mounted) return;
              Navigator.pop(context);
            },
            child: const Text('Create'),
          ),
        ],
      ),
    );
  }
}

class _Section extends StatelessWidget {
  final String title;

  const _Section({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    );
  }
}

class _Chips extends StatefulWidget {
  final List<String> options;
  final ValueChanged<String> onSelected;

  const _Chips({
    required this.options,
    required this.onSelected,
  });

  @override
  State<_Chips> createState() => _ChipsState();
}

class _ChipsState extends State<_Chips> {
  String? _selected;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      children: widget.options.map((o) {
        return ChoiceChip(
          label: Text(o),
          selected: _selected == o,
          onSelected: (_) {
            setState(() {
              _selected = o;
            });
            widget.onSelected(o);
          },
        );
      }).toList(),
    );
  }
}

class _CreateButton extends StatelessWidget {
  const _CreateButton();

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        final challenge = UserChallenge(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          title: 'My First Challenge',
          totalDays: 30,
          mode: 'quick',
          exercise: 'Push-ups',
          sets: 3,
          reps: 10,
          increasing: false,
        );

        await UserChallengeLocalStorage().addChallenge(challenge);

        Navigator.pop(context);
      },
      child: const Text('Create'),
    );
  }
}

class _Card extends StatelessWidget {
  final Widget child;

  const _Card({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(16),
      ),
      child: child,
    );
  }
}
