import 'package:flutter/material.dart';

import '../models/device_info.dart';

class ResultsScreen extends StatelessWidget {
  final DeviceInfo deviceInfo;
  final Map<String, String> testResults;
  final int startBattery;
  final int endBattery;

  const ResultsScreen({
    super.key,
    required this.deviceInfo,
    required this.testResults,
    required this.startBattery,
    required this.endBattery,
  });

  @override
  Widget build(BuildContext context) {
    final batteryUsed = startBattery - endBattery;

    return Scaffold(
      appBar: AppBar(title: Text('Diagnostics Results')),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          Text("📱 Device Info", style: Theme.of(context).textTheme.titleLarge),
          Divider(),
          _infoTile('IMEI', deviceInfo.imei),
          _infoTile('Brand', deviceInfo.brand),
          _infoTile('Model', deviceInfo.model),
          _infoTile('RAM', deviceInfo.ram),
          _infoTile('Storage', deviceInfo.storage),
          _infoTile('Network', deviceInfo.network),
          _infoTile('Battery Start', '$startBattery%'),
          _infoTile('Battery End', '$endBattery%'),
          _infoTile('Battery Used', '$batteryUsed%'),

          SizedBox(height: 20),
          Text(
            "🧪 Test Results",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          Divider(),
          ...testResults.entries.map((e) => _infoTile(e.key, e.value)).toList(),
        ],
      ),
    );
  }

  Widget _infoTile(String label, String value) {
    return ListTile(
      title: Text(label),
      trailing: Text(value, style: TextStyle(fontWeight: FontWeight.bold)),
    );
  }
}
