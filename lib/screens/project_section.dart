import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ProjectsSection extends StatefulWidget {
  const ProjectsSection({super.key});

  @override
  State<ProjectsSection> createState() => _ProjectsSectionState();
}

class _ProjectsSectionState extends State<ProjectsSection>
    with SingleTickerProviderStateMixin {
  late AnimationController _floatCtrl;

  static const String playStoreUrl =
      "https://play.google.com/store/apps/details?id=com.jagrati.zenit&hl=en";
  static const String appStoreUrl =
      "https://apps.apple.com/in/app/zenit-edu/id6748683332";

  @override
  void initState() {
    super.initState();
    _floatCtrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 6),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _floatCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final bool isMobile = width < 800;
    final bool isTablet = width >= 800 && width < 1100;

    return Padding(
      padding: EdgeInsets.only(
        top: isMobile ? 60 : isTablet ? 80 : 100,
        bottom: isMobile ? 80 : isTablet ? 100 : 120,
      ),
      child: Column(
        children: [
          const Text(
            "<Selected Projects />",
            style: TextStyle(
              color: Colors.tealAccent,
              fontSize: 16,
              letterSpacing: 1.8,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),

          Text(
            "Real Products. Real Users.",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: isMobile ? 28 : isTablet ? 38 : 42,
              fontWeight: FontWeight.bold,
              height: 1.2,
            ),
          ),

          const SizedBox(height: 14),

          Text(
            "A selection of production-ready applications.\n"
            "Featured below is one flagship product.",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white60,
              fontSize: isMobile ? 14 : 15,
              height: 1.5,
            ),
          ),

          SizedBox(height: isMobile ? 40 : 70),

          Wrap(
            alignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: isMobile || isTablet ? 0 : 90,
            runSpacing: isMobile || isTablet ? 60 : 0,
            children: [
              _animatedPhoneStack(isMobile, isTablet),
              _projectDetails(isMobile),
            ],
          ),

          SizedBox(height: isMobile ? 60 : 70),
          _otherProjects(),
        ],
      ),
    );
  }

  // ───────────────── PHONE STACK ─────────────────

  Widget _animatedPhoneStack(bool isMobile, bool isTablet) {
    final double mainW = isMobile ? 210 : isTablet ? 230 : 270;
    final double mainH = isMobile ? 430 : isTablet ? 480 : 560;

    return AnimatedBuilder(
      animation: _floatCtrl,
      builder: (_, __) {
        final floatY =
            sin(_floatCtrl.value * 2 * pi) * (isMobile ? 4 : 8);

        return Transform.translate(
          offset: Offset(0, floatY),
          child: SizedBox(
            width: mainW + 60,
            height: mainH + 90,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: mainW * 1.4,
                  height: mainH * 1.4,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        Colors.tealAccent
                            .withOpacity(isMobile ? 0.12 : 0.18),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),

                if (!isMobile) ...[
                  Transform.translate(
                    offset: const Offset(-110, 40),
                    child: Transform.rotate(
                      angle: -pi / 14,
                      child: _glassPhone(
                        width: mainW * 0.85,
                        height: mainH * 0.85,
                        gradient: _softGradient(),
                        opacity: 0.32,
                        isBackground: true,
                      ),
                    ),
                  ),
                  Transform.translate(
                    offset: const Offset(110, 40),
                    child: Transform.rotate(
                      angle: pi / 14,
                      child: _glassPhone(
                        width: mainW * 0.85,
                        height: mainH * 0.85,
                        gradient: _softGradient(reverse: true),
                        opacity: 0.32,
                        isBackground: true,
                      ),
                    ),
                  ),
                ],

                _glassPhone(
                  width: mainW,
                  height: mainH,
                  gradient: _heroGradient(),
                  child: SizedBox(
                    height: mainH - 40,
                    child: zenitCenterUI(isMobile),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // ───────────────── CENTER UI ─────────────────

  Widget zenitCenterUI(bool isMobile) {
    return SingleChildScrollView(
      physics:
          isMobile ? const ClampingScrollPhysics() : const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Zenit",
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 6),

          const Text(
            "Real people. Real conversations.",
            style: TextStyle(
              color: Colors.white70,
              fontSize: 13,
            ),
          ),

          const SizedBox(height: 22),

          const Text(
            "You don’t have to figure it out alone.",
            style: TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 10),

          const Text(
            "Zenit connects you with verified professionals for guidance, "
            "clarity, and meaningful conversations — whenever you need them.",
            style: TextStyle(
              color: Colors.white60,
              fontSize: 13,
              height: 1.5,
            ),
          ),

          const SizedBox(height: 22),
          _zenitPoint("🔒 Private & secure conversations"),
          const SizedBox(height: 10),
          _zenitPoint("👨‍⚕️ Certified & verified experts"),
          const SizedBox(height: 10),
          _zenitPoint("⏰ Flexible sessions at your pace"),

          const SizedBox(height: 26),

          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 14),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              gradient: const LinearGradient(
                colors: [Color(0xFF14F4CC), Color(0xFF3A7BD5)],
              ),
            ),
            child: const Center(
              child: Text(
                "Access & enjoy Zenit",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _zenitPoint(String text) {
    return Text(
      text,
      style: const TextStyle(color: Colors.white70, fontSize: 13),
    );
  }

  // ───────────────── PROJECT DETAILS ─────────────────

  Widget _projectDetails(bool isMobile) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 420),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Zenit — Wellness Platform",
            style: TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 10),

          const Text(
            "Flagship Product",
            style: TextStyle(
              color: Colors.tealAccent,
              fontSize: 13,
              letterSpacing: 1.4,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 18),

          const Text(
            "A modern wellness application focused on habit building, "
            "mental clarity, and long-term user engagement.",
            style: TextStyle(color: Colors.white70, fontSize: 15, height: 1.6),
          ),

          const SizedBox(height: 26),
          _feature("Designed & developed end-to-end"),
          _feature("Scalable BLoC architecture"),
          _feature("Production deployment & monitoring"),
          _feature("Live on Android & iOS"),

          const SizedBox(height: 34),
          _storeButtons(isMobile),
        ],
      ),
    );
  }

  Widget _feature(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          const Icon(Icons.check_circle,
              size: 18, color: Colors.tealAccent),
          const SizedBox(width: 12),
          Expanded(
            child: Text(text,
                style: const TextStyle(color: Colors.white70, fontSize: 14.5)),
          ),
        ],
      ),
    );
  }

  Widget _storeButtons(bool isMobile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _storeButton(
          label: "Google Play",
          icon: Icons.android,
          gradient:
              const LinearGradient(colors: [Color(0xFF34A853), Color(0xFF0F9D58)]),
          onTap: () => _launch(playStoreUrl),
        ),
        const SizedBox(height: 14),
        _storeButton(
          label: "App Store",
          icon: Icons.apple,
          gradient:
              const LinearGradient(colors: [Color(0xFF1C1C1E), Color(0xFF2C2C2E)]),
          onTap: () => _launch(appStoreUrl),
        ),
      ],
    );
  }

  Widget _storeButton({
    required String label,
    required IconData icon,
    required LinearGradient gradient,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: Container(
        width: 220,
        padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          gradient: gradient,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.35),
              blurRadius: 22,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: Colors.white, size: 22),
            const SizedBox(width: 12),
            Text(label,
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 15)),
          ],
        ),
      ),
    );
  }

  Widget _otherProjects() {
    return Column(
      children: const [
        Text(
          "Other Work",
          style: TextStyle(
              color: Colors.white70,
              fontSize: 16,
              fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 20),
        Wrap(
          spacing: 18,
          runSpacing: 14,
          alignment: WrapAlignment.center,
          children: [
            _MiniProjectChip("ERP System"),
            _MiniProjectChip("Admin Dashboard"),
            _MiniProjectChip("Reservation App"),
            _MiniProjectChip("E-commerce App"),
          ],
        ),
      ],
    );
  }

  // ───────────────── HELPERS ─────────────────

  Widget _glassPhone({
    required double width,
    required double height,
    required Gradient gradient,
    double opacity = 1,
    bool isBackground = false,
    Widget? child,
  }) {
    return Opacity(
      opacity: opacity,
      child: Container(
        width: width,
        height: height,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(42),
          border: Border.all(color: Colors.white24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.55),
              blurRadius: isBackground ? 30 : 40,
              offset: const Offset(0, 28),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(32),
          child: Stack(
            children: [
              Container(decoration: BoxDecoration(gradient: gradient)),
              if (isBackground)
                Container(color: Colors.black.withOpacity(0.35)),
              if (child != null) child,
            ],
          ),
        ),
      ),
    );
  }

  Gradient _heroGradient() => const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color(0xFF14F4CC),
          Color(0xFF3A7BD5),
          Color(0xFF1E1E1E),
        ],
      );

  Gradient _softGradient({bool reverse = false}) => LinearGradient(
        begin: reverse ? Alignment.bottomRight : Alignment.topLeft,
        end: reverse ? Alignment.topLeft : Alignment.bottomRight,
        colors: [Colors.white24, Colors.transparent],
      );

  Future<void> _launch(String url) async {
    final uri = Uri.parse(url);
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }
}

class _MiniProjectChip extends StatelessWidget {
  final String title;
  const _MiniProjectChip(this.title);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white24),
        color: Colors.white.withOpacity(0.04),
      ),
      child: Text(
        title,
        style: const TextStyle(
            color: Colors.white70,
            fontSize: 13,
            fontWeight: FontWeight.w600),
      ),
    );
  }
}
