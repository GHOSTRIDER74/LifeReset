// lib/onboarding/screens/vow_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../onboarding_state.dart';
import '../../data/task_templates.dart';
import '../../database/app_database.dart';

class VowScreen extends ConsumerStatefulWidget {
  const VowScreen({super.key});

  @override
  ConsumerState<VowScreen> createState() => _VowScreenState();
}

class _VowScreenState extends ConsumerState<VowScreen> {
  final List<List<Offset>> _strokes = [];
  List<Offset> _currentStroke = [];
  bool _isSaving = false;

  void _onPanStart(DragStartDetails d) {
    setState(() => _currentStroke = [d.localPosition]);
  }

  void _onPanUpdate(DragUpdateDetails d) {
    setState(() => _currentStroke.add(d.localPosition));
  }

  void _onPanEnd(DragEndDetails d) {
    setState(() {
      if (_currentStroke.isNotEmpty) {
        _strokes.add(List.from(_currentStroke));
        _currentStroke = [];
      }
    });
  }

  void _clearSignature() {
    setState(() {
      _strokes.clear();
      _currentStroke = [];
    });
  }

  Future<void> _accept() async {
    if (_strokes.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Sign the vow with your finger first.'),
          backgroundColor: Color(0xFF1A1A1A),
        ),
      );
      return;
    }

    setState(() => _isSaving = true);

    try {
      final data = ref.read(onboardingProvider);
      final db = AppDatabase();

      // 1 — Insert player
      await db.into(db.players).insert(
        PlayersCompanion.insert(
          name: data.name,
          programStartDate: DateTime.now().toIso8601String(),
        ),
      );

      // 2 — Insert tasks (no playerId in schema)
      final templates = generateTasksForPlayer(data.ratings);
      for (final t in templates) {
        await db.into(db.tasks).insert(
          TasksCompanion.insert(
            title: t.title,
            area: t.area,
            frequency: t.frequency,
            weekNumber: t.weekNumber,
          ),
        );
      }

      await db.close();

      if (mounted) context.go('/onboarding/first-win');
    } catch (e) {
      setState(() => _isSaving = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Something went wrong: $e'),
            backgroundColor: Colors.redAccent,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final today = DateFormat('d.M.yyyy').format(DateTime.now());

    return Scaffold(
      backgroundColor: const Color(0xFF0D0D0D),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 48),

              // ── Title ──
              const Text(
                'Read the Vow',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.w800,
                ),
              )
              .animate()
              .fadeIn(duration: 600.ms)
              .slideY(begin: -0.1, end: 0),

              const SizedBox(height: 28),

              // ── Vow text ──
              const Text(
                '"Over the next 66 days, I vow to stay humble, '
                'disciplined, and resilient, no matter how tough it gets.\n\n'
                'This Life Reset program is my promise and a commitment '
                'to take back control and move forward.\n\n'
                'Even if I stumble, I will rise again and keep going.\n\n'
                'The next 66 days are not done for anyone else. They are '
                'a gift to myself — a step toward growth and transformation."',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 15,
                  height: 1.8,
                  fontStyle: FontStyle.italic,
                ),
              )
              .animate(delay: 300.ms)
              .fadeIn(duration: 700.ms),

              const SizedBox(height: 24),

              // ── Date ──
              Text(
                today,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1,
                ),
              )
              .animate(delay: 500.ms)
              .fadeIn(duration: 500.ms),

              const SizedBox(height: 28),

              // ── Signature canvas ──
              Container(
                height: 180,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xFF1A1A1A),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: _strokes.isEmpty
                        ? const Color(0xFF2A2A2A)
                        : const Color(0xFFE8560A).withValues(alpha: .4),
                    width: 1.5,
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: GestureDetector(
                    onPanStart: _onPanStart,
                    onPanUpdate: _onPanUpdate,
                    onPanEnd: _onPanEnd,
                    child: CustomPaint(
                      painter: _SignaturePainter(
                        strokes: _strokes,
                        currentStroke: _currentStroke,
                      ),
                      child: _strokes.isEmpty && _currentStroke.isEmpty
                          ? const Center(
                              child: Text(
                                'Sign with your finger',
                                style: TextStyle(
                                  color: Colors.white24,
                                  fontSize: 14,
                                ),
                              ),
                            )
                          : null,
                    ),
                  ),
                ),
              )
              .animate(delay: 600.ms)
              .fadeIn(duration: 500.ms),

              const SizedBox(height: 10),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    '*Your signature will not be registered/saved.',
                    style: TextStyle(color: Colors.white24, fontSize: 11),
                  ),
                  GestureDetector(
                    onTap: _clearSignature,
                    child: const Text(
                      'Clear',
                      style: TextStyle(
                        color: Color(0xFFE8560A),
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 40),

              // ── Accept button ──
              SizedBox(
                width: double.infinity,
                height: 58,
                child: ElevatedButton(
                  onPressed: _isSaving ? null : _accept,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFE8560A),
                    foregroundColor: Colors.white,
                    disabledBackgroundColor:
                        const Color(0xFFE8560A).withValues(alpha: .4),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    elevation: 0,
                  ),
                  child: _isSaving
                      ? const SizedBox(
                          width: 22,
                          height: 22,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2.5,
                          ),
                        )
                      : const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'I ACCEPT',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w800,
                                letterSpacing: 1.5,
                              ),
                            ),
                            SizedBox(width: 8),
                            Icon(Icons.arrow_forward, size: 18),
                          ],
                        ),
                ),
              )
              .animate(delay: 800.ms)
              .fadeIn(duration: 500.ms)
              .slideY(begin: 0.2, end: 0),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Signature painter ──
class _SignaturePainter extends CustomPainter {
  final List<List<Offset>> strokes;
  final List<Offset> currentStroke;

  _SignaturePainter({required this.strokes, required this.currentStroke});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 2.5
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..style = PaintingStyle.stroke;

    for (final stroke in strokes) {
      _drawStroke(canvas, stroke, paint);
    }
    _drawStroke(canvas, currentStroke, paint);
  }

  void _drawStroke(Canvas canvas, List<Offset> points, Paint paint) {
    if (points.length < 2) return;
    final path = Path()..moveTo(points.first.dx, points.first.dy);
    for (int i = 1; i < points.length; i++) {
      path.lineTo(points[i].dx, points[i].dy);
    }
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_SignaturePainter old) => true;
}