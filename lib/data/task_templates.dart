// lib/data/task_templates.dart

class TaskTemplate {
  final String area;
  final int weekNumber;
  final String title;
  final int frequencyPerWeek;

  const TaskTemplate({
    required this.area,
    required this.weekNumber,
    required this.title,
    required this.frequencyPerWeek,
  });
}

const List<TaskTemplate> allTaskTemplates = [

  // ─────────────────────────────────────────
  // BODY
  // ─────────────────────────────────────────
  TaskTemplate(area: 'Body', weekNumber: 1, title: 'Run 2km', frequencyPerWeek: 2),
  TaskTemplate(area: 'Body', weekNumber: 2, title: 'Run 3km', frequencyPerWeek: 2),
  TaskTemplate(area: 'Body', weekNumber: 3, title: 'Run 4km', frequencyPerWeek: 3),
  TaskTemplate(area: 'Body', weekNumber: 4, title: 'Run 4km + 20 push-ups', frequencyPerWeek: 3),
  TaskTemplate(area: 'Body', weekNumber: 5, title: 'Run 5km', frequencyPerWeek: 3),
  TaskTemplate(area: 'Body', weekNumber: 6, title: 'Run 5km + bodyweight circuit', frequencyPerWeek: 3),
  TaskTemplate(area: 'Body', weekNumber: 7, title: 'Run 6km', frequencyPerWeek: 4),
  TaskTemplate(area: 'Body', weekNumber: 8, title: 'Run 6km + strength session', frequencyPerWeek: 4),
  TaskTemplate(area: 'Body', weekNumber: 9, title: 'Run 6km + full bodyweight workout', frequencyPerWeek: 4),

  // ─────────────────────────────────────────
  // MIND
  // ─────────────────────────────────────────
  TaskTemplate(area: 'Mind', weekNumber: 1, title: 'Read for 10 minutes', frequencyPerWeek: 5),
  TaskTemplate(area: 'Mind', weekNumber: 2, title: 'Read for 20 minutes', frequencyPerWeek: 5),
  TaskTemplate(area: 'Mind', weekNumber: 3, title: 'Read for 20 min + write 3 key takeaways', frequencyPerWeek: 5),
  TaskTemplate(area: 'Mind', weekNumber: 4, title: 'Read for 30 minutes', frequencyPerWeek: 5),
  TaskTemplate(area: 'Mind', weekNumber: 5, title: 'Read 30 min + 5-minute journal', frequencyPerWeek: 5),
  TaskTemplate(area: 'Mind', weekNumber: 6, title: 'Read 30 min + learn one new concept', frequencyPerWeek: 6),
  TaskTemplate(area: 'Mind', weekNumber: 7, title: 'Read 40 minutes', frequencyPerWeek: 6),
  TaskTemplate(area: 'Mind', weekNumber: 8, title: 'Read 40 min + journal reflection', frequencyPerWeek: 6),
  TaskTemplate(area: 'Mind', weekNumber: 9, title: 'Read 45 min + journal + apply one idea today', frequencyPerWeek: 7),

  // ─────────────────────────────────────────
  // REST
  // ─────────────────────────────────────────
  TaskTemplate(area: 'Rest', weekNumber: 1, title: 'In bed by midnight', frequencyPerWeek: 5),
  TaskTemplate(area: 'Rest', weekNumber: 2, title: 'In bed by 11:30pm', frequencyPerWeek: 5),
  TaskTemplate(area: 'Rest', weekNumber: 3, title: 'In bed by 11pm + no screens 30 min before', frequencyPerWeek: 5),
  TaskTemplate(area: 'Rest', weekNumber: 4, title: 'In bed by 11pm + no screens 30 min before', frequencyPerWeek: 6),
  TaskTemplate(area: 'Rest', weekNumber: 5, title: 'In bed by 10:45pm + wind-down routine', frequencyPerWeek: 6),
  TaskTemplate(area: 'Rest', weekNumber: 6, title: 'In bed by 10:30pm + no screens 1hr before', frequencyPerWeek: 6),
  TaskTemplate(area: 'Rest', weekNumber: 7, title: 'In bed by 10:30pm + 10-min meditation before sleep', frequencyPerWeek: 6),
  TaskTemplate(area: 'Rest', weekNumber: 8, title: 'In bed by 10:30pm + full wind-down routine', frequencyPerWeek: 7),
  TaskTemplate(area: 'Rest', weekNumber: 9, title: 'In bed by 10:30pm + full wind-down + 8hr sleep target', frequencyPerWeek: 7),

  // ─────────────────────────────────────────
  // FUEL
  // ─────────────────────────────────────────
  TaskTemplate(area: 'Fuel', weekNumber: 1, title: 'Drink 2L of water', frequencyPerWeek: 7),
  TaskTemplate(area: 'Fuel', weekNumber: 2, title: 'Drink 2L water + eat one whole meal', frequencyPerWeek: 7),
  TaskTemplate(area: 'Fuel', weekNumber: 3, title: 'Drink 2.5L water + no fast food', frequencyPerWeek: 7),
  TaskTemplate(area: 'Fuel', weekNumber: 4, title: 'Drink 2.5L + cook one meal at home', frequencyPerWeek: 5),
  TaskTemplate(area: 'Fuel', weekNumber: 5, title: 'Drink 2.5L + cook two meals at home', frequencyPerWeek: 5),
  TaskTemplate(area: 'Fuel', weekNumber: 6, title: 'Drink 3L + meal prep for next day', frequencyPerWeek: 5),
  TaskTemplate(area: 'Fuel', weekNumber: 7, title: 'Drink 3L + no added sugar today', frequencyPerWeek: 5),
  TaskTemplate(area: 'Fuel', weekNumber: 8, title: 'Drink 3L + meal prep + no sugar', frequencyPerWeek: 6),
  TaskTemplate(area: 'Fuel', weekNumber: 9, title: 'Drink 3L + full meal prep + no sugar + eat clean', frequencyPerWeek: 7),

  // ─────────────────────────────────────────
  // CONNECTION
  // ─────────────────────────────────────────
  TaskTemplate(area: 'Connection', weekNumber: 1, title: 'Text someone you haven\'t spoken to in a while', frequencyPerWeek: 1),
  TaskTemplate(area: 'Connection', weekNumber: 2, title: 'Have a real conversation (no small talk)', frequencyPerWeek: 1),
  TaskTemplate(area: 'Connection', weekNumber: 3, title: 'Call a friend or family member', frequencyPerWeek: 1),
  TaskTemplate(area: 'Connection', weekNumber: 4, title: 'Make plans with someone and follow through', frequencyPerWeek: 1),
  TaskTemplate(area: 'Connection', weekNumber: 5, title: 'Meet someone in person', frequencyPerWeek: 1),
  TaskTemplate(area: 'Connection', weekNumber: 6, title: 'Do something kind for someone unprompted', frequencyPerWeek: 2),
  TaskTemplate(area: 'Connection', weekNumber: 7, title: 'Have a deep or meaningful conversation', frequencyPerWeek: 2),
  TaskTemplate(area: 'Connection', weekNumber: 8, title: 'Spend quality time with someone important to you', frequencyPerWeek: 2),
  TaskTemplate(area: 'Connection', weekNumber: 9, title: 'Host or organise a meetup or shared activity', frequencyPerWeek: 1),

  // ─────────────────────────────────────────
  // PURPOSE
  // ─────────────────────────────────────────
  TaskTemplate(area: 'Purpose', weekNumber: 1, title: 'Write down one goal you\'re working toward', frequencyPerWeek: 1),
  TaskTemplate(area: 'Purpose', weekNumber: 2, title: 'Spend 20 min on a personal project', frequencyPerWeek: 2),
  TaskTemplate(area: 'Purpose', weekNumber: 3, title: 'Spend 30 min on a personal project', frequencyPerWeek: 2),
  TaskTemplate(area: 'Purpose', weekNumber: 4, title: 'Spend 30 min on your passion project', frequencyPerWeek: 3),
  TaskTemplate(area: 'Purpose', weekNumber: 5, title: 'Spend 45 min on your passion project', frequencyPerWeek: 3),
  TaskTemplate(area: 'Purpose', weekNumber: 6, title: 'Spend 1hr on your passion project', frequencyPerWeek: 3),
  TaskTemplate(area: 'Purpose', weekNumber: 7, title: 'Spend 1hr on passion project + review your goals', frequencyPerWeek: 4),
  TaskTemplate(area: 'Purpose', weekNumber: 8, title: 'Spend 1hr on passion project + share progress with someone', frequencyPerWeek: 4),
  TaskTemplate(area: 'Purpose', weekNumber: 9, title: 'Spend 1hr on passion project + plan next milestone', frequencyPerWeek: 5),
];

/// Returns the personalised task list based on the player's area ratings.
/// Rating 1–2 → all 9 weeks assigned (full progression)
/// Rating 3   → weeks 1–6 assigned (moderate)
/// Rating 4–5 → weeks 1–3 assigned (maintenance only)
List<TaskTemplate> generateTasksForPlayer(Map<String, int> ratings) {
  final List<TaskTemplate> result = [];

  for (final template in allTaskTemplates) {
    final rating = ratings[template.area] ?? 3;

    final int maxWeek;
    if (rating <= 2) {
      maxWeek = 9;
    } else if (rating == 3) {
      maxWeek = 6;
    } else {
      maxWeek = 3;
    }

    if (template.weekNumber <= maxWeek) {
      result.add(template);
    }
  }

  return result;
}