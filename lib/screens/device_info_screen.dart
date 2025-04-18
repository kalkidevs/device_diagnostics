import 'package:flutter/material.dart';

import '../models/device_info.dart';
import '../services/device_info_service.dart';
import 'diagnostics_screen.dart';

class DeviceInfoScreen extends StatefulWidget {
  @override
  _DeviceInfoScreenState createState() => _DeviceInfoScreenState();
}

class _DeviceInfoScreenState extends State<DeviceInfoScreen> {
  DeviceInfo? _info;

  @override
  void initState() {
    super.initState();
    _loadDeviceInfo();
  }

  Future<void> _loadDeviceInfo() async {
    final info = await DeviceInfoService.getDeviceInfo();
    setState(() => _info = info);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Device Information'),
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body:
          _info == null
              ? Center(child: CircularProgressIndicator())
              : Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildInfoCard('IMEI', _info!.imei),
                    _buildInfoCard('Brand', _info!.brand),
                    _buildInfoCard('Model', _info!.model),
                    _buildInfoCard('RAM', '${_info!.ram} GB'),
                    _buildInfoCard('Storage', '${_info!.storage} GB'),
                    _buildInfoCard('Battery', '${_info!.battery}%'),
                    _buildInfoCard('Network', _info!.network),
                    Spacer(),
                    Center(
                      child: ElevatedButton(
                        onPressed:
                            () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (_) =>
                                        DiagnosticsScreen(deviceInfo: _info!),
                              ),
                            ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepPurpleAccent,
                          padding: EdgeInsets.symmetric(
                            horizontal: 40,
                            vertical: 15,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: Text(
                          "Start Diagnostics",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                  ],
                ),
              ),
    );
  }

  // Helper method to build info card widgets
  Widget _buildInfoCard(String title, String value) {
    return Card(
      elevation: 3,
      margin: EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.deepPurpleAccent,
              ),
            ),
            Text(
              value,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
