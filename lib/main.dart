import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:programmes/database/boxes.dart';
import 'package:programmes/database/workout.dart';
import 'package:programmes/new_workout/new_exercise_card.dart';
import 'package:programmes/new_workout/new_workout.dart';
import 'package:programmes/pages/navigation.dart';
import 'package:programmes/workout/exercise/exercise_card.dart';

Future<void> main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(WorkoutAdapter());
  Hive.registerAdapter(ExerciseCardAdapter());
  boxWorkouts = await Hive.openBox<Workout>('workoutBox');

  runApp(MaterialApp(
    initialRoute: "/navigation",
    routes: {
      "/navigation": (context) => const NewWorkout(),
    },
  ));
} 