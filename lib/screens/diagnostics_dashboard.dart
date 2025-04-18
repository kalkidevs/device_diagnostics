import 'package:flutter/material.dart';
import 'package:testing/screens/hardware_button_test_screen.dart';

import 'multi_touch_test_screen.dart';
// Import all your test screens here

class DiagnosticsDashboard extends StatefulWidget {
  const DiagnosticsDashboard({super.key});

  @override
  State<DiagnosticsDashboard> createState() => _DiagnosticsDashboardState();
}

class _DiagnosticsDashboardState extends State<DiagnosticsDashboard> {
  final Map<String, String> testResults = {
    'Multi-touch Support': 'Not Tested',
    'Hardware Buttons': 'Not Tested',
    'Screen Issues': 'Not Tested',
    'Dead Pixels': 'Not Tested',
    // Add more tests here
  };

  Future<void> _runTest(String testName) async {
    String? result;

    switch (testName) {
      case 'Multi-touch Support':
        result = await Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const MultiTouchTestScreen()),
        );
        break;
      case 'Hardware Buttons':
        result = await Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const HardwareButtonTestScreen()),
        );
        break;
      // Add more cases for other tests
    }

    setState(() {
      testResults[testName] = result ?? 'Not Working';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Hardware Diagnostics")),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children:
            testResults.entries.map((entry) {
              return Card(
                child: ListTile(
                  title: Text(entry.key),
                  subtitle: Text("Status: ${entry.value}"),
                  trailing: ElevatedButton(
                    onPressed: () => _runTest(entry.key),
                    child: const Text("Run Test"),
                  ),
                ),
              );
            }).toList(),
      ),
    );
  }
}
