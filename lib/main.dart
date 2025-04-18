import 'package:flutter/material.dart';

import 'screens/device_info_screen.dart';

void main() {
  runApp(DeviceDiagnosticsApp());
}

class DeviceDiagnosticsApp extends StatelessWidget {
  const DeviceDiagnosticsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Device Diagnostics',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        brightness: Brightness.light,
        primaryColor: Colors.deepPurpleAccent,
        hintColor: Colors.pinkAccent,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(
          color: Colors.deepPurpleAccent,
          elevation: 4,
          iconTheme: IconThemeData(color: Colors.white),
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        textTheme: TextTheme(
          bodyLarge: TextStyle(color: Colors.black87, fontSize: 16),
          bodyMedium: TextStyle(color: Colors.black54, fontSize: 14),
          titleLarge: TextStyle(color: Colors.deepPurpleAccent, fontSize: 22),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.deepPurpleAccent,
            padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
        ),
      ),
      home: DeviceInfoScreen(),
    );
  }
}
