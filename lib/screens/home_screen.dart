import 'package:flutter/material.dart';
import 'package:tarun_app/models/calculator_model.dart';
import 'package:tarun_app/services/shared_preferences_service.dart';
import 'package:tarun_app/widgets/calculator_button.dart';
import 'package:tarun_app/widgets/calculator_display.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final CalculatorModel _calculatorModel = CalculatorModel();
  final SharedPreferencesService _sharedPreferencesService = SharedPreferencesService();

  void _onButtonPressed(String buttonValue) {
    setState(() {
      _calculatorModel.onButtonPressed(buttonValue);
    });
  }

  void _saveApiKeys() async {
    await showDialog(
      context: context,
      builder: (context) {
        final TextEditingController _apiKeyController = TextEditingController();
        final TextEditingController _apiSecretController = TextEditingController();

        return AlertDialog(
          title: const Text('Save API Keys'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _apiKeyController,
                decoration: const InputDecoration(
                  labelText: 'API Key',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _apiSecretController,
                decoration: const InputDecoration(
                  labelText: 'API Secret',
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                await _sharedPreferencesService.saveApiKeys(
                  _apiKeyController.text,
                  _apiSecretController.text,
                );
                Navigator.of(context).pop();
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculator App'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: _saveApiKeys,
          ),
        ],
      ),
      body: Column(
        children: [
          CalculatorDisplay(
            expression: _calculatorModel.expression,
            result: _calculatorModel.result,
          ),
          const SizedBox(height: 16),
          GridView.count(
            shrinkWrap: true,
            crossAxisCount: 4,
            childAspectRatio: 1.2,
            children: [
              CalculatorButton(
                buttonValue: '7',
                onPressed: _onButtonPressed,
              ),
              CalculatorButton(
                buttonValue: '8',
                onPressed: _onButtonPressed,
              ),
              CalculatorButton(
                buttonValue: '9',
                onPressed: _onButtonPressed,
              ),
              CalculatorButton(
                buttonValue: '/',
                onPressed: _onButtonPressed,
              ),
              CalculatorButton(
                buttonValue: '4',
                onPressed: _onButtonPressed,
              ),
              CalculatorButton(
                buttonValue: '5',
                onPressed: _onButtonPressed,
              ),
              CalculatorButton(
                buttonValue: '6',
                onPressed: _onButtonPressed,
              ),
              CalculatorButton(
                buttonValue: '*',
                onPressed: _onButtonPressed,
              ),
              CalculatorButton(
                buttonValue: '1',
                onPressed: _onButtonPressed,
              ),
              CalculatorButton(
                buttonValue: '2',
                onPressed: _onButtonPressed,
              ),
              CalculatorButton(
                buttonValue: '3',
                onPressed: _onButtonPressed,
              ),
              CalculatorButton(
                buttonValue: '-',
                onPressed: _onButtonPressed,
              ),
              CalculatorButton(
                buttonValue: '0',
                onPressed: _onButtonPressed,
              ),
              CalculatorButton(
                buttonValue: '.',
                onPressed: _onButtonPressed,
              ),
              CalculatorButton(
                buttonValue: '=',
                onPressed: _onButtonPressed,
              ),
              CalculatorButton(
                buttonValue: '+',
                onPressed: _onButtonPressed,
              ),
            ],
          ),
        ],
      ),
    );
  }
}