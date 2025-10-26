import 'package:flutter/material.dart';
import 'package:programmes/database/boxes.dart';
import 'package:programmes/workout/exercise/exercise_card.dart';
import 'package:programmes/workout/workoutWidget.dart';
import 'package:programmes/database/workout.dart';


class SelectWorkout extends StatefulWidget {
  SelectWorkout({super.key});

  @override
  State<SelectWorkout> createState() => _SelectWorkoutState();
}

class _SelectWorkoutState extends State<SelectWorkout> {
  Workout workout1 = Workout(
    title: 'Workout Example 1', 
    description: 'Description du workout 1', 
    exercises: [
      const ExerciseCard(imageName: 'Bench Press', tableData: [[10, 10, 10, 0], [8, 8, 8, 0], [6, 6, 6, 0]]),
      ExerciseCard(imageName: 'Back Squat', tableData: [[12, 12, 12, 0], [10, 10, 10, 0], [8, 8, 8, 0]]),
      ExerciseCard(imageName: 'Deadlift', tableData: [[5, 5, 5, 0], [5, 5, 5, 0], [5, 5, 5, 0]])
      ]);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: boxWorkouts.length,
      itemBuilder: (context, index) {
        Workout workout = boxWorkouts.getAt(index);
        return  Card (
          color: Colors.grey[900],
          margin: const EdgeInsets.all(10.0),
          child: ListTile(
            title: Text(workout.title, style: const TextStyle(color: Colors.white)),
            subtitle: Text(workout.description, style: TextStyle(color: Colors.white)),
            trailing: const Icon(Icons.arrow_forward, color: Colors.white),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => WorkoutWidget(exercises: workout1.exercises, workoutIndex: index)),
              );
            },
          ),
        );
      }
    );
  }
}
      
    
      