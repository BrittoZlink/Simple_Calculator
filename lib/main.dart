import 'package:flutter/material.dart';

import 'calculator_logic.dart';

void main() => runApp(const CalculatorApp());

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(useMaterial3: true).copyWith(
        scaffoldBackgroundColor: Colors.black,
      ),
      home: const CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  final CalculatorLogic _calc = CalculatorLogic();

  static const _rows = [
    ['AC', '±', '%', '÷'],
    ['7', '8', '9', '×'],
    ['4', '5', '6', '−'],
    ['1', '2', '3', '+'],
    ['0', '.', '='],
  ];

  static const _operators = {'÷', '×', '−', '+', '='};
  static const _functions = {'AC', '±', '%'};

  void _onPressed(String key) => setState(() => _calc.input(key));

  Color _background(String key) {
    if (_operators.contains(key)) return Colors.orange;
    if (_functions.contains(key)) return Colors.grey.shade500;
    return const Color(0xFF333333);
  }

  Color _foreground(String key) =>
      _functions.contains(key) ? Colors.black : Colors.white;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              Expanded(
                child: Container(
                  alignment: Alignment.bottomRight,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      _calc.display,
                      style: const TextStyle(
                        fontSize: 80,
                        fontWeight: FontWeight.w300,
                      ),
                      maxLines: 1,
                    ),
                  ),
                ),
              ),
              for (final row in _rows)
                Expanded(
                  child: Row(
                    children: [
                      for (final key in row)
                        Expanded(
                          flex: key == '0' ? 2 : 1,
                          child: Padding(
                            padding: const EdgeInsets.all(6),
                            child: FilledButton(
                              style: FilledButton.styleFrom(
                                backgroundColor: _background(key),
                                foregroundColor: _foreground(key),
                                shape: key == '0'
                                    ? const StadiumBorder()
                                    : const CircleBorder(),
                                padding: EdgeInsets.zero,
                              ),
                              onPressed: () => _onPressed(key),
                              child: Text(
                                key,
                                style: const TextStyle(fontSize: 32),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
