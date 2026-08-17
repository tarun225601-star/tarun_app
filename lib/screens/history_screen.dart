import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tarun_app/models/history_model.dart';
import 'package:tarun_app/services/api_service.dart';
import 'package:tarun_app/utils/constants.dart';

class HistoryScreen extends StatefulWidget {
  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  List<HistoryModel> _history = [];
  final ApiService _apiService = ApiService();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _loadHistory();
  }

  Future<void> _loadHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final apiKeys = prefs.getString('apiKeys');
    if (apiKeys != null) {
      final response = await _apiService.getHistory(apiKeys);
      if (response != null) {
        setState(() {
          _history = response;
        });
      }
    }
  }

  Future<void> _saveApiKeys() async {
    final prefs = await SharedPreferences.getInstance();
    await showDialog(
      context: context,
      builder: (context) {
        final _formKey = GlobalKey<FormState>();
        final _apiKeyController = TextEditingController();
        return AlertDialog(
          title: Text('Save API Keys'),
          content: Form(
            key: _formKey,
            child: TextFormField(
              controller: _apiKeyController,
              decoration: InputDecoration(
                labelText: 'API Keys',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter API keys';
                }
                return null;
              },
            ),
          ),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Save'),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  prefs.setString('apiKeys', _apiKeyController.text);
                  _loadHistory();
                  Navigator.of(context).pop();
                }
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
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('History'),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: _saveApiKeys,
          ),
        ],
      ),
      body: _history.isEmpty
          ? Center(
              child: Text('No history found'),
            )
          : ListView.builder(
              itemCount: _history.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_history[index].expression),
                  subtitle: Text(_history[index].result),
                );
              },
            ),
    );
  }
}