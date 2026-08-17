import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tarun_app/utils/constants.dart';
import 'package:tarun_app/utils/dialogs.dart';

class CustomDisplay extends StatefulWidget {
  final String expression;
  final Function updateExpression;

  const CustomDisplay({
    Key? key,
    required this.expression,
    required this.updateExpression,
  }) : super(key: key);

  @override
  _CustomDisplayState createState() => _CustomDisplayState();
}

class _CustomDisplayState extends State<CustomDisplay> {
  String _apiKeys = '';

  Future<void> _openSettingsDialog() async {
    final prefs = await SharedPreferences.getInstance();
    final apiKey = prefs.getString('api_key')?? '';

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Settings'),
          content: TextField(
            decoration: const InputDecoration(
              labelText: 'API Key',
              border: OutlineInputBorder(),
            ),
            controller: TextEditingController(text: apiKey),
            onChanged: (value) {
              setState(() {
                _apiKeys = value;
              });
            },
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
                await prefs.setString('api_key', _apiKeys);
                Navigator.of(context).pop();
              },
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
        title: const Text('Calculator'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: _openSettingsDialog,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: Container(
                alignment: Alignment.bottomRight,
                child: Text(
                  widget.expression,
                  style: const TextStyle(fontSize: 48),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    widget.updateExpression('7');
                  },
                  child: const Text('7'),
                ),
                ElevatedButton(
                  onPressed: () {
                    widget.updateExpression('8');
                  },
                  child: const Text('8'),
                ),
                ElevatedButton(
                  onPressed: () {
                    widget.updateExpression('9');
                  },
                  child: const Text('9'),
                ),
                ElevatedButton(
                  onPressed: () {
                    widget.updateExpression('/');
                  },
                  child: const Text('/'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    widget.updateExpression('4');
                  },
                  child: const Text('4'),
                ),
                ElevatedButton(
                  onPressed: () {
                    widget.updateExpression('5');
                  },
                  child: const Text('5'),
                ),
                ElevatedButton(
                  onPressed: () {
                    widget.updateExpression('6');
                  },
                  child: const Text('6'),
                ),
                ElevatedButton(
                  onPressed: () {
                    widget.updateExpression('*');
                  },
                  child: const Text('*'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    widget.updateExpression('1');
                  },
                  child: const Text('1'),
                ),
                ElevatedButton(
                  onPressed: () {
                    widget.updateExpression('2');
                  },
                  child: const Text('2'),
                ),
                ElevatedButton(
                  onPressed: () {
                    widget.updateExpression('3');
                  },
                  child: const Text('3'),
                ),
                ElevatedButton(
                  onPressed: () {
                    widget.updateExpression('-');
                  },
                  child: const Text('-'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    widget.updateExpression('0');
                  },
                  child: const Text('0'),
                ),
                ElevatedButton(
                  onPressed: () {
                    widget.updateExpression('.');
                  },
                  child: const Text('.'),
                ),
                ElevatedButton(
                  onPressed: () {
                    widget.updateExpression('=');
                  },
                  child: const Text('='),
                ),
                ElevatedButton(
                  onPressed: () {
                    widget.updateExpression('+');
                  },
                  child: const Text('+'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}