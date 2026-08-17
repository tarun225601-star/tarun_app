import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tarun_app/constants.dart';
import 'package:tarun_app/utils.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const CalculatorPage(),
    );
  }
}

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({Key? key}) : super(key: key);

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  final _textController = TextEditingController();
  String _expression = '';
  String _result = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculator'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () async {
              final prefs = await SharedPreferences.getInstance();
              await showDialog(
                context: context,
                builder: (context) {
                  final _apiKeyController = TextEditingController();
                  return AlertDialog(
                    title: const Text('Save API Key'),
                    content: TextField(
                      controller: _apiKeyController,
                      decoration: const InputDecoration(
                        labelText: 'API Key',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    actions: [
                      TextButton(
                        child: const Text('Cancel'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      TextButton(
                        child: const Text('Save'),
                        onPressed: () async {
                          await prefs.setString('api_key', _apiKeyController.text);
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _textController,
              readOnly: true,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Expression',
              ),
            ),
          ),
          Expanded(
            child: GridView.count(
              crossAxisCount: 4,
              childAspectRatio: 1.5,
              children: [
               ..._buildNumberButtons(),
               ..._buildOperatorButtons(),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              _result,
              style: const TextStyle(fontSize: 24),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildNumberButtons() {
    return [
      _buildButton('7', () {
        _appendExpression('7');
      }),
      _buildButton('8', () {
        _appendExpression('8');
      }),
      _buildButton('9', () {
        _appendExpression('9');
      }),
      _buildButton('/', () {
        _appendExpression('/');
      }),
      _buildButton('4', () {
        _appendExpression('4');
      }),
      _buildButton('5', () {
        _appendExpression('5');
      }),
      _buildButton('6', () {
        _appendExpression('6');
      }),
      _buildButton('*', () {
        _appendExpression('*');
      }),
      _buildButton('1', () {
        _appendExpression('1');
      }),
      _buildButton('2', () {
        _appendExpression('2');
      }),
      _buildButton('3', () {
        _appendExpression('3');
      }),
      _buildButton('-', () {
        _appendExpression('-');
      }),
      _buildButton('0', () {
        _appendExpression('0');
      }),
      _buildButton('.', () {
        _appendExpression('.');
      }),
      _buildButton('=', () {
        _calculateResult();
      }),
      _buildButton('+', () {
        _appendExpression('+');
      }),
      _buildButton('C', () {
        _clearExpression();
      }),
    ];
  }

  List<Widget> _buildOperatorButtons() {
    return [];
  }

  Widget _buildButton(String label, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(label),
    );
  }

  void _appendExpression(String value) {
    setState(() {
      _expression += value;
      _textController.text = _expression;
    });
  }

  void _calculateResult() {
    try {
      final result = calculate(_expression);
      setState(() {
        _result = result.toString();
      });
    } catch (e) {
      setState(() {
        _result = 'Error';
      });
    }
  }

  void _clearExpression() {
    setState(() {
      _expression = '';
      _result = '';
      _textController.text = '';
    });
  }
}

double calculate(String expression) {
  final left = expression.substring(0, expression.length ~/ 2);
  final right = expression.substring(expression.length ~/ 2 + 1);
  final operator = expression[expression.length ~/ 2];

  switch (operator) {
    case '+':
      return double.parse(left) + double.parse(right);
    case '-':
      return double.parse(left) - double.parse(right);
    case '*':
      return double.parse(left) * double.parse(right);
    case '/':
      return double.parse(left) / double.parse(right);
    default:
      throw Exception('Invalid operator');
  }
}