import 'package:flutter/material.dart';
import 'package:tarun_app/utils/constants.dart';
import 'package:tarun_app/utils/shared_preferences.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Function onPressed;
  final bool isOperator;

  CustomButton({
    required this.text,
    required this.onPressed,
    required this.isOperator,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onPressed(),
      child: Container(
        margin: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: isOperator
             ? Constants.operatorButtonColor
              : Constants.numberButtonColor,
          borderRadius: const BorderRadius.all(Radius.circular(16.0)),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 24.0,
              color: isOperator
                 ? Constants.operatorTextColor
                  : Constants.numberTextColor,
            ),
          ),
        ),
      ),
    );
  }
}

class SettingsButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.settings),
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) {
            final _apiKeyController = TextEditingController();
            final _apiSecretController = TextEditingController();

            return AlertDialog(
              title: const Text('Save API Keys'),
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
                  onPressed: () {
                    SharedPreferencesHelper.saveApiKey(_apiKeyController.text);
                    SharedPreferencesHelper.saveApiSecret(_apiSecretController.text);
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }
}