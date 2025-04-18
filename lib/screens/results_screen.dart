import 'package:flutter/material.dart';
import '../models/device_info.dart';

class ResultsScreen extends StatelessWidget {
  final DeviceInfo deviceInfo;
  final Map<String, String> testResults;
  final int startBattery;
  final int endBattery;

  const ResultsScreen({
    Key? key,
    required this.deviceInfo,
    required this.testResults,
    required this.startBattery,
    required this.endBattery,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final batteryUsed = startBattery - endBattery;

    return Scaffold(
      appBar: AppBar(title: const Text("Diagnostics Results")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            const Text("📱 Device Information", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            _buildInfoTile("IMEI", deviceInfo.imei),
            _buildInfoTile("Brand", deviceInfo.brand),
            _buildInfoTile("Model", deviceInfo.model),
            _buildInfoTile("RAM", deviceInfo.ram),
            _buildInfoTile("Storage", deviceInfo.storage),
            _buildInfoTile("Network", deviceInfo.network),
            _buildInfoTile("Battery (Start)", "$startBattery%"),
            _buildInfoTile("Battery (End)", "$endBattery%"),
            _buildInfoTile("Battery Used", "$batteryUsed%"),
            const SizedBox(height: 16),
            const Text("🧪 Test Results", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            ...testResults.entries.map((entry) {
              final isPass = entry.value.toLowerCase().contains("working") ||
                  entry.value.toLowerCase().contains("no visible issues") ||
                  entry.value.toLowerCase().contains("none detected");

              return Card(
                child: ListTile(
                  title: Text(entry.key),
                  trailing: Text(
                    isPass ? "✅ Pass" : "❌ Fail",
                    style: TextStyle(
                      color: isPass ? Colors.green : Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text("Status: ${entry.value}"),
                ),
              );
            }).toList(),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.popUntil(context, (route) => route.isFirst),
              child: const Text("Back to Home"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoTile(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Expanded(child: Text("$label:", style: const TextStyle(fontWeight: FontWeight.w600))),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}
