import 'package:flutter/material.dart';
import '../../home/presentation/home_page.dart';
import '../../active_challenges/presentation/active_navigator.dart';
import '../../create_challenge/presentation/create_challenge_page.dart';
import '../../profile/presentation/profile_page.dart';
import '../../../core/localization/app_localizations.dart';
import '../../../app/root_navigation.dart';

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(Localizations.localeOf(context));
    
    return RootNavigation(
      setTab: (i) {
        if (i < 0 || i > 3) return; // защита
        setState(() {
          _index = i;
        });
      },
      child: Scaffold(
        body: IndexedStack(
          index: _index,
          children: const [
            HomePage(),               // 0
            ActiveNavigator(),        // 1
            CreateChallengePage(),    // 2
            ProfilePage(),            // 3
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _index,
          selectedItemColor: Colors.redAccent,
          unselectedItemColor: Colors.grey,
          backgroundColor: Colors.black,
          onTap: (i) {
            if (i < 0 || i > 3) return;
            setState(() => _index = i);
          },
          items: [
            BottomNavigationBarItem(
              icon: const Icon(Icons.home),
              label: locale.home,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.fitness_center),
              label: locale.active,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.add),
              label: locale.create,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.person),
              label: locale.profile,
            ),
          ],
        ),
      ),
    );
  }
}