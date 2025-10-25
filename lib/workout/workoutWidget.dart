import 'package:flutter/material.dart';
import 'package:programmes/workout/exercise/exercise_card.dart';

class WorkoutWidget extends StatefulWidget {
  const WorkoutWidget({super.key});

  @override
  State<WorkoutWidget> createState() => _WorkoutWidgetState();
}

class _WorkoutWidgetState extends State<WorkoutWidget> {

  List<ExerciseCard> exercises = [ExerciseCard(imageName: 'Bench Press', tableData: [[10, 10, 10], [8, 8, 8], [6, 6, 6]]),
                                  ExerciseCard(imageName: 'Back Squat', tableData: [[12, 12, 12], [10, 10, 10], [8, 8, 8]]),
                                  ExerciseCard(imageName: 'Deadlift', tableData: [[5, 5, 5], [5, 5, 5], [5, 5, 5]])];

  @override
  Widget build(BuildContext context) {
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