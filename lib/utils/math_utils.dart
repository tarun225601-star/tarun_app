import 'package:tarun_app/models/calculator_model.dart';
import 'package:tarun_app/services/shared_preferences_service.dart';

class MathUtils {
  static const String ADDITION = '+';
  static const String SUBTRACTION = '-';
  static const String MULTIPLICATION = '*';
  static const String DIVISION = '/';

  static double calculate(double num1, double num2, String operation) {
    switch (operation) {
      case ADDITION:
        return num1 + num2;
      case SUBTRACTION:
        return num1 - num2;
      case MULTIPLICATION:
        return num1 * num2;
      case DIVISION:
        if (num2!= 0) {
          return num1 / num2;
        } else {
          throw Exception('Cannot divide by zero');
        }
      default:
        throw Exception('Invalid operation');
    }
  }

  static String formatNumber(double number) {
    return number.toStringAsFixed(2);
  }

  static String getOperationSymbol(String operation) {
    switch (operation) {
      case ADDITION:
        return '+';
      case SUBTRACTION:
        return '-';
      case MULTIPLICATION:
        return '*';
      case DIVISION:
        return '/';
      default:
        return '';
    }
  }

  static void saveApiKeys(String apiKey, String apiSecret) async {
    final SharedPreferencesService _sharedPreferencesService = SharedPreferencesService();
    await _sharedPreferencesService.saveString('apiKey', apiKey);
    await _sharedPreferencesService.saveString('apiSecret', apiSecret);
  }

  static Future<String> getApiKey() async {
    final SharedPreferencesService _sharedPreferencesService = SharedPreferencesService();
    return _sharedPreferencesService.getString('apiKey');
  }

  static Future<String> getApiSecret() async {
    final SharedPreferencesService _sharedPreferencesService = SharedPreferencesService();
    return _sharedPreferencesService.getString('apiSecret');
  }
}