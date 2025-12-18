import 'package:flutter/material.dart';
import 'package:my_portfolio/widgets/floating_bg.dart';

class BackgroundShell extends StatelessWidget {
  final Widget child;
  const BackgroundShell({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          /// 🌄 BACKGROUND IMAGE (FIRST FRAME)
          Positioned.fill(
            child: Image.asset(
              'assets/bg.png',
              fit: BoxFit.cover,
              filterQuality: FilterQuality.high,
            ),
          ),

          /// 🌫 OVERLAY FOR READABILITY
          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.28),
            ),
          ),

          /// 🫧 FLOATING BLOBS
          const FloatingBackground(),

          /// 🧩 FOREGROUND UI
          Positioned.fill(child: child),
        ],
      ),
    );
  }
}
