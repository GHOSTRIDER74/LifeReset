// lib/onboarding/screens/anti_identity_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../onboarding_state.dart';

class AntiIdentityScreen extends ConsumerStatefulWidget {
  const AntiIdentityScreen({super.key});

  @override
  ConsumerState<AntiIdentityScreen> createState() => _AntiIdentityScreenState();
}

class _AntiIdentityScreenState extends ConsumerState<AntiIdentityScreen> {
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
    final text = _controller.text.trim();
    if (text.isEmpty) {
      setState(() => _hasError = true);
      return;
    }
    ref.read(onboardingProvider.notifier).setAntiIdentity(text);
    context.go('/onboarding/plan-preview');
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
              const SizedBox(height: 72),

              // ── Warning icon ──
              const Text(
                '⚠️',
                style: TextStyle(fontSize: 36),
              )
              .animate()
              .fadeIn(duration: 400.ms)
              .scale(begin: Offset(0.7, 0.7), end: Offset(1, 1), duration: 400.ms),

              const SizedBox(height: 24),

              // ── Main question ──
              const Text(
                'Who do you NOT\nwant to become?',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.w800,
                  height: 1.3,
                ),
              )
              .animate(delay: 200.ms)
              .fadeIn(duration: 600.ms)
              .slideY(begin: -0.1, end: 0, duration: 600.ms),

              const SizedBox(height: 12),

              const Text(
                'Be brutally honest. This stays between you and the app.',
                style: TextStyle(
                  color: Colors.white38,
                  fontSize: 14,
                  height: 1.5,
                ),
              )
              .animate(delay: 400.ms)
              .fadeIn(duration: 500.ms),

              const SizedBox(height: 40),

              // ── Text input ──
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFF111111),
                          borderRadius: BorderRadius.circular(14),
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
                          maxLines: null,
                          expands: true,
                          textAlignVertical: TextAlignVertical.top,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            height: 1.6,
                          ),
                          decoration: const InputDecoration(
                            hintText:
                                'The version of myself that gives up,\nstays comfortable, never tries...',
                            hintStyle: TextStyle(
                              color: Colors.white24,
                              fontSize: 15,
                              height: 1.6,
                            ),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.all(20),
                          ),
                          onChanged: (_) {
                            if (_hasError) setState(() => _hasError = false);
                          },
                        ),
                      )
                      .animate(delay: 600.ms)
                      .fadeIn(duration: 500.ms),
                    ),

                    if (_hasError) ...[
                      const SizedBox(height: 8),
                      const Text(
                        'You must confront who you don\'t want to be.',
                        style: TextStyle(
                          color: Colors.redAccent,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ],
                ),
              ),

              const SizedBox(height: 24),

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
                    'I KNOW I CAN BE ...',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1.5,
                    ),
                  ),
                ),
              )
              .animate(delay: 800.ms)
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