import 'package:flutter/material.dart';
import 'package:my_portfolio/bg_image.dart';
import 'package:my_portfolio/glass_shell.dart';
import 'package:my_portfolio/homescreen.dart';
import 'package:my_portfolio/welcome_screen.dart';

class AppBootstrap extends StatefulWidget {
  const AppBootstrap({Key? key}) : super(key: key);

  @override
  State<AppBootstrap> createState() => _AppBootstrapState();
}

class _AppBootstrapState extends State<AppBootstrap> {
  bool _ready = false;
  bool _started = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_started) return;
    _started = true;
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    final startTime = DateTime.now();

    await precacheImage(
      const AssetImage('assets/bg.png'),
      context,
    );

    const minWelcomeTime = 4000;
    final elapsed =
        DateTime.now().difference(startTime).inMilliseconds;

    if (elapsed < minWelcomeTime) {
      await Future.delayed(
        Duration(milliseconds: minWelcomeTime - elapsed),
      );
    }

    await Future.delayed(const Duration(milliseconds: 200));

    if (mounted) setState(() => _ready = true);
  }


@override
Widget build(BuildContext context) {
  return BackgroundShell(
    child: _ready
        ? GlassShell(
            navBar: const SizedBox(), // will be injected by HomeScreen
            body: const HomeScreen(
              disableInitialAnimation: true,
            ),
          )
        : const WelcomeScreen(),
  );
}

  }
