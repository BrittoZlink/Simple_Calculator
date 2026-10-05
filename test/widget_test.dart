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
}
