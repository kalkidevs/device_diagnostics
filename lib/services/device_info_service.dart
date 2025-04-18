import 'package:battery_plus/battery_plus.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/services.dart';
import 'package:testing/models/device_info.dart';

class DeviceInfoService {
  static const platform = MethodChannel('com.tricker333.deviceinfo/channel');

  static Future<String> getTotalRAM() async {
    try {
      final ram = await platform.invokeMethod('getTotalRAM');
      return '$ram MB';
    } catch (e) {
      return 'Unavailable';
    }
  }

  static Future<String> getInternalStorage() async {
    try {
      final storage = await platform.invokeMethod('getInternalStorage');
      return '$storage MB';
    } catch (e) {
      return 'Unavailable';
    }
  }

  static Future<DeviceInfo> getDeviceInfo() async {
    final deviceInfoPlugin = DeviceInfoPlugin();
    final battery = Battery();
    final batteryLevel = await battery.batteryLevel;
    final connectivityResults = await Connectivity().checkConnectivity();
    final network = _getNetworkNameFromList(connectivityResults);

    final androidInfo = await deviceInfoPlugin.androidInfo;

    final ram = await getTotalRAM();
    final storage = await getInternalStorage();

    return DeviceInfo(
      imei: 'Unavailable',
      brand: androidInfo.brand,
      model: androidInfo.model,
      ram: await DeviceInfoNative.getTotalRAM(),
      storage: storage,
      battery: batteryLevel,
      network: network,
    );
  }

  static String _getNetworkNameFromList(List<ConnectivityResult> results) {
    if (results.contains(ConnectivityResult.wifi)) {
      return "Wi-Fi";
    } else if (results.contains(ConnectivityResult.mobile)) {
      return "Mobile Data";
    } else if (results.contains(ConnectivityResult.ethernet)) {
      return "Ethernet";
    } else {
      return "No Connection";
    }
  }
}

class DeviceInfoNative {
  static const platform = MethodChannel('com.tricker333.deviceinfo/channel');

  static Future<String> getTotalRAM() async {
    try {
      final ram = await platform.invokeMethod('getTotalRAM');
      return '$ram MB';
    } catch (e) {
      return 'Unavailable';
    }
  }

  static Future<String> getInternalStorage() async {
    try {
      final storage = await platform.invokeMethod('getInternalStorage');
      return '$storage MB';
    } catch (e) {
      return 'Unavailable';
    }
  }
}
