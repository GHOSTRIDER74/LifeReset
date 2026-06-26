// lib/onboarding/screens/splash_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Auto-advance after 3.5 seconds
    Future.delayed(const Duration(milliseconds: 3500), () {
      if (mounted) context.go('/onboarding/name');
    });
  }

  void _advance() => context.go('/onboarding/name');

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _advance,
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                // ── App title ──
                const Text(
                  'LIFE RESET',
                  style: TextStyle(
                    color: Color(0xFFE8560A),
                    fontSize: 42,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 8,
                  ),
                )
                .animate()
                .fadeIn(duration: 800.ms)
                .slideY(begin: -0.2, end: 0, duration: 800.ms),

                const SizedBox(height: 24),

                // ── Tagline ──
                const Text(
                  'Become the main character\nof your life.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w300,
                    height: 1.5,
                    letterSpacing: 1.2,
                  ),
                )
                .animate(delay: 600.ms)
                .fadeIn(duration: 800.ms)
                .slideY(begin: 0.2, end: 0, duration: 800.ms),

                const SizedBox(height: 80),

                // ── Tap hint ──
                const Text(
                  'tap to continue',
                  style: TextStyle(
                    color: Colors.white24,
                    fontSize: 13,
                    letterSpacing: 2,
                  ),
                )
                .animate(delay: 1800.ms)
                .fadeIn(duration: 600.ms),

              ],
            ),
          ),
        ),
      ),
    );
  }
}