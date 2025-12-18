import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SkillsSection extends StatefulWidget {
  const SkillsSection({super.key});

  @override
  State<SkillsSection> createState() => _SkillsSectionState();
}

class _SkillsSectionState extends State<SkillsSection>
    with SingleTickerProviderStateMixin {
  late AnimationController _orbitCtrl;

  String activeTitle = "Flutter";
  String leftDesc =
      "A modern UI toolkit for building natively compiled applications.";
  String rightDesc =
      "Built multiple production apps with clean UI, animations, and scalability.";

  final List<_Skill> skills = const [
    _Skill(
      "State",
      "BLoC / Provider",
      "Manages application state in a predictable and scalable way.",
      "Used BLoC to manage complex flows, API states, and UI events.",
    ),
    _Skill(
      "Routing",
      "GoRouter",
      "Declarative routing with deep linking support.",
      "Implemented guarded routes and deep links in production apps.",
    ),
    _Skill(
      "Backend",
      "Firebase",
      "Backend services like auth, notifications, and analytics.",
      "Integrated Firebase Auth, FCM, Crashlytics in live apps.",
    ),
    _Skill(
      "Database",
      "Supabase",
      "PostgreSQL-based backend with realtime capabilities.",
      "Used Supabase for auth, database, and real-time updates.",
    ),
    _Skill(
      "APIs",
      "REST",
      "Communication layer between frontend and backend.",
      "Consumed REST APIs with proper error handling and models.",
    ),
    _Skill(
      "Platforms",
      "Android / iOS",
      "Multi-platform deployment with a single codebase.",
      "Shipped apps on both Play Store and App Store.",
    ),
    _Skill(
      "Web",
      "Flutter Web",
      "Web support using Flutter rendering engine.",
      "Built responsive web dashboards and portfolios.",
    ),
    _Skill(
      "Tools",
      "Git / CI",
      "Development and deployment automation tools.",
      "Used Git, CI pipelines, and version control daily.",
    ),
  ];

  @override
  void initState() {
    super.initState();
    _orbitCtrl =
        AnimationController(vsync: this, duration: const Duration(seconds: 80))
          ..repeat();
  }

  @override
  void dispose() {
    _orbitCtrl.dispose();
    super.dispose();
  }

  void updateInfo(_Skill skill) {
    setState(() {
      activeTitle = skill.title;
      leftDesc = skill.about;
      rightDesc = skill.usage;
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool isMobile = MediaQuery.of(context).size.width < 900;

    return Padding(
      padding: EdgeInsets.only(
        top: isMobile ? 60 : 100,
        bottom: isMobile ? 80 : 120,
      ),
      child: Column(
        children: [
          Text(
            "<Skills />",
            style: GoogleFonts.spaceGrotesk(
              fontSize: 18,
              letterSpacing: 2,
              color: Colors.tealAccent,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            "Technology Stack",
            style: GoogleFonts.spaceGrotesk(
              fontSize: isMobile ? 32 : 44,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 14),
          Text(
            isMobile
                ? "Tap a skill to see details"
                : "Hover or tap a skill to explore details",
            style: const TextStyle(color: Colors.white60),
          ),
          const SizedBox(height: 70),

          if (isMobile) _mobileSkills(),
          if (!isMobile) _desktopOrbit(),
        ],
      ),
    );
  }

  // ───────────────────────── MOBILE ─────────────────────────

  Widget _mobileSkills() {
    return Column(
      children: [
        _coreSkill(),
        const SizedBox(height: 28),

        Wrap(
          spacing: 14,
          runSpacing: 14,
          alignment: WrapAlignment.center,
          children: skills.map((s) {
            return GestureDetector(
              onTap: () => updateInfo(s),
              child: _glassSkillCard(s),
            );
          }).toList(),
        ),

        const SizedBox(height: 32),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22),
          child: _detailsCard(),
        ),
      ],
    );
  }

  Widget _glassSkillCard(_Skill s) {
    return Container(
      width: 150,
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.white24),
        color: Colors.white.withOpacity(0.06),
      ),
      child: Column(
        children: [
          Text(
            s.title,
            style: GoogleFonts.spaceGrotesk(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            s.sub,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 11, color: Colors.white60),
          ),
        ],
      ),
    );
  }

  Widget _detailsCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: Colors.white24),
        color: Colors.white.withOpacity(0.04),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            activeTitle,
            style: GoogleFonts.spaceGrotesk(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Colors.tealAccent,
            ),
          ),
          const SizedBox(height: 12),
          Text(leftDesc,
              style:
                  const TextStyle(color: Colors.white70, height: 1.6)),
          const SizedBox(height: 8),
          Text(rightDesc,
              style:
                  const TextStyle(color: Colors.white60, height: 1.6)),
        ],
      ),
    );
  }

  // ───────────────────────── DESKTOP + TABLET ─────────────────────────

  Widget _desktopOrbit() {
    const double visualSize = 560;
    const double canvasSize = visualSize + 140;

    return SizedBox(
      width: visualSize + 520,
      height: visualSize,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            left: 0,
            child: _sideText("ABOUT", activeTitle, leftDesc, true),
          ),
          Positioned(
            right: 0,
            child: _sideText("IN PROJECTS", activeTitle, rightDesc, false),
          ),

          Center(
            child: OverflowBox(
              maxWidth: canvasSize,
              maxHeight: canvasSize,
              child: AnimatedBuilder(
                animation: _orbitCtrl,
                builder: (_, __) {
                  final t = _orbitCtrl.value * 2 * pi;

                  return Stack(
                    alignment: Alignment.center,
                    children: [
                      _orbitRing(visualSize * 0.86),
                      _orbitRing(visualSize * 0.66),
                      _orbitRing(visualSize * 0.46),
                      _coreSkill(),

                      for (int i = 0; i < skills.length; i++)
                        _floatingSkill(
                          skill: skills[i],
                          angle: t * (0.4 + i * 0.15) + i,
                          radius:
                              visualSize * (0.22 + (i % 3) * 0.1),
                        ),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _floatingSkill({
    required _Skill skill,
    required double angle,
    required double radius,
  }) {
    return Transform.translate(
      offset: Offset(cos(angle) * radius, sin(angle) * radius),
      child: MouseRegion(
        onEnter: (_) => updateInfo(skill),
        child: GestureDetector(
          onTap: () => updateInfo(skill),
          child: _orbitCard(skill.title, skill.sub),
        ),
      ),
    );
  }

  Widget _sideText(
      String label, String title, String desc, bool alignRight) {
    return SizedBox(
      width: 230,
      child: Column(
        crossAxisAlignment:
            alignRight ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(label,
              style: const TextStyle(
                  fontSize: 11,
                  letterSpacing: 2,
                  color: Colors.white38)),
          const SizedBox(height: 6),
          Text(title.toUpperCase(),
              textAlign: alignRight ? TextAlign.right : TextAlign.left,
              style: const TextStyle(
                  color: Colors.tealAccent,
                  fontSize: 13,
                  letterSpacing: 2,
                  fontWeight: FontWeight.w600)),
          const SizedBox(height: 10),
          Text(desc,
              textAlign: alignRight ? TextAlign.right : TextAlign.left,
              style: const TextStyle(
                  color: Colors.white70, height: 1.6)),
        ],
      ),
    );
  }

  Widget _orbitCard(String title, String sub) {
    return Container(
      width: 104,
      height: 70,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white24),
        color: Colors.white.withOpacity(0.06),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(title,
              style: GoogleFonts.spaceGrotesk(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Colors.white)),
          const SizedBox(height: 3),
          Text(sub,
              textAlign: TextAlign.center,
              style:
                  const TextStyle(fontSize: 10.5, color: Colors.white60)),
        ],
      ),
    );
  }

  Widget _coreSkill() {
    return Container(
      width: 160,
      height: 160,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        gradient:
            LinearGradient(colors: [Color(0xFF14F4CC), Color(0xFF3A7BD5)]),
      ),
      child: Center(
        child: Text("Flutter",
            style: GoogleFonts.spaceGrotesk(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black)),
      ),
    );
  }

  Widget _orbitRing(double size) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white10),
      ),
    );
  }
}

// ───────────────────────── MODEL ─────────────────────────

class _Skill {
  final String title;
  final String sub;
  final String about;
  final String usage;

  const _Skill(this.title, this.sub, this.about, this.usage);
}
