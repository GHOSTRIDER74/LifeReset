import 'package:flutter_test/flutter_test.dart';
import 'package:life_reset/main.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const MainApp());
  });
}