// File: lib/models/device_info.dart
class DeviceInfo {
  final String imei;
  final String brand;
  final String model;
  final String ram;
  final String storage;
  final int battery;
  final String network;

  DeviceInfo({
    required this.imei,
    required this.brand,
    required this.model,
    required this.ram,
    required this.storage,
    required this.battery,
    required this.network,
  });
}
