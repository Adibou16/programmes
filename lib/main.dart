import 'package:flutter/material.dart';
import 'package:programmes/exercice.dart';

void main() {
  runApp(const MaterialApp(home: Set()));
}

class Set extends StatefulWidget {
  const Set({super.key});

  @override
  State<Set> createState() => _SetState();
}

class _SetState extends State<Set> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Musculation 1"),
      ),
      backgroundColor: Colors.grey[800],
      body: const Padding(
          padding: EdgeInsets.all(10.0),
          child: Exercice(),
      ),
    );
  }
}