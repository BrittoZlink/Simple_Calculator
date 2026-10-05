import 'package:flutter_test/flutter_test.dart';
import 'package:simple_calculator/main.dart';

void main() {
  testWidgets('calculator adds two numbers', (WidgetTester tester) async {
    await tester.pumpWidget(const CalculatorApp());

    await tester.tap(find.text('7'));
    await tester.tap(find.text('+'));
    await tester.tap(find.text('5'));
    await tester.tap(find.text('='));
    await tester.pump();

    expect(find.text('12'), findsOneWidget);
  });

  testWidgets('history panel records completed calculations',
      (WidgetTester tester) async {
    await tester.pumpWidget(const CalculatorApp());
    expect(find.text('No history'), findsOneWidget);

    await tester.tap(find.text('7'));
    await tester.tap(find.text('+'));
    await tester.tap(find.text('5'));
    await tester.tap(find.text('='));
    await tester.pump();

    expect(find.text('7 + 5'), findsOneWidget);
    expect(find.text('= 12'), findsOneWidget);

    await tester.tap(find.byTooltip('Clear history'));
    await tester.pump();
    expect(find.text('No history'), findsOneWidget);
  });
}
