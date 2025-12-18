import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class HeroSection extends StatefulWidget {
  final VoidCallback onContactTap;

  const HeroSection({super.key, required this.onContactTap});

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _fade;
  late final Animation<Offset> _nameSlide;
  late final Animation<Offset> _subSlide;
  late final Animation<Offset> _btnSlide;

  @override
  void initState() {
    super.initState();

    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    );

    _fade = CurvedAnimation(
      parent: _ctrl,
      curve: const Interval(0.0, 0.6, curve: Curves.easeInOut),
    );

    _nameSlide = Tween<Offset>(
      begin: const Offset(0, 0.1),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _ctrl,
        curve: const Interval(0.0, 0.5, curve: Curves.easeOutExpo),
      ),
    );

    _subSlide = Tween<Offset>(
      begin: const Offset(0, 0.15),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _ctrl,
        curve: const Interval(0.2, 0.7, curve: Curves.easeOutExpo),
      ),
    );

    _btnSlide = Tween<Offset>(
      begin: const Offset(0, 0.2),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _ctrl,
        curve: const Interval(0.4, 1.0, curve: Curves.easeOutExpo),
      ),
    );

    _ctrl.forward();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isMobile = constraints.maxWidth < 900;

        // ✅ Balanced typography
        final double nameSize = isMobile ? 32 : 44;
        final double subSize = isMobile ? 22 : 36;

        return Container(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1100),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  /// TAGLINE
                  FadeTransition(
                    opacity: _fade,
                    child: Text(
                      "<< PORTFOLIO >>",
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 10,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 5.0,
                        color: const Color(0xFF14F4CC).withOpacity(0.6),
                      ),
                    ),
                  ),

                  const SizedBox(height: 28),

                  /// NAME
                  SlideTransition(
                    position: _nameSlide,
                    child: FadeTransition(
                      opacity: _fade,
                      child: Text(
                        "M Siddharth",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.syne(
                          fontSize: nameSize,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.6,
                          foreground: Paint()
                            ..shader = const LinearGradient(
                              colors: [
                                Colors.white,
                                Color(0xFF14F4CC),
                              ],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ).createShader(
                              const Rect.fromLTWH(0, 0, 260, 60),
                            ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  /// SUBTITLE
                  SlideTransition(
                    position: _subSlide,
                    child: FadeTransition(
                      opacity: _fade,
                      child: Column(
                        children: [
                          Text(
                            "Crafting high-fidelity mobile experiences",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.instrumentSerif(
                              fontSize: subSize,
                              fontStyle: FontStyle.italic,
                              color: Colors.white.withOpacity(0.85),
                            ),
                          ),
                          const SizedBox(height: 18),
                          Text(
                            "Flutter Specialist focused on micro-interactions and scalable architecture.",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.inter(
                              fontSize: isMobile ? 14 : 17,
                              fontWeight: FontWeight.w300,
                              height: 1.6,
                              color: Colors.white54,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 46),

                  /// BUTTONS
                  SlideTransition(
                    position: _btnSlide,
                    child: FadeTransition(
                      opacity: _fade,
                      child: Wrap(
                        spacing: 25,
                        runSpacing: 15,
                        alignment: WrapAlignment.center,
                        children: [
                          _buildModernButton(
                            "Contact Me",
                            widget.onContactTap,
                            true,
                          ),
                          _buildModernButton(
                            "Resume",
                            _downloadResume,
                            false,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildModernButton(
      String label, VoidCallback onTap, bool primary) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(2),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
        decoration: BoxDecoration(
          color: primary ? const Color(0xFF14F4CC) : Colors.transparent,
          borderRadius: BorderRadius.circular(2),
          border: Border.all(
            color: primary ? const Color(0xFF14F4CC) : Colors.white24,
            width: 1.2,
          ),
        ),
        child: Text(
          label.toUpperCase(),
          style: GoogleFonts.plusJakartaSans(
            color: primary ? Colors.black : Colors.white,
            fontSize: 11,
            fontWeight: FontWeight.w900,
            letterSpacing: 2.0,
          ),
        ),
      ),
    );
  }

  static Future<void> _downloadResume() async {
    final uri = Uri.parse(
      "https://drive.google.com/file/d/1xBeMrb0wfrjVYLcOCGZE-hE_E7eB1zYn/view",
    );
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
}
