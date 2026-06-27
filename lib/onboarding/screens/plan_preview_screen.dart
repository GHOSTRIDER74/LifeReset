// lib/onboarding/screens/plan_preview_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../onboarding_state.dart';
import '../../data/task_templates.dart';

class PlanPreviewScreen extends ConsumerStatefulWidget {
  const PlanPreviewScreen({super.key});

  @override
  ConsumerState<PlanPreviewScreen> createState() => _PlanPreviewScreenState();
}

class _PlanPreviewScreenState extends ConsumerState<PlanPreviewScreen> {
  late final List<TaskTemplate> _tasks;
  late final Map<int, List<TaskTemplate>> _byWeek;

  @override
  void initState() {
    super.initState();
    final ratings = ref.read(onboardingProvider).ratings;
    _tasks = generateTasksForPlayer(ratings);
    _byWeek = {};
    for (final task in _tasks) {
      _byWeek.putIfAbsent(task.weekNumber, () => []).add(task);
    }
  }

  @override
  Widget build(BuildContext context) {
    final sortedWeeks = _byWeek.keys.toList()..sort();

    return Scaffold(
      backgroundColor: const Color(0xFF0D0D0D),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 40, 24, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Your next 66 days 🗓️',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.w800,
                    ),
                  )
                  .animate()
                  .fadeIn(duration: 600.ms)
                  .slideY(begin: -0.1, end: 0),

                  const SizedBox(height: 8),

                  Text(
                    'The program is personalized on your current lifestyle.\nTap on a week for your detailed routine.',
                    style: const TextStyle(
                      color: Colors.white38,
                      fontSize: 13,
                      height: 1.5,
                    ),
                  )
                  .animate(delay: 200.ms)
                  .fadeIn(duration: 500.ms),
                ],
              ),
            ),

            const SizedBox(height: 20),

            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: sortedWeeks.length,
                itemBuilder: (context, index) {
                  final week = sortedWeeks[index];
                  final weekTasks = _byWeek[week]!;
                  return _WeekRow(
                    weekNumber: week,
                    tasks: weekTasks,
                    index: index,
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
                  onPressed: () => context.go('/onboarding/vow'),
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
                      Text('I ACCEPT THIS CHALLENGE',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w800,
                              letterSpacing: 1)),
                      SizedBox(width: 8),
                      Icon(Icons.arrow_forward, size: 18),
                    ],
                  ),
                ),
              )
              .animate(delay: 500.ms)
              .fadeIn(duration: 500.ms),
            ),
          ],
        ),
      ),
    );
  }
}

class _WeekRow extends StatelessWidget {
  final int weekNumber;
  final List<TaskTemplate> tasks;
  final int index;

  const _WeekRow({
    required this.weekNumber,
    required this.tasks,
    required this.index,
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Week header row
            Row(
              children: [
                Text(
                  'Week $weekNumber',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  '${tasks.length} quest${tasks.length == 1 ? '' : 's'}',
                  style: const TextStyle(color: Colors.white38, fontSize: 13),
                ),
              ],
            ),
            const SizedBox(height: 12),
            // Task list
            ...tasks.map((t) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                children: [
                  Container(
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(
                      color: const Color(0xFF0D0D0D),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(Icons.check_circle_outline,
                        color: Color(0xFFE8560A), size: 16),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(t.title,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w500)),
                        Text(
                          '${t.frequency}  ·  ${t.area}',
                          style: const TextStyle(
                              color: Color(0xFFE8560A), fontSize: 11),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )),
          ],
        ),
      )
      .animate(delay: Duration(milliseconds: 200 + (index * 60)))
      .fadeIn(duration: 400.ms)
      .slideX(begin: 0.06, end: 0),
    );
  }
}