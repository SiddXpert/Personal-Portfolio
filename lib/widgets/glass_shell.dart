import 'dart:ui';
import 'package:flutter/material.dart';

class GlassShell extends StatelessWidget {
  final Widget navBar;
  final Widget body;

  const GlassShell({
    super.key,
    required this.navBar,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RepaintBoundary( // 🔥 cache glass layer
        child: Container(
          constraints: const BoxConstraints(maxWidth: 1300),
          margin: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(34),
            color: Colors.white.withOpacity(0.06),
            border: Border.all(
              color: Colors.white.withOpacity(0.12),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.18),
                blurRadius: 28,
                offset: const Offset(0, 18),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(34),
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 6,
                sigmaY: 6,
              ),
              child: Column(
                children: [
                  /// 🔝 NAVBAR (STATIC, NO REBUILD JANK)
                  navBar,

                  /// 📜 BODY (SCROLLS)
                  Expanded(child: body),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
