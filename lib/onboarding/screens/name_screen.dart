// lib/onboarding/screens/name_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../onboarding_state.dart';

class NameScreen extends ConsumerStatefulWidget {
  const NameScreen({super.key});

  @override
  ConsumerState<NameScreen> createState() => _NameScreenState();
}

class _NameScreenState extends ConsumerState<NameScreen> {
  final _controller = TextEditingController();
  final _focusNode = FocusNode();
  bool _hasError = false;

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _continue() {
    final name = _controller.text.trim();
    if (name.isEmpty) {
      setState(() => _hasError = true);
      return;
    }
    ref.read(onboardingProvider.notifier).setName(name);
    context.go('/onboarding/ratings');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 80),

              // ── Heading ──
              const Text(
                'What is your\nname, Hunter?',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 34,
                  fontWeight: FontWeight.w800,
                  height: 1.3,
                ),
              )
              .animate()
              .fadeIn(duration: 600.ms)
              .slideY(begin: -0.15, end: 0, duration: 600.ms),

              const SizedBox(height: 12),

              const Text(
                'This is how you will be known.',
                style: TextStyle(
                  color: Colors.white38,
                  fontSize: 15,
                  letterSpacing: 0.5,
                ),
              )
              .animate(delay: 200.ms)
              .fadeIn(duration: 500.ms),

              const SizedBox(height: 48),

              // ── Text field ──
              AnimatedBuilder(
                animation: _controller,
                builder: (context, _) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFF111111),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: _hasError
                                ? Colors.redAccent
                                : _focusNode.hasFocus
                                    ? const Color(0xFFE8560A)
                                    : const Color(0xFF2A2A2A),
                            width: 1.5,
                          ),
                        ),
                        child: TextField(
                          controller: _controller,
                          focusNode: _focusNode,
                          autofocus: true,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                          decoration: const InputDecoration(
                            hintText: 'Enter your name...',
                            hintStyle: TextStyle(color: Colors.white24),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 18,
                            ),
                          ),
                          onChanged: (_) {
                            if (_hasError) setState(() => _hasError = false);
                          },
                          onSubmitted: (_) => _continue(),
                        ),
                      ),
                      if (_hasError) ...[
                        const SizedBox(height: 8),
                        const Text(
                          'A Hunter must have a name.',
                          style: TextStyle(
                            color: Colors.redAccent,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ],
                  );
                },
              )
              .animate(delay: 400.ms)
              .fadeIn(duration: 500.ms),

              const Spacer(),

              // ── Continue button ──
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: _continue,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFE8560A),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'BEGIN YOUR JOURNEY',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 2,
                    ),
                  ),
                ),
              )
              .animate(delay: 600.ms)
              .fadeIn(duration: 500.ms)
              .slideY(begin: 0.2, end: 0, duration: 500.ms),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}