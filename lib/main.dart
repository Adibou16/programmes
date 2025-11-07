import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:programmes/database/boxes.dart';
import 'package:programmes/database/workout.dart';
import 'package:programmes/database/exercise_data.dart';
import 'package:programmes/pages/navigation.dart';

Future<void> main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(WorkoutAdapter());
  Hive.registerAdapter(ExerciseDataAdapter());
  boxWorkouts = await Hive.openBox<Workout>('workoutBox');

  runApp(MaterialApp(
    initialRoute: "/navigation",
    routes: {
      "/navigation": (context) => const Navigation(),
    },
  ));
} 