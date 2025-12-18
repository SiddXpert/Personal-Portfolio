import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:my_portfolio/screens/about_section.dart';
import 'package:my_portfolio/screens/contact_section.dart';
import 'package:my_portfolio/screens/hero_section.dart';
import 'package:my_portfolio/screens/project_section.dart';
import 'package:my_portfolio/screens/skill_section.dart';

enum NavSection { home, about, skills, projects, contact }

class HomeScreen extends StatefulWidget {
  final bool disableInitialAnimation;

  const HomeScreen({
    super.key,
    this.disableInitialAnimation = false,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();

  NavSection activeSection = NavSection.home;
  bool isUserScrolling = false;
  int debounceTime = 0;

  final heroKey = GlobalKey();
  final aboutKey = GlobalKey();
  final skillsKey = GlobalKey();
  final projectsKey = GlobalKey();
  final contactKey = GlobalKey();

  final labels = ["Home", "About", "Skills", "Projects", "Contact"];

  late final List<NavSection> sections = [
    NavSection.home,
    NavSection.about,
    NavSection.skills,
    NavSection.projects,
    NavSection.contact,
  ];

  late final List<GlobalKey> keys = [
    heroKey,
    aboutKey,
    skillsKey,
    projectsKey,
    contactKey,
  ];

  double _navHeight(bool isMobile) => isMobile ? 50 : 64;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScrollUpdate);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  // ─────────────────────────────────────────────
  // SMOOTH SCROLL
  // ─────────────────────────────────────────────
  Future<void> scrollTo(
    GlobalKey key,
    NavSection sec,
    bool isMobile,
  ) async {
    if (isUserScrolling) return;

    isUserScrolling = true;
    setState(() => activeSection = sec);

    final ctx = key.currentContext;
    if (ctx == null) {
      isUserScrolling = false;
      return;
    }

    final box = ctx.findRenderObject() as RenderBox;
    final navOffset = _navHeight(isMobile) + 8;

    final target =
        box.localToGlobal(Offset.zero).dy +
        _scrollController.offset -
        navOffset;

    await _scrollController.animateTo(
      target,
      duration: const Duration(milliseconds: 620),
      curve: Curves.easeInOutCubicEmphasized,
    );

    isUserScrolling = false;
  }

  double _getOffset(GlobalKey key) {
    final ctx = key.currentContext;
    if (ctx == null) return double.infinity;
    final box = ctx.findRenderObject() as RenderBox;
    return box.localToGlobal(Offset.zero).dy +
        _scrollController.offset;
  }

  double _viewportCenter() {
    final h = MediaQuery.of(context).size.height;
    return _scrollController.offset + h * 0.45;
  }

  // ─────────────────────────────────────────────
  // SCROLL → NAV SYNC
  // ─────────────────────────────────────────────
  void _onScrollUpdate() {
    if (isUserScrolling || !_scrollController.hasClients) return;

    final now = DateTime.now().millisecondsSinceEpoch;
    if (now - debounceTime < 120) return;
    debounceTime = now;

    final center = _viewportCenter();
    final maxScroll = _scrollController.position.maxScrollExtent;

    if (_scrollController.offset >= maxScroll - 200) {
      setState(() => activeSection = NavSection.contact);
      return;
    }

    for (int i = 0; i < sections.length - 1; i++) {
      final start = _getOffset(keys[i]);
      final end = _getOffset(keys[i + 1]);

      if (center >= start && center < end) {
        if (activeSection != sections[i]) {
          setState(() => activeSection = sections[i]);
        }
        break;
      }
    }
  }

  int _navIndex(NavSection sec) => sections.indexOf(sec);

  // ─────────────────────────────────────────────
  // UI
  // ─────────────────────────────────────────────
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final bool isMobile = width < 900;

    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.only(top: _navHeight(isMobile) + 8),
          child: _body(isMobile),
        ),
        Positioned(
          top: 10,
          left: 0,
          right: 0,
          child: _glassNavBar(width, isMobile),
        ),
      ],
    );
  }

  Widget _body(bool isMobile) {
    return SingleChildScrollView(
      controller: _scrollController,
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          _anchor(heroKey),
          HeroSection(
            onContactTap: () =>
                scrollTo(contactKey, NavSection.contact, isMobile),
          ),

          _gap(isMobile),
          _anchor(aboutKey),
          const AboutSection(),

          _gap(isMobile),
          _anchor(skillsKey),
          const SkillsSection(),

          _gap(isMobile),
          _anchor(projectsKey),
          const ProjectsSection(),

          _gap(isMobile),
          _anchor(contactKey),
          const ContactSection(),

          const SizedBox(height: 120),
        ],
      ),
    );
  }

  Widget _anchor(GlobalKey key) =>
      SizedBox(key: key, height: 1);

  Widget _gap(bool isMobile) =>
      SizedBox(height: isMobile ? 56 : 80);

  // ─────────────────────────────────────────────
  // MODERN GLASS NAVBAR
  // ─────────────────────────────────────────────
Widget _glassNavBar(double width, bool isMobile) {
  final activeIndex = _navIndex(activeSection);
  final itemWidth = isMobile ? 72.0 : 92.0;

  final navContent = SizedBox(
    height: _navHeight(isMobile),
    width: itemWidth * sections.length,
    child: Stack(
      children: [
        AnimatedPositioned(
          duration: const Duration(milliseconds: 260),
          curve: Curves.easeOutCubic,
          left: itemWidth * activeIndex,
          top: 3,
          bottom: 3,
          child: Container(
            width: itemWidth - 8,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(32),
              color: Colors.white.withOpacity(0.95),
            ),
          ),
        ),
        Row(
          children: List.generate(sections.length, (i) {
            return InkWell(
              borderRadius: BorderRadius.circular(28),
              onTap: () => scrollTo(keys[i], sections[i], isMobile),
              child: SizedBox(
                width: itemWidth,
                child: Center(
                  child: Text(
                    labels[i],
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 12.5,
                      color: activeIndex == i
                          ? Colors.black
                          : Colors.white.withOpacity(0.85),
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
      ],
    ),
  );

  return Center(
    child: ClipRRect(
      borderRadius: BorderRadius.circular(48),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
        child: Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.08),
            borderRadius: BorderRadius.circular(48),
            border: Border.all(color: Colors.white.withOpacity(0.22)),
          ),
          child: isMobile
              ? SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  child: navContent,
                )
              : navContent,
        ),
      ),
    ),
  );
}
}