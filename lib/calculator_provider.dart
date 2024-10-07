import 'package:flutter/foundation.dart';
import 'package:math_expressions/math_expressions.dart';

class CalculatorProvider with ChangeNotifier {
  String _expression = '';
  String _result = '';

  String get expression => _expression;
  String get result => _result;

  void addExpression(String value) {
    if (value == '×') {
      _expression += '*';
    } else if (value == '÷') {
      _expression += '/';
    } else if (value == '%') {
      _expression += '*0.01';  // Simplistic percentage handling
    } else if (value == 'π') {
      _expression += '3.141592653589793';
    } else {
      _expression += value;
    }
    _evaluateExpression();
    notifyListeners();
  }

  void _evaluateExpression() {
    try {
      Parser parser = Parser();
      Expression exp = parser.parse(_expression);
      ContextModel cm = ContextModel();
      _result = exp.evaluate(EvaluationType.REAL, cm).toString();
    } catch (e) {
      _result = '';
    }
  }

  void clear() {
    _expression = '';
    _result = '';
    notifyListeners();
  }

  void calculate() {
    _expression = _result;
    _result = '';
    notifyListeners();
  }

  void backspace() {
    if (_expression.isNotEmpty) {
      _expression = _expression.substring(0, _expression.length - 1);
      _evaluateExpression();
      notifyListeners();
    }
  }

  void squareRoot() {
    try {
      Parser parser = Parser();
      Expression exp = parser.parse('sqrt($_expression)');
      ContextModel cm = ContextModel();
      _expression = exp.evaluate(EvaluationType.REAL, cm).toString();
      _result = '';
    } catch (e) {
      _result = '';
    }
    notifyListeners();
  }

  void clearHistory() {
    // Clear history logic if you have history implemented
  }

  List<String> get history {
    // Return history if you have history implemented
    return [];
  }
}
