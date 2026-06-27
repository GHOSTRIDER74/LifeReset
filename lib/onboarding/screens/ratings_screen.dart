// lib/onboarding/screens/ratings_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../onboarding_state.dart';

const _areas = [
  {'area': 'Body',       'icon': '💪', 'desc': 'Fitness & physical health'},
  {'area': 'Mind',       'icon': '🧠', 'desc': 'Learning & mental sharpness'},
  {'area': 'Rest',       'icon': '🌙', 'desc': 'Sleep quality & recovery'},
  {'area': 'Fuel',       'icon': '🥗', 'desc': 'Nutrition & hydration'},
  {'area': 'Connection', 'icon': '🤝', 'desc': 'Relationships & social bonds'},
  {'area': 'Purpose',    'icon': '🎯', 'desc': 'Goals & life direction'},
];

class RatingsScreen extends ConsumerStatefulWidget {
  const RatingsScreen({super.key});

  @override
  ConsumerState<RatingsScreen> createState() => _RatingsScreenState();
}

class _RatingsScreenState extends ConsumerState<RatingsScreen> {
  final Map<String, int> _ratings = {
    'Body': 3, 'Mind': 3, 'Rest': 3,
    'Fuel': 3, 'Connection': 3, 'Purpose': 3,
  };

  void _continue() {
    for (final entry in _ratings.entries) {
      ref.read(onboardingProvider.notifier).setRating(entry.key, entry.value);
    }
    context.go('/onboarding/anti-identity');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0D0D),
      body: SafeArea(
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
                '📊  YOUR LIFE MAP',
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

            const SizedBox(height: 28),

            const Text(
              'Rate your life\nareas honestly.',
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

            const SizedBox(height: 8),

            const Text(
              '1 = struggling    5 = thriving',
              style: TextStyle(color: Colors.white38, fontSize: 14),
            )
            .animate(delay: 350.ms)
            .fadeIn(duration: 500.ms),

            const SizedBox(height: 24),

            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: _areas.length,
                itemBuilder: (context, index) {
                  final area = _areas[index]['area']!;
                  final icon = _areas[index]['icon']!;
                  final desc = _areas[index]['desc']!;
                  return _AreaCard(
                    area: area,
                    icon: icon,
                    desc: desc,
                    rating: _ratings[area]!,
                    index: index,
                    onChanged: (v) => setState(() => _ratings[area] = v),
                  );
                },
              ),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 32),
              child: SizedBox(
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
                      Text('Continue',
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.w700)),
                      SizedBox(width: 8),
                      Icon(Icons.arrow_forward, size: 18),
                    ],
                  ),
                ),
              )
              .animate(delay: 900.ms)
              .fadeIn(duration: 500.ms),
            ),
          ],
        ),
      ),
    );
  }
}

class _AreaCard extends StatelessWidget {
  final String area, icon, desc;
  final int rating, index;
  final ValueChanged<int> onChanged;

  const _AreaCard({
    required this.area, required this.icon, required this.desc,
    required this.rating, required this.index, required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
        decoration: BoxDecoration(
          color: const Color(0xFF1A1A1A),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            // Icon + text
            Text(icon, style: const TextStyle(fontSize: 22)),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(area,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w700)),
                  Text(desc,
                      style: const TextStyle(
                          color: Colors.white38, fontSize: 12)),
                ],
              ),
            ),
            const SizedBox(width: 12),
            // Thick vertical bars (like original)
            Row(
              children: List.generate(5, (i) {
                final active = i < rating;
                return GestureDetector(
                  onTap: () => onChanged(i + 1),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: 8,
                    height: 32,
                    margin: const EdgeInsets.only(left: 4),
                    decoration: BoxDecoration(
                      color: active
                          ? const Color(0xFFE8560A)
                          : const Color(0xFF333333),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                );
              }),
            ),
          ],
        ),
      )
      .animate(delay: Duration(milliseconds: 400 + (index * 80)))
      .fadeIn(duration: 400.ms)
      .slideX(begin: 0.08, end: 0),
    );
  }
}