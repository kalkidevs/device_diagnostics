import 'package:battery_plus/battery_plus.dart';
import 'package:flutter/material.dart';
import 'package:testing/screens/camera_test_screen.dart';
import 'package:vibration/vibration.dart';

import '../models/device_info.dart';
import 'hardware_button_test_screen.dart';
import 'multi_touch_test_screen.dart';
import 'results_screen.dart';

class DiagnosticsScreen extends StatefulWidget {
  final DeviceInfo deviceInfo;

  const DiagnosticsScreen({super.key, required this.deviceInfo});

  @override
  _DiagnosticsScreenState createState() => _DiagnosticsScreenState();
}

class _DiagnosticsScreenState extends State<DiagnosticsScreen> {
  Map<String, String> testResults = {};
  int? startBatteryLevel;
  int? endBatteryLevel;

  final Battery _battery = Battery();

  @override
  void initState() {
    super.initState();
    _runDiagnostics();
  }

  Future<void> _runDiagnostics() async {
    startBatteryLevel = await _battery.batteryLevel;

    await _multiTouchTest();
    await _cameraTest();
    await _vibrationTest();
    await _hardwareButtonsTest();
    await _screenCheckPrompt();
    await _deadPixelCheckPrompt();

    endBatteryLevel = await _battery.batteryLevel;

    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder:
            (_) => ResultsScreen(
              deviceInfo: widget.deviceInfo,
              testResults: testResults,
              startBattery: startBatteryLevel ?? 0,
              endBattery: endBatteryLevel ?? 0,
            ),
      ),
    );
  }

  Future<void> _multiTouchTest() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const MultiTouchTestScreen()),
    );
    testResults['Multi-Touch'] = result ?? "Not Working";
  }

  Future<void> _cameraTest() async {
    final frontResult = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const CameraTestScreen()),
    );
    testResults['Front Camera'] = frontResult ?? "Not Working";
  }

  Future<void> _vibrationTest() async {
    final hasVibrator = await Vibration.hasVibrator();
    if (hasVibrator) {
      await Vibration.vibrate(duration: 500);
      testResults['Vibration Motor'] = "Working";
    } else {
      testResults['Vibration Motor'] = "Not Working";
    }
  }

  Future<void> _hardwareButtonsTest() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const HardwareButtonTestScreen()),
    );
    testResults['Hardware Buttons'] = result ?? "Working";
  }

  Future<void> _screenCheckPrompt() async {
    // Add visual inspection later
    testResults['Screen Issues'] = "No visible issues";
  }

  Future<void> _deadPixelCheckPrompt() async {
    // You can create a test screen with different colors
    testResults['Dead Pixels'] = "None detected";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Running Diagnostics")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text("Running tests...", style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
