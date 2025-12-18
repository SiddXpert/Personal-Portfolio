import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:visibility_detector/visibility_detector.dart';

class AboutSection extends StatefulWidget {
  const AboutSection({super.key});

  @override
  State<AboutSection> createState() => _AboutSectionState();
}

class _AboutSectionState extends State<AboutSection>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _fade;
  late final Animation<Offset> _slide;

  bool _played = false;

  @override
  void initState() {
    super.initState();

    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 850),
    );

    _fade = CurvedAnimation(
      parent: _ctrl,
      curve: Curves.easeOut,
    );

    _slide = Tween<Offset>(
      begin: const Offset(0, 0.08),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _ctrl, curve: Curves.easeOutCubic),
    );
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    final bool isMobile = width < 850;
    final bool isTablet = width >= 850 && width < 1100;

    return VisibilityDetector(
      key: const Key("about-section"),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.3 && !_played) {
          _played = true;
          _ctrl.forward();
        }
      },
      child: Padding(
        padding: EdgeInsets.only(
          top: isMobile ? 60 : isTablet ? 80 : 100,
          bottom: isMobile ? 70 : isTablet ? 90 : 120,
          left: 20,
          right: 20,
        ),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1200),
            child: FadeTransition(
              opacity: _fade,
              child: SlideTransition(
                position: _slide,
                child: Flex(
                  direction:
                      isMobile || isTablet ? Axis.vertical : Axis.horizontal,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    /// IMAGE
                    _imageBlock(isMobile, isTablet),

                    SizedBox(
                      width: isMobile || isTablet ? 0 : 90,
                      height: isMobile || isTablet ? 50 : 0,
                    ),

                    /// TEXT
                    _textBlock(isMobile, isTablet),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // --------------------------------------------------
  // IMAGE
  // --------------------------------------------------

  Widget _imageBlock(bool isMobile, bool isTablet) {
    final double size = isMobile
        ? 220
        : isTablet
            ? 280
            : 360;

    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: size + 40,
          height: size + 40,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(
              colors: [
                Colors.tealAccent.withOpacity(0.22),
                Colors.transparent,
              ],
            ),
          ),
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(26),
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(26),
              border: Border.all(color: Colors.white24),
              color: Colors.white.withOpacity(0.04),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(18),
              child: Image.asset(
                "assets/p1.jpg",
                fit: BoxFit.cover,
                height: size + 40,
                width: size,
              ),
            ),
          ),
        ),
      ],
    );
  }

  // --------------------------------------------------
  // TEXT
  // --------------------------------------------------

  Widget _textBlock(bool isMobile, bool isTablet) {
    final double titleSize = isMobile ? 28 : isTablet ? 34 : 40;
    final double bodySize = isMobile ? 15.5 : isTablet ? 16.5 : 17;

    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: isMobile ? 520 : 560,
      ),
      child: Column(
        crossAxisAlignment:
            isMobile || isTablet ? CrossAxisAlignment.center : CrossAxisAlignment.start,
        children: [
          Text(
            "ABOUT",
            style: GoogleFonts.spaceGrotesk(
              fontSize: 13,
              letterSpacing: 3,
              color: Colors.tealAccent,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            "Designing Flutter apps with clarity & intent.",
            textAlign:
                isMobile || isTablet ? TextAlign.center : TextAlign.start,
            style: GoogleFonts.spaceGrotesk(
              fontSize: titleSize,
              fontWeight: FontWeight.w700,
              color: Colors.white,
              height: 1.15,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            "With over 1 years of hands-on experience, I specialize in building "
            "user-friendly Flutter applications that feel fast, intuitive, "
            "and reliable.\n\n"
            "I focus on clean architecture, scalable state management, "
            "and polished UI/UX — ensuring every app is production-ready "
            "and easy to maintain.\n\n"
            "Along the way, I’ve successfully cleared multiple technical and "
            "non-technical interviews, demonstrating not just coding ability "
            "but also strong communication, problem-solving, and product thinking.",
            textAlign:
                isMobile || isTablet ? TextAlign.center : TextAlign.start,
            style: TextStyle(
              fontSize: bodySize,
              height: 1.7,
              color: Colors.white70,
            ),
          ),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment:
                isMobile || isTablet ? MainAxisAlignment.center : MainAxisAlignment.start,
            children: [
              Container(
                width: 46,
                height: 2,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Colors.tealAccent, Colors.cyanAccent],
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                "Flutter • UI/UX • Clean Architecture",
                style: TextStyle(
                  color: Colors.white54,
                  fontSize: 13,
                  letterSpacing: 0.6,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
