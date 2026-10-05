import 'package:flutter_test/flutter_test.dart';
import 'package:simple_calculator/calculator_logic.dart';

void run(CalculatorLogic c, List<String> keys) {
  for (final k in keys) {
    c.input(k);
  }
}

void main() {
  test('addition', () {
    final c = CalculatorLogic();
    run(c, ['1', '2', '+', '3', '=']);
    expect(c.display, '15');
  });

  test('chained operations evaluate left to right', () {
    final c = CalculatorLogic();
    run(c, ['2', '+', '3', '×', '4', '=']);
    expect(c.display, '20');
  });

  test('decimals', () {
    final c = CalculatorLogic();
    run(c, ['1', '.', '5', '×', '2', '=']);
    expect(c.display, '3');
  });

  test('divide by zero shows Error', () {
    final c = CalculatorLogic();
    run(c, ['5', '÷', '0', '=']);
    expect(c.display, 'Error');
  });

  test('percent, sign toggle and clear', () {
    final c = CalculatorLogic();
    run(c, ['5', '0', '%']);
    expect(c.display, '0.5');
    run(c, ['±']);
    expect(c.display, '-0.5');
    run(c, ['AC']);
    expect(c.display, '0');
  });
}
