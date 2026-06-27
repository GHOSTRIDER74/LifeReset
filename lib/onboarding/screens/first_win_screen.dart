// lib/onboarding/screens/first_win_screen.dart

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum _Phase { idle, inhale, holdFull, exhale, holdEmpty, complete }

class FirstWinScreen extends StatefulWidget {
  const FirstWinScreen({super.key});

  @override
  State<FirstWinScreen> createState() => _FirstWinScreenState();
}

class _FirstWinScreenState extends State<FirstWinScreen>
    with TickerProviderStateMixin {

  _Phase _phase = _Phase.idle;
  late final AnimationController _orbController;
  late Animation<double> _orbSize;
  int _secondsLeft = 0;
  int _totalLeft = 14;
  int _dotIndex = 0;
  bool _showConfetti = false;
  final List<_Particle> _particles = [];
  final Random _random = Random();

  @override
  void initState() {
    super.initState();
    _orbController = AnimationController(vsync: this);
    _orbSize = const AlwaysStoppedAnimation<double>(120.0)
        as Animation<double>;
    _orbSize = Tween<double>(begin: 120, end: 120)
        .animate(_orbController);
    for (int i = 0; i < 100; i++) {
      _particles.add(_Particle(random: _random));
    }
  }

  @override
  void dispose() {
    _orbController.dispose();
    super.dispose();
  }

  void _onTap() {
    if (_phase == _Phase.idle) _startBreathing();
    if (_phase == _Phase.complete) _skip();
  }

  void _startBreathing() {
    if (_phase != _Phase.idle) return;
    setState(() { _totalLeft = 14; _dotIndex = 0; });
    _runPhase(_Phase.inhale);
    _tickTotal();
  }

  void _tickTotal() async {
    while (_totalLeft > 0 && mounted && _phase != _Phase.complete) {
      await Future.delayed(const Duration(seconds: 1));
      if (mounted) setState(() => _totalLeft--);
    }
  }

  Future<void> _runPhase(_Phase phase) async {
    if (!mounted) return;
    int duration;
    double targetSize;

    switch (phase) {
      case _Phase.inhale:
        duration = 4; targetSize = 220; _dotIndex = 0;
        break;
      case _Phase.holdFull:
        duration = 4; targetSize = 220; _dotIndex = 1;
        break;
      case _Phase.exhale:
        duration = 4; targetSize = 120; _dotIndex = 2;
        break;
      case _Phase.holdEmpty:
        duration = 2; targetSize = 120; _dotIndex = 3;
        break;
      default: return;
    }

    final currentSize = (_orbSize.value);
    _orbController.stop();
    _orbController.reset();
    _orbSize = Tween<double>(begin: currentSize, end: targetSize).animate(
      CurvedAnimation(parent: _orbController, curve: Curves.easeInOut),
    );
    _orbController.duration = Duration(seconds: duration);
    _orbController.forward(from: 0);

    setState(() { _phase = phase; _secondsLeft = duration; });

    for (int i = duration - 1; i >= 0; i--) {
      await Future.delayed(const Duration(seconds: 1));
      if (!mounted) return;
      setState(() => _secondsLeft = i);
    }

    if (!mounted) return;
    switch (phase) {
      case _Phase.inhale:    await _runPhase(_Phase.holdFull); break;
      case _Phase.holdFull:  await _runPhase(_Phase.exhale);   break;
      case _Phase.exhale:    await _runPhase(_Phase.holdEmpty); break;
      case _Phase.holdEmpty: _complete();                       break;
      default: break;
    }
  }

  void _complete() async {
    setState(() { _phase = _Phase.complete; _showConfetti = true; });
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('onboarding_complete', true);
    await Future.delayed(const Duration(milliseconds: 4500));
    if (mounted) context.go('/home');
  }

  void _skip() async {
    _orbController.stop();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('onboarding_complete', true);
    if (mounted) context.go('/home');
  }

  String get _phaseLabel {
    switch (_phase) {
      case _Phase.inhale:    return 'Inhale';
      case _Phase.holdFull:  return 'Hold';
      case _Phase.exhale:    return 'Exhale';
      case _Phase.holdEmpty: return 'Hold';
      default:               return '';
    }
  }

  String get _phaseSubtitle {
    switch (_phase) {
      case _Phase.inhale:    return 'Breathe in slowly through your nose';
      case _Phase.holdFull:  return 'Hold your breath gently';
      case _Phase.exhale:    return 'Breathe out slowly through your mouth';
      case _Phase.holdEmpty: return 'Hold empty, stay relaxed';
      default:               return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isActive = _phase != _Phase.idle && _phase != _Phase.complete;
    final isComplete = _phase == _Phase.complete;

    return GestureDetector(
      onTap: _onTap,
      child: Scaffold(
        backgroundColor: const Color(0xFF0D0D0D),
        body: Stack(
          children: [

            // ── Confetti ──
            if (_showConfetti)
              ...List.generate(_particles.length, (i) {
                final p = _particles[i];
                return _ConfettiDot(
                  particle: p,
                  screenSize: size,
                );
              }),

            SafeArea(
              child: Stack(
                children: [

                  // Timer top-right
                  if (isActive)
                    Positioned(
                      top: 16, right: 20,
                      child: Text(
                        '0:${_totalLeft.toString().padLeft(2, '0')}',
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 56),

                      // Title
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32),
                        child: Text(
                          isComplete
                              ? 'First win complete!'
                              : "Let's start with your\nfirst win",
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 26,
                            fontWeight: FontWeight.w800,
                            height: 1.3,
                          ),
                        ),
                      ),

                      const Spacer(),

                      // Orb
                      AnimatedBuilder(
                        animation: _orbController,
                        builder: (context, _) {
                          final s = _orbSize.value;
                          return Center(child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                width: s + 60, height: s + 60,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: const Color(0xFFE8560A)
                                      .withValues(alpha: 0.07),
                                ),
                              ),
                              Container(
                                width: s + 28, height: s + 28,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: const Color(0xFFE8560A)
                                      .withValues(alpha: 0.13),
                                ),
                              ),
                              Container(
                                width: s, height: s,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: const RadialGradient(
                                    colors: [
                                      Color(0xFFFF8C42),
                                      Color(0xFFE8560A),
                                      Color(0xFFB33A00),
                                    ],
                                    stops: [0.0, 0.5, 1.0],
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: const Color(0xFFE8560A)
                                          .withValues(alpha: 0.5),
                                      blurRadius: 40,
                                      spreadRadius: 8,
                                    ),
                                  ],
                                ),
                                child: _phase == _Phase.idle
                                    ? const Center(
                                        child: Text(
                                          'Tap to begin',
                                          style: TextStyle(
                                            color: Colors.white54,
                                            fontSize: 14,
                                          ),
                                        ),
                                      )
                                    : null,
                              ),
                            ],
                          ));
                        },
                      ),

                      const Spacer(),

                      // Phase text + dots
                      if (isActive) ...[
                        Text(
                          _phaseLabel,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          _phaseSubtitle,
                          style: const TextStyle(
                            color: Colors.white38,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          '${_secondsLeft}s',
                          style: const TextStyle(
                            color: Colors.white38,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 32),

                        // 4-dot progress
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(4, (i) {
                            final active = i <= _dotIndex;
                            final icons = [
                              Icons.arrow_upward,
                              Icons.pause,
                              Icons.arrow_downward,
                              Icons.pause,
                            ];
                            return Row(
                              children: [
                                AnimatedContainer(
                                  duration: const Duration(milliseconds: 300),
                                  width: 40, height: 40,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: active
                                        ? const Color(0xFFE8560A)
                                        : const Color(0xFF2A2A2A),
                                  ),
                                  child: Icon(
                                    icons[i],
                                    color: active ? Colors.white : Colors.white24,
                                    size: 16,
                                  ),
                                ),
                                if (i < 3)
                                  AnimatedContainer(
                                    duration: const Duration(milliseconds: 300),
                                    width: 28, height: 2,
                                    color: i < _dotIndex
                                        ? const Color(0xFFE8560A)
                                        : const Color(0xFF2A2A2A),
                                  ),
                              ],
                            );
                          }),
                        ),
                        const SizedBox(height: 48),
                      ],

                      // Complete text
                      if (isComplete) ...[
                        const Text(
                          'Your journey begins now.',
                          style: TextStyle(color: Colors.white38, fontSize: 15),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'tap to continue',
                          style: TextStyle(
                            color: Colors.white12,
                            fontSize: 12,
                            letterSpacing: 2,
                          ),
                        ),
                        const SizedBox(height: 60),
                      ],

                      // Skip button
                      if (_phase == _Phase.idle) ...[
                        const SizedBox(height: 24),
                        GestureDetector(
                          onTap: _skip,
                          child: const Text(
                            'Skip',
                            style: TextStyle(color: Colors.white24, fontSize: 15),
                          ),
                        ),
                        const SizedBox(height: 48),
                      ],
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Confetti dot widget ──
class _ConfettiDot extends StatefulWidget {
  final _Particle particle;
  final Size screenSize;

  const _ConfettiDot({required this.particle, required this.screenSize});

  @override
  State<_ConfettiDot> createState() => _ConfettiDotState();
}

class _ConfettiDotState extends State<_ConfettiDot>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _x;
  late final Animation<double> _y;
  late final Animation<double> _opacity;

  @override
  void initState() {
    super.initState();
    final p = widget.particle;
    final sw = widget.screenSize.width;
    final sh = widget.screenSize.height;

    _ctrl = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: p.duration),
    );

    // Start from centre, explode outward
    _x = Tween<double>(
      begin: sw * 0.5,
      end: sw * 0.5 + (p.endX * sw * 0.6),
    ).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOut));

    _y = Tween<double>(
      begin: sh * 0.5,
      end: sh * 0.5 + (p.endY * sh * 0.6),
    ).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOut));

    _opacity = TweenSequence([
      TweenSequenceItem(tween: Tween(begin: 0.0, end: 1.0), weight: 10),
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 1.0), weight: 50),
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 0.0), weight: 40),
    ]).animate(_ctrl);

    Future.delayed(Duration(milliseconds: p.delay), () {
      if (mounted) _ctrl.forward();
    });
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final p = widget.particle;
    return AnimatedBuilder(
      animation: _ctrl,
      builder: (context, _) {
        return Positioned(
          left: _x.value,
          top: _y.value,
          child: Opacity(
            opacity: _opacity.value.clamp(0.0, 1.0),
            child: Transform.rotate(
              angle: p.rotation + _ctrl.value * pi,
              child: Container(
                width: p.size,
                height: p.isRect ? p.size * 1.8 : p.size,
                decoration: BoxDecoration(
                  color: p.color,
                  borderRadius: p.isRect
                      ? BorderRadius.circular(2)
                      : BorderRadius.circular(p.size),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

// ── Particle data ──
class _Particle {
  final double endX;
  final double endY;
  final double size;
  final double rotation;
  final Color color;
  final int delay;
  final int duration;
  final bool isRect;

  static const _colors = [
    Color(0xFFE8560A), Color(0xFFFF8C42), Color(0xFFFFB300),
    Color(0xFF7C4DFF), Color(0xFFE91E63), Color(0xFF1E88E5),
    Color(0xFF43A047), Color(0xFFFFFFFF),
  ];

  _Particle({required Random random})
      : endX = (random.nextDouble() - 0.5) * 2,
        endY = (random.nextDouble() - 0.5) * 2,
        size = 4 + random.nextDouble() * 8,
        rotation = random.nextDouble() * pi * 2,
        color = _colors[random.nextInt(_colors.length)],
        delay = random.nextInt(400),
        duration = 1000 + random.nextInt(800),
        isRect = random.nextBool();
}