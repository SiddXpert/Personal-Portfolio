// import 'dart:math';
// import 'package:flutter/material.dart';
// import 'package:flutter/scheduler.dart';

// class StarBackground extends StatefulWidget {
//   const StarBackground({super.key});

//   @override
//   State<StarBackground> createState() => _StarBackgroundState();
// }

// class _StarBackgroundState extends State<StarBackground>
//     with SingleTickerProviderStateMixin {
//   late final Ticker _ticker;
//   final Random _rnd = Random();

//   late final List<_Star> _stars;
//   final List<_ShootingStar> _shootingStars = [];

//   Offset _pointer = const Offset(-1000, -1000);

//   static const int starCount = 260;
//   static const int maxShootingStars = 2;

//   @override
//   void initState() {
//     super.initState();

//     _stars = List.generate(starCount, (_) => _createStar());

//     /// 🎞️ smooth continuous repaint (GPU friendly)
//     _ticker = createTicker((_) => setState(() {}))..start();
//   }

//   _Star _createStar() {
//     return _Star(
//       x: _rnd.nextDouble(),
//       y: _rnd.nextDouble(),
//       size: 0.6 + _rnd.nextDouble() * 1.2,
//       twinkleSpeed: 0.0015 + _rnd.nextDouble() * 0.003,
//       phase: _rnd.nextDouble() * pi * 2,
//     );
//   }

//   void _maybeSpawnShootingStar() {
//     if (_shootingStars.length >= maxShootingStars) return;

//     /// very rare → premium feel
//     if (_rnd.nextDouble() < 0.004) {
//       _shootingStars.add(
//         _ShootingStar(
//           x: _rnd.nextDouble(),
//           y: -0.1,
//           vx: 0.012 + _rnd.nextDouble() * 0.008,
//           vy: 0.018 + _rnd.nextDouble() * 0.01,
//           life: 1.0,
//         ),
//       );
//     }
//   }

//   @override
//   void dispose() {
//     _ticker.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Listener(
//       onPointerHover: (e) => _pointer = e.localPosition,
//       onPointerMove: (e) => _pointer = e.localPosition,
//       onPointerUp: (_) => _pointer = const Offset(-1000, -1000),
//       child: CustomPaint(
//         painter: _StarPainter(
//           stars: _stars,
//           shootingStars: _shootingStars,
//           pointer: _pointer,
//           onSpawnShootingStar: _maybeSpawnShootingStar,
//         ),
//         child: const SizedBox.expand(),
//       ),
//     );
//   }
// }

// /* ───────────────────────────────────────────── */

// class _Star {
//   double x, y;
//   double size;
//   double twinkleSpeed;
//   double phase;

//   _Star({
//     required this.x,
//     required this.y,
//     required this.size,
//     required this.twinkleSpeed,
//     required this.phase,
//   });
// }

// class _ShootingStar {
//   double x, y, vx, vy, life;

//   _ShootingStar({
//     required this.x,
//     required this.y,
//     required this.vx,
//     required this.vy,
//     required this.life,
//   });
// }

// /* ───────────────────────────────────────────── */

// class _StarPainter extends CustomPainter {
//   final List<_Star> stars;
//   final List<_ShootingStar> shootingStars;
//   final Offset pointer;
//   final VoidCallback onSpawnShootingStar;

//   _StarPainter({
//     required this.stars,
//     required this.shootingStars,
//     required this.pointer,
//     required this.onSpawnShootingStar,
//   });

//   @override
//   void paint(Canvas canvas, Size size) {
//     /// 🌌 DEEP LUXURY BLACK SKY
//     final bgPaint = Paint()
//       ..shader = const LinearGradient(
//         begin: Alignment.topCenter,
//         end: Alignment.bottomCenter,
//         colors: [
//           Color(0xFF02040A),
//           Color(0xFF000000),
//         ],
//       ).createShader(
//         Rect.fromLTWH(0, 0, size.width, size.height),
//       );

//     canvas.drawRect(
//       Rect.fromLTWH(0, 0, size.width, size.height),
//       bgPaint,
//     );

//     final hasPointer = pointer.dx > 0 && pointer.dy > 0;

//     /// ⭐ TWINKLING STAR FIELD
//     for (final s in stars) {
//       final px = s.x * size.width;
//       final py = s.y * size.height;

//       s.phase += s.twinkleSpeed;
//       final twinkle = (sin(s.phase) + 1) / 2;

//       double hover = 0;
//       if (hasPointer) {
//         final d = (Offset(px, py) - pointer).distance;
//         if (d < 140) hover = (140 - d) / 140;
//       }

//       final opacity =
//           (0.28 + twinkle * 0.45 + hover * 0.6).clamp(0.2, 1.0);

//       /// glow core
//       canvas.drawCircle(
//         Offset(px, py),
//         s.size + hover * 0.6,
//         Paint()
//           ..color = Colors.white.withOpacity(opacity)
//           ..maskFilter =
//               const MaskFilter.blur(BlurStyle.normal, 6),
//       );

//       /// ✦ subtle cross sparkle (premium look)
//       final crossPaint = Paint()
//         ..color = Colors.white.withOpacity(opacity * 0.7)
//         ..strokeWidth = 0.8;

//       canvas.drawLine(
//         Offset(px - 3, py),
//         Offset(px + 3, py),
//         crossPaint,
//       );
//       canvas.drawLine(
//         Offset(px, py - 3),
//         Offset(px, py + 3),
//         crossPaint,
//       );
//     }

//     /// 🌠 RARE SHOOTING STARS
//     onSpawnShootingStar();
//     shootingStars.removeWhere((s) => s.life <= 0);

//     for (final ss in shootingStars) {
//       final start =
//           Offset(ss.x * size.width, ss.y * size.height);
//       final end = Offset(
//         (ss.x - ss.vx * 2) * size.width,
//         (ss.y - ss.vy * 2) * size.height,
//       );

//       final paint = Paint()
//         ..shader = LinearGradient(
//           colors: [
//             Colors.white.withOpacity(ss.life),
//             Colors.transparent,
//           ],
//         ).createShader(Rect.fromPoints(start, end))
//         ..strokeWidth = 1.6
//         ..maskFilter =
//             const MaskFilter.blur(BlurStyle.normal, 4);

//       canvas.drawLine(start, end, paint);

//       ss.x += ss.vx;
//       ss.y += ss.vy;
//       ss.life -= 0.03;
//     }
//   }

//   @override
//   bool shouldRepaint(_) => true;
// }
