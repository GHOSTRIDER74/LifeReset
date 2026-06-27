// lib/data/task_templates.dart

class TaskTemplate {
  final String area;
  final int weekNumber;
  final String title;
  final String frequency; // e.g. "2x per week", "daily"

  const TaskTemplate({
    required this.area,
    required this.weekNumber,
    required this.title,
    required this.frequency,
  });
}

const List<TaskTemplate> allTaskTemplates = [

  // ─────────────────────────────────────────
  // BODY
  // ─────────────────────────────────────────
  TaskTemplate(area: 'Body', weekNumber: 1, title: 'Run 2km', frequency: '2x per week'),
  TaskTemplate(area: 'Body', weekNumber: 2, title: 'Run 3km', frequency: '2x per week'),
  TaskTemplate(area: 'Body', weekNumber: 3, title: 'Run 4km', frequency: '3x per week'),
  TaskTemplate(area: 'Body', weekNumber: 4, title: 'Run 4km + 20 push-ups', frequency: '3x per week'),
  TaskTemplate(area: 'Body', weekNumber: 5, title: 'Run 5km', frequency: '3x per week'),
  TaskTemplate(area: 'Body', weekNumber: 6, title: 'Run 5km + bodyweight circuit', frequency: '3x per week'),
  TaskTemplate(area: 'Body', weekNumber: 7, title: 'Run 6km', frequency: '4x per week'),
  TaskTemplate(area: 'Body', weekNumber: 8, title: 'Run 6km + strength session', frequency: '4x per week'),
  TaskTemplate(area: 'Body', weekNumber: 9, title: 'Run 6km + full bodyweight workout', frequency: '4x per week'),

  // ─────────────────────────────────────────
  // MIND
  // ─────────────────────────────────────────
  TaskTemplate(area: 'Mind', weekNumber: 1, title: 'Read for 10 minutes', frequency: '5x per week'),
  TaskTemplate(area: 'Mind', weekNumber: 2, title: 'Read for 20 minutes', frequency: '5x per week'),
  TaskTemplate(area: 'Mind', weekNumber: 3, title: 'Read for 20 min + write 3 key takeaways', frequency: '5x per week'),
  TaskTemplate(area: 'Mind', weekNumber: 4, title: 'Read for 30 minutes', frequency: '5x per week'),
  TaskTemplate(area: 'Mind', weekNumber: 5, title: 'Read 30 min + 5-minute journal', frequency: '5x per week'),
  TaskTemplate(area: 'Mind', weekNumber: 6, title: 'Read 30 min + learn one new concept', frequency: '6x per week'),
  TaskTemplate(area: 'Mind', weekNumber: 7, title: 'Read 40 minutes', frequency: '6x per week'),
  TaskTemplate(area: 'Mind', weekNumber: 8, title: 'Read 40 min + journal reflection', frequency: '6x per week'),
  TaskTemplate(area: 'Mind', weekNumber: 9, title: 'Read 45 min + journal + apply one idea today', frequency: 'daily'),

  // ─────────────────────────────────────────
  // REST
  // ─────────────────────────────────────────
  TaskTemplate(area: 'Rest', weekNumber: 1, title: 'In bed by midnight', frequency: '5x per week'),
  TaskTemplate(area: 'Rest', weekNumber: 2, title: 'In bed by 11:30pm', frequency: '5x per week'),
  TaskTemplate(area: 'Rest', weekNumber: 3, title: 'In bed by 11pm + no screens 30 min before', frequency: '5x per week'),
  TaskTemplate(area: 'Rest', weekNumber: 4, title: 'In bed by 11pm + no screens 30 min before', frequency: '6x per week'),
  TaskTemplate(area: 'Rest', weekNumber: 5, title: 'In bed by 10:45pm + wind-down routine', frequency: '6x per week'),
  TaskTemplate(area: 'Rest', weekNumber: 6, title: 'In bed by 10:30pm + no screens 1hr before', frequency: '6x per week'),
  TaskTemplate(area: 'Rest', weekNumber: 7, title: 'In bed by 10:30pm + 10-min meditation before sleep', frequency: '6x per week'),
  TaskTemplate(area: 'Rest', weekNumber: 8, title: 'In bed by 10:30pm + full wind-down routine', frequency: '7x per week'),
  TaskTemplate(area: 'Rest', weekNumber: 9, title: 'In bed by 10:30pm + full wind-down + 8hr sleep target', frequency: 'daily'),

  // ─────────────────────────────────────────
  // FUEL
  // ─────────────────────────────────────────
  TaskTemplate(area: 'Fuel', weekNumber: 1, title: 'Drink 2L of water', frequency: 'daily'),
  TaskTemplate(area: 'Fuel', weekNumber: 2, title: 'Drink 2L water + eat one whole meal', frequency: 'daily'),
  TaskTemplate(area: 'Fuel', weekNumber: 3, title: 'Drink 2.5L water + no fast food', frequency: 'daily'),
  TaskTemplate(area: 'Fuel', weekNumber: 4, title: 'Drink 2.5L + cook one meal at home', frequency: '5x per week'),
  TaskTemplate(area: 'Fuel', weekNumber: 5, title: 'Drink 2.5L + cook two meals at home', frequency: '5x per week'),
  TaskTemplate(area: 'Fuel', weekNumber: 6, title: 'Drink 3L + meal prep for next day', frequency: '5x per week'),
  TaskTemplate(area: 'Fuel', weekNumber: 7, title: 'Drink 3L + no added sugar today', frequency: '5x per week'),
  TaskTemplate(area: 'Fuel', weekNumber: 8, title: 'Drink 3L + meal prep + no sugar', frequency: '6x per week'),
  TaskTemplate(area: 'Fuel', weekNumber: 9, title: 'Drink 3L + full meal prep + no sugar + eat clean', frequency: 'daily'),

  // ─────────────────────────────────────────
  // CONNECTION
  // ─────────────────────────────────────────
  TaskTemplate(area: 'Connection', weekNumber: 1, title: 'Text someone you haven\'t spoken to in a while', frequency: '1x per week'),
  TaskTemplate(area: 'Connection', weekNumber: 2, title: 'Have a real conversation (no small talk)', frequency: '1x per week'),
  TaskTemplate(area: 'Connection', weekNumber: 3, title: 'Call a friend or family member', frequency: '1x per week'),
  TaskTemplate(area: 'Connection', weekNumber: 4, title: 'Make plans with someone and follow through', frequency: '1x per week'),
  TaskTemplate(area: 'Connection', weekNumber: 5, title: 'Meet someone in person', frequency: '1x per week'),
  TaskTemplate(area: 'Connection', weekNumber: 6, title: 'Do something kind for someone unprompted', frequency: '2x per week'),
  TaskTemplate(area: 'Connection', weekNumber: 7, title: 'Have a deep or meaningful conversation', frequency: '2x per week'),
  TaskTemplate(area: 'Connection', weekNumber: 8, title: 'Spend quality time with someone important to you', frequency: '2x per week'),
  TaskTemplate(area: 'Connection', weekNumber: 9, title: 'Host or organise a meetup or shared activity', frequency: '1x per week'),

  // ─────────────────────────────────────────
  // PURPOSE
  // ─────────────────────────────────────────
  TaskTemplate(area: 'Purpose', weekNumber: 1, title: 'Write down one goal you\'re working toward', frequency: '1x per week'),
  TaskTemplate(area: 'Purpose', weekNumber: 2, title: 'Spend 20 min on a personal project', frequency: '2x per week'),
  TaskTemplate(area: 'Purpose', weekNumber: 3, title: 'Spend 30 min on a personal project', frequency: '2x per week'),
  TaskTemplate(area: 'Purpose', weekNumber: 4, title: 'Spend 30 min on your passion project', frequency: '3x per week'),
  TaskTemplate(area: 'Purpose', weekNumber: 5, title: 'Spend 45 min on your passion project', frequency: '3x per week'),
  TaskTemplate(area: 'Purpose', weekNumber: 6, title: 'Spend 1hr on your passion project', frequency: '3x per week'),
  TaskTemplate(area: 'Purpose', weekNumber: 7, title: 'Spend 1hr on passion project + review your goals', frequency: '4x per week'),
  TaskTemplate(area: 'Purpose', weekNumber: 8, title: 'Spend 1hr on passion project + share progress with someone', frequency: '4x per week'),
  TaskTemplate(area: 'Purpose', weekNumber: 9, title: 'Spend 1hr on passion project + plan next milestone', frequency: '5x per week'),
];

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