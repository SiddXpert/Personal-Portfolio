import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  static const String email = "officialsiddharth708@gmail.com";
  static const String github = "https://github.com/SiddXpert";
  static const String linkedin =
      "https://www.linkedin.com/in/m-siddharth-1a9759329/";

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final bool isMobile = width < 800;

    return Padding(
      padding: EdgeInsets.only(
        top: isMobile ? 70 : 90,
        bottom: isMobile ? 90 : 120,
        left: 20,
        right: 20,
      ),
      child: Center(
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            /// subtle top accent
            Container(
              width: 140,
              height: 4,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                gradient: LinearGradient(
                  colors: [
                    Colors.transparent,
                    Colors.tealAccent.withOpacity(0.7),
                    Colors.transparent,
                  ],
                ),
              ),
            ),

            ClipRRect(
              borderRadius: BorderRadius.circular(26),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 22, sigmaY: 22),
                child: Container(
                  width: 1000,
                  padding: EdgeInsets.symmetric(
                    vertical: isMobile ? 42 : 56,
                    horizontal: isMobile ? 26 : 52,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(26),
                    color: Colors.white.withOpacity(0.06),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.18),
                    ),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "Let’s work together",
                        style: TextStyle(
                          fontSize: isMobile ? 28 : 32,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),

                      const SizedBox(height: 12),

                      Text(
                        "Choose how you’d like to connect.\n"
                        "I’m always open to meaningful conversations.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: isMobile ? 15 : 16,
                          height: 1.6,
                          color: Colors.white.withOpacity(0.75),
                        ),
                      ),

                      const SizedBox(height: 18),

                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.tealAccent.withOpacity(0.10),
                          border: Border.all(
                            color: Colors.tealAccent.withOpacity(0.30),
                          ),
                        ),
                        child: const Text(
                          "Open for freelance · internships · full-time roles",
                          style: TextStyle(
                            color: Colors.tealAccent,
                            fontSize: 13.5,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),

                      const SizedBox(height: 30),

                      Container(
                        width: 90,
                        height: 2,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          gradient: LinearGradient(
                            colors: [
                              Colors.transparent,
                              Colors.tealAccent.withOpacity(0.7),
                              Colors.transparent,
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 34),

                      Wrap(
                        spacing: 26,
                        runSpacing: 20,
                        alignment: WrapAlignment.center,
                        children: [
                          _contactIcon(
                            icon: FontAwesomeIcons.linkedin,
                            label: "LinkedIn",
                            url: linkedin,
                          ),
                          _contactIcon(
                            icon: FontAwesomeIcons.github,
                            label: "GitHub",
                            url: github,
                          ),
                          _contactIcon(
                            icon: Icons.email_rounded,
                            label: "Email",
                            url: "mailto:$email",
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// CLEAN ICON BUTTON
  Widget _contactIcon({
    required IconData icon,
    required String label,
    required String url,
  }) {
    return InkWell(
      onTap: () => _launch(url),
      borderRadius: BorderRadius.circular(18),
      hoverColor: Colors.transparent,
      child: Column(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withOpacity(0.07),
              border: Border.all(
                color: Colors.white.withOpacity(0.25),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.25),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Icon(icon, color: Colors.white, size: 22),
          ),
          const SizedBox(height: 10),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  static Future<void> _launch(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      debugPrint("Could not launch $url");
    }
  }
}
