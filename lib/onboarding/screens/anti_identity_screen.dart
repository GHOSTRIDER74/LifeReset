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
  void initState() {
    super.initState();
    _focusNode.addListener(() => setState(() {}));
  }

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
      backgroundColor: const Color(0xFF0D0D0D),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 48),

              // Badge
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                decoration: BoxDecoration(
                  color: const Color(0xFFE8560A).withValues(alpha: .15),
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(
                    color: const Color(0xFFE8560A).withValues(alpha: .4),
                    width: 1,
                  ),
                ),
                child: const Text(
                  '🪞  YOUR SHADOW SELF',
                  style: TextStyle(
                    color: Color(0xFFE8560A),
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.5,
                  ),
                ),
              )
              .animate()
              .fadeIn(duration: 500.ms),

              const SizedBox(height: 32),

              const Text(
                'Who do you NOT\nwant to become?',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 34,
                  fontWeight: FontWeight.w800,
                  height: 1.25,
                ),
              )
              .animate(delay: 200.ms)
              .fadeIn(duration: 600.ms)
              .slideY(begin: 0.1, end: 0),

              const SizedBox(height: 12),

              const Text(
                'Be brutally honest.\nThis stays between you and the app.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white38,
                  fontSize: 14,
                  height: 1.5,
                ),
              )
              .animate(delay: 350.ms)
              .fadeIn(duration: 500.ms),

              const SizedBox(height: 36),

              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF1A1A1A),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: _hasError
                          ? Colors.redAccent
                          : _focusNode.hasFocus
                              ? const Color(0xFFE8560A)
                              : Colors.transparent,
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
                      height: 1.7,
                    ),
                    decoration: const InputDecoration(
                      hintText: 'The version of myself that gives up,\nstays comfortable, never tries...',
                      hintStyle: TextStyle(color: Colors.white12, fontSize: 15, height: 1.7),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(22),
                    ),
                    onChanged: (_) {
                      if (_hasError) setState(() => _hasError = false);
                    },
                  ),
                )
                .animate(delay: 500.ms)
                .fadeIn(duration: 500.ms),
              ),

              if (_hasError) ...[
                const SizedBox(height: 8),
                const Text(
                  'You must confront who you don\'t want to be.',
                  style: TextStyle(color: Colors.redAccent, fontSize: 13),
                ),
              ],

              const SizedBox(height: 20),

              SizedBox(
                width: double.infinity,
                height: 58,
                child: ElevatedButton(
                  onPressed: _continue,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFE8560A),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    elevation: 0,
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('I REFUSE TO BE THIS',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w800,
                              letterSpacing: 1)),
                      SizedBox(width: 8),
                      Icon(Icons.arrow_forward, size: 18),
                    ],
                  ),
                ),
              )
              .animate(delay: 700.ms)
              .fadeIn(duration: 500.ms)
              .slideY(begin: 0.2, end: 0),

              const SizedBox(height: 36),
            ],
          ),
        ),
      ),
    );
  }
}