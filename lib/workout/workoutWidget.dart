import 'package:flutter/material.dart';
import 'package:programmes/database/boxes.dart';
import 'package:programmes/workout/exercise/exercise_card.dart';

class WorkoutWidget extends StatefulWidget {
  final List<ExerciseCard> exercises;
  final int workoutIndex;

  const WorkoutWidget({super.key, required this.exercises, required this.workoutIndex});

  @override
  State<WorkoutWidget> createState() => _WorkoutWidgetState();
}

class _WorkoutWidgetState extends State<WorkoutWidget> {
  @override

  Widget build(BuildContext context) {
    final exercises = widget.exercises;
    final workoutIndex = widget.workoutIndex;
    
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

      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
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
          ),
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: () {
              setState(() {
                boxWorkouts.deleteAt(workoutIndex);
                Navigator.pop(context);
              });
            },
          ),
        ],
      ),
    );
  }
}