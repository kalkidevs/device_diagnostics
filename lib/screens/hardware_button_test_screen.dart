import 'package:flutter/material.dart';

class HardwareButtonTestScreen extends StatelessWidget {
  const HardwareButtonTestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Hardware Button Test")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Press Volume Up/Down to continue..."),
            ElevatedButton(
              onPressed: () {
                // You can wait for actual volume key input using a plugin (like volume_watcher)
                Navigator.pop(context, "Working");
              },
              child: const Text("Assume Working"),
            )
          ],
        ),
      ),
    );
  }
}
