import 'package:flutter/material.dart';
import 'package:dice_app/Gradiant_Container.dart';
void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        body: GradientContainer([const Color.fromARGB(255, 250, 250, 250), const Color.fromARGB(255, 159, 95, 95)]),
      ),
    ),
  );
}

