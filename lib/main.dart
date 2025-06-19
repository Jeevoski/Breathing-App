import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(BreathingApp());
}

class BreathingApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Breathing App',
      theme: ThemeData.dark(),
      home: BreathingScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class BreathingScreen extends StatefulWidget {
  @override
  _BreathingScreenState createState() => _BreathingScreenState();
}

class _BreathingScreenState extends State<BreathingScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  String instruction = "Breathe In";

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 4),
    )..addListener(() {
        setState(() {});
      });

    _animation = Tween<double>(begin: 100, end: 200).animate(_controller);

    _controller.repeat(reverse: true);

    Timer.periodic(Duration(seconds: 4), (timer) {
      setState(() {
        instruction =
            (instruction == "Breathe In") ? "Breathe Out" : "Breathe In";
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              instruction,
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 40),
            Container(
              width: _animation.value,
              height: _animation.value,
              decoration: BoxDecoration(
                color: Colors.blueAccent.withOpacity(0.7),
                shape: BoxShape.circle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
