import 'package:flutter/material.dart';
import 'package:programmes/database/boxes.dart';
import 'package:programmes/database/workout.dart';
import 'package:programmes/workout/exercise/exercise_card.dart';

class NewWorkout extends StatefulWidget {
  const NewWorkout({super.key});

  @override
  State<NewWorkout> createState() => _NewWorkoutState();
}

class _NewWorkoutState extends State<NewWorkout> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  List<ExerciseCard> exercisesExample = [
      ExerciseCard(imageName: 'Bench Press', tableData: [[12, 12, 12, 0], [10, 10, 10, 0], [8, 8, 8, 0]]),
      ExerciseCard(imageName: 'Back Squat', tableData: [[10, 10, 10, 0], [8, 8, 8, 0], [6, 6, 6, 0]]),
      ExerciseCard(imageName: 'Deadlift', tableData: [[5, 5, 5, 0], [5, 5, 5, 0], [5, 5, 5, 0]])
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            controller: titleController,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              labelText: 'Workout Name',
              labelStyle: TextStyle(color: Colors.grey[400]),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey[700]!),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue),
              ),
            ),
          ),
          TextField(
            controller: descriptionController,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              labelText: 'Workout Description',
              labelStyle: TextStyle(color: Colors.grey[400]),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey[700]!),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue),
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                boxWorkouts.put('key_${titleController.text}', 
                  Workout(
                    title: titleController.text, 
                    description: descriptionController.text, 
                    exercises: exercisesExample)
                );
              });
            },
            style: ButtonStyle(backgroundColor: WidgetStateProperty.all(Colors.blue)),
            child: const Text(
              'Create Example Workout',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}