import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_portfolio/appbootstrap.dart';

import 'package:my_portfolio/widgets/theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const PortfolioApp());
}

class PortfolioApp extends StatefulWidget {
  const PortfolioApp({Key? key}) : super(key: key);

  @override
  State<PortfolioApp> createState() => _PortfolioAppState();
}

class _PortfolioAppState extends State<PortfolioApp> {
  
  bool isDark = true;

  void toggleTheme() {
    setState(() => isDark = !isDark);
  }

  @override
  Widget build(BuildContext context) {
    final baseTheme = isDark ? AppTheme.darkTheme : AppTheme.lightTheme;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'M Siddharth — Portfolio',

      /// 🎨 THEME (GLOBAL)
      theme: baseTheme.copyWith(
        textTheme: GoogleFonts.spaceGroteskTextTheme(
          baseTheme.textTheme,
        ),
        scaffoldBackgroundColor: Colors.transparent, // IMPORTANT
      ),

      /// 🚀 APP BOOTSTRAP (NO WHITE SCREEN)
      home: const AppBootstrap(),
    );
  }
}
