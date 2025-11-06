import 'package:flutter/material.dart';
import 'package:programmes/workout/exercise/exercise_card.dart';

class WorkoutWidget extends StatefulWidget {
  final List<ExerciseCard> exercises;
  final int workoutIndex;
  final String name;

  const WorkoutWidget({super.key, required this.exercises, required this.workoutIndex, required this.name});

  @override
  State<WorkoutWidget> createState() => _WorkoutWidgetState();
}

class _WorkoutWidgetState extends State<WorkoutWidget> {
  @override

  Widget build(BuildContext context) {
    final exercises = widget.exercises;
    final workoutIndex = widget.workoutIndex;
    final name = widget.name;
    
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
        backgroundColor: Colors.grey[850],
        centerTitle: true,
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
        ),
      ),

      backgroundColor: Colors.black,

      body: Expanded(
        child: ListView.builder(
          itemCount: exercises.length,
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            return ExerciseCard(
              imagePath: exercises[index].imagePath,
              tableData: exercises[index].tableData,
              workoutIndex: workoutIndex,
              exerciseIndex: index,
            );
          },
        ),
      ),
    );
  }
}