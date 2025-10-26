import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:programmes/database/boxes.dart';
import 'package:programmes/database/workout.dart';
import 'package:programmes/pages/navigation.dart';
import 'package:programmes/workout/exercise/exercise_card.dart';

Future<void> main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(WorkoutAdapter());
  Hive.registerAdapter(ExerciseCardAdapter());
  boxWorkouts = await Hive.openBox<Workout>('workoutBox');

  // boxWorkouts.put('key_Example', 
  //   Workout(
  //     title: 'Workout Example 1', 
  //     description: 'Description du workout 1', 
  //     exercises: [
  //       const ExerciseCard(imageName: 'Bench Press', tableData: [[10, 10, 10, 0], [8, 8, 8, 0], [6, 6, 6, 0]]),
  //       const ExerciseCard(imageName: 'Back Squat', tableData: [[12, 12, 12, 0], [10, 10, 10, 0], [8, 8, 8, 0]]),
  //       const ExerciseCard(imageName: 'Deadlift', tableData: [[5, 5, 5, 0], [5, 5, 5, 0], [5, 5, 5, 0]])
  //       ]
  //     )
  //   );

  runApp(MaterialApp(
    initialRoute: "/navigation",
    routes: {
      "/navigation": (context) => const Navigation(),
    },
  ));
} 