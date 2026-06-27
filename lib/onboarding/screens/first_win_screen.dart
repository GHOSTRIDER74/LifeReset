// lib/onboarding/screens/first_win_screen.dart

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirstWinScreen extends StatefulWidget {
  const FirstWinScreen({super.key});

  @override
  State<FirstWinScreen> createState() => _FirstWinScreenState();
}

class _FirstWinScreenState extends State<FirstWinScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  final List<_Particle> _particles = [];
  final Random _random = Random();

  @override
  void initState() {
    super.initState();

    // Generate confetti particles
    for (int i = 0; i < 80; i++) {
      _particles.add(_Particle(random: _random));
    }

    // Orb pulse controller
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..repeat(reverse: true);

    // Mark onboarding complete NOW (after First Win is visible)
    // then auto-navigate to home
    _completeAndNavigate();
  }

  Future<void> _completeAndNavigate() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('onboarding_complete', true);

    await Future.delayed(const Duration(milliseconds: 4500));
    if (mounted) context.go('/home');
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () async {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool('onboarding_complete', true);
        if (mounted) context.go('/home');
      },
      child: Scaffold(
        backgroundColor: const Color(0xFF0D0D0D),
        body: Stack(
          children: [
            // ── Confetti layer ──
            ...List.generate(_particles.length, (i) {
              final p = _particles[i];
              return Positioned(
                left: size.width * p.x,
                top: size.height * p.y,
                child: Transform.rotate(
                  angle: p.rotation,
                  child: Container(
                    width: p.size,
                    height: p.size * (p.isRect ? 1.8 : 1),
                    decoration: BoxDecoration(
                      color: p.color,
                      borderRadius: p.isRect
                          ? BorderRadius.circular(2)
                          : BorderRadius.circular(p.size),
                    ),
                  ),
                )
                .animate(delay: Duration(milliseconds: p.delay))
                .fadeIn(duration: 300.ms)
                .moveY(
                  begin: -size.height * 0.15,
                  end: size.height * 0.1,
                  duration: Duration(milliseconds: p.duration),
                  curve: Curves.easeOut,
                )
                .moveX(
                  begin: 0,
                  end: size.width * p.driftX,
                  duration: Duration(milliseconds: p.duration),
                  curve: Curves.easeOut,
                )
                .fadeOut(
                  delay: Duration(milliseconds: p.delay + p.duration ~/ 2),
                  duration: Duration(milliseconds: p.duration ~/ 2),
                ),
              );
            }),

            // ── Main content ──
            SafeArea(
              child: Column(
                children: [
                  const SizedBox(height: 56),

                  // ── Title ──
                  Center(
                child: Text(
                  'First win complete!',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),

                  const Spacer(),

                  // ── Glowing orb ──
                  AnimatedBuilder(
                    animation: _controller,
                    builder: (context, _) {
                      final pulse = _controller.value;
                      return Stack(
                        alignment: Alignment.center,
                        children: [
                          // Outer glow ring
                          Container(
                            width: 220 + (pulse * 30),
                            height: 220 + (pulse * 30),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: const Color(0xFFE8560A)
                                  .withValues(alpha: 0.08 + pulse * 0.06),
                            ),
                          ),
                          // Mid glow ring
                          Container(
                            width: 170 + (pulse * 15),
                            height: 170 + (pulse * 15),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: const Color(0xFFE8560A)
                                  .withValues(alpha: 0.15 + pulse * 0.08),
                            ),
                          ),
                          // Core orb
                          Container(
                            width: 130,
                            height: 130,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: RadialGradient(
                                colors: [
                                  const Color(0xFFFF8C42),
                                  const Color(0xFFE8560A),
                                  const Color(0xFFB33A00),
                                ],
                                stops: const [0.0, 0.5, 1.0],
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0xFFE8560A)
                                      .withValues(alpha: 0.6 + pulse * 0.2),
                                  blurRadius: 40 + pulse * 20,
                                  spreadRadius: 10 + pulse * 5,
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  )
                  .animate(delay: 200.ms)
                  .scale(
                    begin: const Offset(0.3, 0.3),
                    end: const Offset(1.0, 1.0),
                    duration: 800.ms,
                    curve: Curves.elasticOut,
                  )
                  .fadeIn(duration: 400.ms),

                  const Spacer(),

                  // ── XP badge ──
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 12),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1A1A1A),
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(
                        color: const Color(0xFFE8560A).withValues(alpha: 0.3),
                        width: 1,
                      ),
                    ),
                    child: const Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          '⚡',
                          style: TextStyle(fontSize: 18),
                        ),
                        SizedBox(width: 8),
                        Text(
                          '+100 XP',
                          style: TextStyle(
                            color: Color(0xFFE8560A),
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 1,
                          ),
                        ),
                      ],
                    ),
                  )
                  .animate(delay: 600.ms)
                  .fadeIn(duration: 500.ms)
                  .slideY(begin: 0.3, end: 0, duration: 500.ms),

                  const SizedBox(height: 16),

                  const Text(
                    'Your journey begins now.',
                    style: TextStyle(
                      color: Colors.white38,
                      fontSize: 15,
                      letterSpacing: 0.5,
                    ),
                  )
                  .animate(delay: 800.ms)
                  .fadeIn(duration: 500.ms),

                  const SizedBox(height: 20),

                  const Text(
                    'tap to continue',
                    style: TextStyle(
                      color: Colors.white12,
                      fontSize: 12,
                      letterSpacing: 2,
                    ),
                  )
                  .animate(delay: 1400.ms)
                  .fadeIn(duration: 600.ms),

                  const SizedBox(height: 60),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Confetti particle data ──
class _Particle {
  final double x;
  final double y;
  final double size;
  final double rotation;
  final double driftX;
  final Color color;
  final int delay;
  final int duration;
  final bool isRect;

  static const _colors = [
    Color(0xFFE8560A),
    Color(0xFFFF8C42),
    Color(0xFFFFB300),
    Color(0xFF7C4DFF),
    Color(0xFFE91E63),
    Color(0xFF1E88E5),
    Color(0xFF43A047),
    Color(0xFFFFFFFF),
  ];

  _Particle({required Random random})
      : x = random.nextDouble(),
        y = 0.3 + random.nextDouble() * 0.4,
        size = 4 + random.nextDouble() * 8,
        rotation = random.nextDouble() * pi * 2,
        driftX = (random.nextDouble() - 0.5) * 0.4,
        color = _colors[random.nextInt(_colors.length)],
        delay = random.nextInt(600),
        duration = 1200 + random.nextInt(1000),
        isRect = random.nextBool();
}