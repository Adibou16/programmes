import 'package:flutter/material.dart';
import 'package:programmes/workout/exercise/exercise_card.dart';

class WorkoutWidget extends StatefulWidget {
  final List<ExerciseCard> exercises;

  const WorkoutWidget({super.key, required this.exercises});

  @override
  State<WorkoutWidget> createState() => _WorkoutWidgetState();
}

class _WorkoutWidgetState extends State<WorkoutWidget> {
  @override

  Widget build(BuildContext context) {
    final exercises = widget.exercises;
    
    return Scaffold(
      appBar: AppBar(
        title: const Text("Workout"),
        backgroundColor: Colors.grey[850],
        centerTitle: true,
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
        ),
      ),

      backgroundColor: Colors.black,

      body: ListView.builder(
        itemCount: exercises.length,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return Card(
            elevation: 0,
            clipBehavior: Clip.antiAlias,
            color: Colors.grey[900],
            child: exercises[index]
          );
        },
      ),
    );
  }
}