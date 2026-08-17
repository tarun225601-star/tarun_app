import 'package:shared_preferences/shared_preferences.dart';
import 'package:tarun_app/models/calculator_model.dart';
import 'package:tarun_app/utils/constants.dart';

class CalculatorService {
  Future<void> saveApiKeys(String apiKey) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('api_key', apiKey);
  }

  Future<String> getApiKey() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('api_key') ?? '';
  }

  Future<void> openSettingsDialog() async {
    final apiKey = await getApiKey();
    await showDialog(
      context: navigatorKey.currentContext!,
      builder: (context) => AlertDialog(
        title: const Text('Settings'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Enter API Key:'),
            TextField(
              controller: TextEditingController(text: apiKey),
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'API Key',
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            child: const Text('Cancel'),
            onPressed: () => Navigator.of(context).pop(),
          ),
          TextButton(
            child: const Text('Save'),
            onPressed: () async {
              final apiKeyController =
                  (context as Element).findAncestorWidgetOfExactType<TextField>()!.controller;
              await saveApiKeys(apiKeyController.text);
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

  String calculateExpression(String expression) {
    try {
      final calculatorModel = CalculatorModel();
      return calculatorModel.calculate(expression).toString();
    } catch (e) {
      return 'Error: $e';
    }
  }
}