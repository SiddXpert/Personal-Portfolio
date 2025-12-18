import 'package:flutter/material.dart';
import '../theme.dart';
import 'dart:math' as math;

class FloatingBackground extends StatefulWidget {
  const FloatingBackground({Key? key}) : super(key: key);

  @override
  State<FloatingBackground> createState() => _FloatingBackgroundState();
}

class _FloatingBackgroundState extends State<FloatingBackground>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl =
      AnimationController(vsync: this, duration: const Duration(seconds: 8))
        ..repeat();

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return IgnorePointer(
      child: AnimatedBuilder(
        animation: _ctrl,
        builder: (context, child) {
          final t = _ctrl.value;

          return Stack(
            children: [
              /// 🖼 Background Image → Loads FIRST ✔️ No Flash
              

              /// 🌫 Soft overlay for readability
              Positioned.fill(
                child: Container(
                  color: Colors.black.withOpacity(0.28),
                ),
              ),

              /// 🫧 Floating Animated Blobs
              Positioned(
                left: -size.width * 0.12 + math.sin(t * 2 * math.pi) * 12,
                top: size.height * 0.08 + math.cos(t * 2 * math.pi) * 8,
                child: Opacity(
                  opacity: 0.10,
                  child: Container(
                    width: 300,
                    height: 220,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppTheme.teal.withOpacity(0.8),
                          Colors.blue.withOpacity(0.35)
                        ],
                      ),
                      borderRadius: BorderRadius.circular(200),
                    ),
                  ),
                ),
              ),

              Positioned(
                right: -size.width * 0.12 + math.cos(t * 2 * math.pi) * 10,
                bottom: size.height * 0.05 + math.sin(t * 2 * math.pi) * 6,
                child: Opacity(
                  opacity: 0.08,
                  child: Container(
                    width: 260,
                    height: 200,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.purple.withOpacity(0.55),
                          AppTheme.teal.withOpacity(0.5)
                        ],
                      ),
                      borderRadius: BorderRadius.circular(200),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
