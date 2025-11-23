import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:programmes/auth/auth_layout.dart';
import 'package:programmes/database/boxes.dart';
import 'package:programmes/database/workout.dart';
import 'package:programmes/database/exercise_data.dart';
import 'package:programmes/themes/themes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';


Future<void> main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(WorkoutAdapter());
  Hive.registerAdapter(ExerciseDataAdapter());
  boxWorkouts = await Hive.openBox<Workout>('workoutBox');

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MaterialApp(
    theme: lightMode,
    initialRoute: "/navigation",
    routes: {
      "/navigation": (context) => const AuthLayout(),
    },
  ));
} 