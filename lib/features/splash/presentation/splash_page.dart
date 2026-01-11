import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'root_page.dart';
import 'splash_bloc.dart';
import 'splash_event.dart';
import 'splash_state.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SplashBloc()..add(SplashStarted()),
      child: BlocListener<SplashBloc, SplashState>(
        listener: (context, state) {
          if (state is SplashFinished) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (_) => const RootPage(),
              ),
            );
          }
        },
        child: const _SplashView(),
      ),
    );
  }
}

class _SplashView extends StatelessWidget {
  const _SplashView();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Homebody Challenge',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
