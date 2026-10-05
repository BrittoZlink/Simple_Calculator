/// Pure calculator state machine (no Flutter dependency, easy to test).
class CalculatorLogic {
  String display = '0';
  String? _operator;
  double? _operand;
  bool _resetOnNextDigit = false;

  void input(String key) {
    switch (key) {
      case 'AC':
        _clear();
      case '±':
        _toggleSign();
      case '%':
        _percent();
      case '+' || '−' || '×' || '÷':
        _setOperator(key);
      case '=':
        _equals();
      case '.':
        _decimal();
      default:
        _digit(key);
    }
  }

  void _clear() {
    display = '0';
    _operator = null;
    _operand = null;
    _resetOnNextDigit = false;
  }

  void _digit(String d) {
    if (_resetOnNextDigit || display == '0' || display == 'Error') {
      display = d;
      _resetOnNextDigit = false;
    } else if (display.replaceAll(RegExp(r'[-.]'), '').length < 12) {
      display += d;
    }
  }

  void _decimal() {
    if (_resetOnNextDigit || display == 'Error') {
      display = '0.';
      _resetOnNextDigit = false;
    } else if (!display.contains('.')) {
      display += '.';
    }
  }

  void _toggleSign() {
    if (display == '0' || display == 'Error') return;
    display = display.startsWith('-') ? display.substring(1) : '-$display';
  }

  void _percent() {
    final v = double.tryParse(display);
    if (v == null) return;
    display = _format(v / 100);
    _resetOnNextDigit = true;
  }

  void _setOperator(String op) {
    if (_operator != null && !_resetOnNextDigit) {
      _equals();
    }
    _operand = double.tryParse(display);
    _operator = op;
    _resetOnNextDigit = true;
  }

  void _equals() {
    final a = _operand;
    final b = double.tryParse(display);
    final op = _operator;
    if (a == null || b == null || op == null) return;

    double result;
    switch (op) {
      case '+':
        result = a + b;
      case '−':
        result = a - b;
      case '×':
        result = a * b;
      default:
        if (b == 0) {
          display = 'Error';
          _operator = null;
          _operand = null;
          _resetOnNextDigit = true;
          return;
        }
        result = a / b;
    }
    display = _format(result);
    _operator = null;
    _operand = null;
    _resetOnNextDigit = true;
  }

  String _format(double v) {
    if (v == v.roundToDouble() && v.abs() < 1e12) {
      return v.toInt().toString();
    }
    var s = v.toStringAsPrecision(10);
    if (s.contains('e')) return s;
    if (s.contains('.')) {
      s = s.replaceFirst(RegExp(r'0+$'), '').replaceFirst(RegExp(r'\.$'), '');
    }
    return s;
  }
}
