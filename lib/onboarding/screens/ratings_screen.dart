// lib/onboarding/screens/ratings_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../onboarding_state.dart';

// ── Data: area name + its icon + a one-line description ──
const _areas = [
  {'area': 'Body',       'icon': '💪', 'desc': 'Fitness, movement & physical health'},
  {'area': 'Mind',       'icon': '🧠', 'desc': 'Learning, focus & mental sharpness'},
  {'area': 'Rest',       'icon': '🌙', 'desc': 'Sleep quality & recovery'},
  {'area': 'Fuel',       'icon': '🥗', 'desc': 'Nutrition, hydration & diet'},
  {'area': 'Connection', 'icon': '🤝', 'desc': 'Relationships & social bonds'},
  {'area': 'Purpose',    'icon': '🎯', 'desc': 'Goals, passion & life direction'},
];

class RatingsScreen extends ConsumerStatefulWidget {
  const RatingsScreen({super.key});

  @override
  ConsumerState<RatingsScreen> createState() => _RatingsScreenState();
}

class _RatingsScreenState extends ConsumerState<RatingsScreen> {
  // Local ratings map — written to provider only on Continue
  final Map<String, int> _ratings = {
    'Body': 3,
    'Mind': 3,
    'Rest': 3,
    'Fuel': 3,
    'Connection': 3,
    'Purpose': 3,
  };

  void _continue() {
    // Write all ratings into onboarding state
    for (final entry in _ratings.entries) {
      ref.read(onboardingProvider.notifier).setRating(entry.key, entry.value);
    }
    context.go('/onboarding/anti-identity');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 48),

            // ── Heading ──
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Rate your life\nareas honestly.',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.w800,
                      height: 1.3,
                    ),
                  )
                  .animate()
                  .fadeIn(duration: 600.ms)
                  .slideY(begin: -0.15, end: 0, duration: 600.ms),

                  const SizedBox(height: 8),

                  const Text(
                    '1 = struggling   5 = thriving',
                    style: TextStyle(
                      color: Colors.white38,
                      fontSize: 14,
                      letterSpacing: 0.5,
                    ),
                  )
                  .animate(delay: 200.ms)
                  .fadeIn(duration: 500.ms),
                ],
              ),
            ),

            const SizedBox(height: 32),

            // ── Area cards ──
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                itemCount: _areas.length,
                itemBuilder: (context, index) {
                  final area = _areas[index]['area']!;
                  final icon = _areas[index]['icon']!;
                  final desc = _areas[index]['desc']!;

                  return _AreaRatingCard(
                    area: area,
                    icon: icon,
                    desc: desc,
                    rating: _ratings[area]!,
                    index: index,
                    onRatingChanged: (val) {
                      setState(() => _ratings[area] = val);
                    },
                  );
                },
              ),
            ),

            // ── Continue button ──
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
              child: SizedBox(
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
                    'CONTINUE',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 2,
                    ),
                  ),
                ),
              )
              .animate(delay: 800.ms)
              .fadeIn(duration: 500.ms),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Individual area card with the bar UI ──
class _AreaRatingCard extends StatelessWidget {
  final String area;
  final String icon;
  final String desc;
  final int rating;
  final int index;
  final ValueChanged<int> onRatingChanged;

  const _AreaRatingCard({
    required this.area,
    required this.icon,
    required this.desc,
    required this.rating,
    required this.index,
    required this.onRatingChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          color: const Color(0xFF111111),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: const Color(0xFF2A2A2A),
            width: 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // ── Area name + icon ──
            Row(
              children: [
                Text(icon, style: const TextStyle(fontSize: 20)),
                const SizedBox(width: 10),
                Text(
                  area,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const Spacer(),
                // Current rating number
                Text(
                  '$rating / 5',
                  style: const TextStyle(
                    color: Color(0xFFE8560A),
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 4),

            // ── Description ──
            Text(
              desc,
              style: const TextStyle(
                color: Colors.white38,
                fontSize: 12,
              ),
            ),

            const SizedBox(height: 14),

            // ── The 5-bar tap UI ──
            Row(
              children: List.generate(5, (i) {
                final barValue = i + 1;
                final isActive = barValue <= rating;

                return Expanded(
                  child: GestureDetector(
                    onTap: () => onRatingChanged(barValue),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      margin: const EdgeInsets.symmetric(horizontal: 3),
                      height: 10,
                      decoration: BoxDecoration(
                        color: isActive
                            ? const Color(0xFFE8560A)
                            : const Color(0xFF2A2A2A),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                );
              }),
            ),

          ],
        ),
      )
      .animate(delay: Duration(milliseconds: 300 + (index * 100)))
      .fadeIn(duration: 400.ms)
      .slideX(begin: 0.1, end: 0, duration: 400.ms),
    );
  }
}