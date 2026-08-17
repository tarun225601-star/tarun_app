import 'package:tarun_app/services/shared_preferences_service.dart';
import 'package:tarun_app/utils/constants.dart';

class Calculation {
  String expression;
  String result;

  Calculation({required this.expression, required this.result});

  factory Calculation.fromJson(Map<String, dynamic> json) {
    return Calculation(
      expression: json['expression'],
      result: json['result'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'expression': expression,
      'result': result,
    };
  }
}

class Calculator {
  static String calculate(String expression) {
    try {
      return _calculate(expression);
    } catch (e) {
      return 'Error';
    }
  }

  static String _calculate(String expression) {
    // Implement your calculation logic here
    // For example, using the math_expressions package
    // https://pub.dev/packages/math_expressions
    // var parser = Parser();
    // var expression = parser.parse(expression);
    // return expression.evaluate(EvaluationType.REAL, ContextModel()).toString();
    return '0'; // Replace with actual calculation logic
  }
}

class SettingsDialog {
  static Future<void> showSettingsDialog() async {
    await showDialog(
      context: navigatorKey.currentContext!,
      builder: (context) => AlertDialog(
        title: Text('Settings'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'API Key',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                SharedPreferencesService.setApiKey(value);
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            child: Text('Save'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}