import 'package:flutter/material.dart';
import 'active_challenges_page.dart';
import 'active_challenge_detail_page.dart';

class ActiveNavigator extends StatelessWidget {
  const ActiveNavigator({super.key});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      onGenerateRoute: (settings) {
        if (settings.name == '/detail') {
          final id = settings.arguments as String;
          return MaterialPageRoute(
            builder: (_) =>
                ActiveChallengeDetailPage(challengeId: id),
          );
        }

        return MaterialPageRoute(
          builder: (_) => const ActiveChallengesPage(),
        );
      },
    );
  }
}
