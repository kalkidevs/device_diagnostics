import 'package:flutter/material.dart';

class MultiTouchTestScreen extends StatefulWidget {
  const MultiTouchTestScreen({super.key});

  @override
  State<MultiTouchTestScreen> createState() => _MultiTouchTestScreenState();
}

class _MultiTouchTestScreenState extends State<MultiTouchTestScreen> {
  final Map<int, Offset> _touchPoints = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Multi-Touch Test")),
      body: Listener(
        onPointerDown: (event) {
          setState(() {
            _touchPoints[event.pointer] = event.position;
          });
        },
        onPointerMove: (event) {
          setState(() {
            _touchPoints[event.pointer] = event.position;
          });
        },
        onPointerUp: (event) {
          setState(() {
            _touchPoints.remove(event.pointer);
          });

          if (_touchPoints.length > 1) {
            Navigator.pop(context, "Working");
          }
        },
        child: Stack(
          children: [
            Positioned.fill(
              child: Container(
                color: Colors.black.withOpacity(0.05),
                child: Center(
                  child: Text(
                    "Touch with 2 or more fingers",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
              ),
            ),
            ..._touchPoints.entries.map(
                  (e) => Positioned(
                left: e.value.dx - 25,
                top: e.value.dy - 25,
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.6),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text("${e.key}"),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
