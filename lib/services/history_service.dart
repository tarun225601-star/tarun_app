import 'package:tarun_app/models/history_model.dart';
import 'package:tarun_app/utils/shared_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tarun_app/utils/api_keys.dart';

class HistoryService {
  static const String _historyKey = 'history';

  Future<List<HistoryModel>> getHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final historyJson = prefs.getString(_historyKey);
    if (historyJson!= null) {
      return (jsonDecode(historyJson) as List)
         .map((e) => HistoryModel.fromJson(e))
         .toList();
    } else {
      return [];
    }
  }

  Future<void> saveHistory(HistoryModel history) async {
    final prefs = await SharedPreferences.getInstance();
    final historyJson = prefs.getString(_historyKey);
    List<HistoryModel> histories = [];
    if (historyJson!= null) {
      histories = (jsonDecode(historyJson) as List)
         .map((e) => HistoryModel.fromJson(e))
         .toList();
    }
    histories.add(history);
    await prefs.setString(_historyKey, jsonEncode(histories));
  }

  Future<void> clearHistory() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_historyKey);
  }

  Future<void> openSettingsDialog() async {
    final prefs = await SharedPreferences.getInstance();
    final apiKey = prefs.getString(ApiKeys.apiKey);
    final apiSecret = prefs.getString(ApiKeys.apiSecret);
    await showDialog(
      context: navigatorKey.currentContext!,
      builder: (context) {
        final _apiKeyController = TextEditingController(text: apiKey);
        final _apiSecretController = TextEditingController(text: apiSecret);
        return AlertDialog(
          title: const Text('Settings'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _apiKeyController,
                decoration: const InputDecoration(
                  labelText: 'API Key',
                ),
              ),
              TextField(
                controller: _apiSecretController,
                decoration: const InputDecoration(
                  labelText: 'API Secret',
                ),
              ),
            ],
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
                await prefs.setString(
                  ApiKeys.apiKey,
                  _apiKeyController.text,
                );
                await prefs.setString(
                  ApiKeys.apiSecret,
                  _apiSecretController.text,
                );
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}