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
    Future.delayed(const Duration(milliseconds: 3500), () {
      if (mounted) context.go('/onboarding/name');
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.go('/onboarding/name'),
      child: Scaffold(
        backgroundColor: const Color(0xFF0D0D0D),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Orange glow orb
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(0xFFE8560A),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFFE8560A).withValues(alpha:0.5),
                        blurRadius: 40,
                        spreadRadius: 10,
                      ),
                    ],
                  ),
                )
                .animate()
                .scale(begin: const Offset(0.5, 0.5), end: const Offset(1, 1), duration: 800.ms)
                .fadeIn(duration: 800.ms),

                const SizedBox(height: 40),

                const Text(
                  'LIFE RESET',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 38,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 6,
                  ),
                )
                .animate(delay: 400.ms)
                .fadeIn(duration: 700.ms)
                .slideY(begin: 0.2, end: 0, duration: 700.ms),

                const SizedBox(height: 20),

                const Text(
                  'Become the main character\nof your life.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white60,
                    fontSize: 18,
                    fontWeight: FontWeight.w300,
                    height: 1.6,
                  ),
                )
                .animate(delay: 800.ms)
                .fadeIn(duration: 700.ms),

                const SizedBox(height: 60),

                const Text(
                  'tap to continue',
                  style: TextStyle(
                    color: Colors.white24,
                    fontSize: 12,
                    letterSpacing: 2,
                  ),
                )
                .animate(delay: 1600.ms)
                .fadeIn(duration: 600.ms),
              ],
            ),
          ),
        ),
      ),
    );
  }
}