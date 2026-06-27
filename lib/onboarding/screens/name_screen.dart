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
      backgroundColor: const Color(0xFF0D0D0D),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 48),

              // Orange pill badge
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
                  '👋  HELLO HUNTER',
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
                'What is your\nname?',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 36,
                  fontWeight: FontWeight.w800,
                  height: 1.25,
                ),
              )
              .animate(delay: 200.ms)
              .fadeIn(duration: 600.ms)
              .slideY(begin: 0.1, end: 0, duration: 600.ms),

              const SizedBox(height: 12),

              const Text(
                'This is how you will be known.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white38,
                  fontSize: 15,
                ),
              )
              .animate(delay: 350.ms)
              .fadeIn(duration: 500.ms),

              const SizedBox(height: 48),

              // Text field
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF1A1A1A),
                  borderRadius: BorderRadius.circular(16),
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
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                  decoration: const InputDecoration(
                    hintText: 'Enter your name...',
                    hintStyle: TextStyle(color: Colors.white24, fontSize: 18),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 20,
                    ),
                  ),
                  onChanged: (_) {
                    if (_hasError) setState(() => _hasError = false);
                  },
                  onSubmitted: (_) => _continue(),
                ),
              )
              .animate(delay: 500.ms)
              .fadeIn(duration: 500.ms),

              if (_hasError) ...[
                const SizedBox(height: 10),
                const Text(
                  'A Hunter must have a name.',
                  style: TextStyle(color: Colors.redAccent, fontSize: 13),
                ),
              ],

              const Spacer(),

              // Pill button
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
                      Text(
                        'Continue',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(width: 8),
                      Icon(Icons.arrow_forward, size: 18),
                    ],
                  ),
                ),
              )
              .animate(delay: 700.ms)
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