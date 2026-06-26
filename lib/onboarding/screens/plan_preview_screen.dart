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

    // Group tasks by weekNumber
    _byWeek = {};
    for (final task in _tasks) {
      _byWeek.putIfAbsent(task.weekNumber, () => []).add(task);
    }
  }

  @override
  Widget build(BuildContext context) {
    final sortedWeeks = _byWeek.keys.toList()..sort();

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 48),

            // ── Header ──
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Your next 66 days.',
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

                  Text(
                    '${_tasks.length} quests across ${_byWeek.length} weeks — built for you.',
                    style: const TextStyle(
                      color: Colors.white38,
                      fontSize: 14,
                      height: 1.5,
                    ),
                  )
                  .animate(delay: 200.ms)
                  .fadeIn(duration: 500.ms),
                ],
              ),
            ),

            const SizedBox(height: 28),

            // ── Week list ──
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                itemCount: sortedWeeks.length,
                itemBuilder: (context, index) {
                  final week = sortedWeeks[index];
                  final weekTasks = _byWeek[week]!;

                  return _WeekCard(
                    weekNumber: week,
                    tasks: weekTasks,
                    index: index,
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
                  onPressed: () => context.go('/onboarding/vow'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFE8560A),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'I ACCEPT THIS CHALLENGE',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 2,
                    ),
                  ),
                ),
              )
              .animate(delay: 600.ms)
              .fadeIn(duration: 500.ms),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Week card ──
class _WeekCard extends StatelessWidget {
  final int weekNumber;
  final List<TaskTemplate> tasks;
  final int index;

  const _WeekCard({
    required this.weekNumber,
    required this.tasks,
    required this.index,
  });

  // Difficulty label based on week number
  String get _difficultyLabel {
    if (weekNumber <= 3) return 'Foundation';
    if (weekNumber <= 6) return 'Building';
    return 'Elite';
  }

  Color get _difficultyColor {
    if (weekNumber <= 3) return const Color(0xFF4CAF50);
    if (weekNumber <= 6) return const Color(0xFFFF9800);
    return const Color(0xFFE8560A);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Container(
        padding: const EdgeInsets.all(18),
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

            // ── Week header ──
            Row(
              children: [
                Text(
                  'Week $weekNumber',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: _difficultyColor.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(
                      color: _difficultyColor.withOpacity(0.4),
                      width: 1,
                    ),
                  ),
                  child: Text(
                    _difficultyLabel,
                    style: TextStyle(
                      color: _difficultyColor,
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const Spacer(),
                Text(
                  '${tasks.length} quest${tasks.length == 1 ? '' : 's'}',
                  style: const TextStyle(
                    color: Colors.white38,
                    fontSize: 12,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),
            const Divider(color: Color(0xFF2A2A2A), height: 1),
            const SizedBox(height: 12),

            // ── Task chips ──
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: tasks.map((task) => _TaskChip(task: task)).toList(),
            ),
          ],
        ),
      )
      .animate(delay: Duration(milliseconds: 200 + (index * 80)))
      .fadeIn(duration: 400.ms)
      .slideX(begin: 0.08, end: 0, duration: 400.ms),
    );
  }
}

// ── Individual task chip ──
class _TaskChip extends StatelessWidget {
  final TaskTemplate task;

  const _TaskChip({required this.task});

  // Area colour coding
  Color get _areaColor {
    switch (task.area) {
      case 'Body':       return const Color(0xFFE8560A);
      case 'Mind':       return const Color(0xFF7C4DFF);
      case 'Rest':       return const Color(0xFF1E88E5);
      case 'Fuel':       return const Color(0xFF43A047);
      case 'Connection': return const Color(0xFFE91E63);
      case 'Purpose':    return const Color(0xFFFFB300);
      default:           return Colors.white38;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: _areaColor.withOpacity(0.12),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: _areaColor.withOpacity(0.35),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color: _areaColor,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 6),
          Text(
            task.title,
            style: TextStyle(
              color: _areaColor.withOpacity(0.9),
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}