import 'package:flutter/material.dart';
import 'package:programmes/widgets/exercice.dart';

class SelectWorkout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card (
      color: Colors.grey[900],
      margin: const EdgeInsets.all(10.0),
      child: ListTile(
        title: const Text('Workout 1', style: TextStyle(color: Colors.white)),
        subtitle: const Text('Description du workout 1', style: TextStyle(color: Colors.white)),
        trailing: const Icon(Icons.arrow_forward, color: Colors.white),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Exercice()),
          );
        },
      ),
    );
  }
}