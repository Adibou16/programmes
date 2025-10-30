import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:programmes/database/boxes.dart';
import 'package:programmes/database/images.dart';
import 'package:programmes/database/workout.dart';
import 'package:programmes/pages/navigation.dart';
import 'package:programmes/workout/exercise/exercise_card.dart';

Future<void> main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(WorkoutAdapter());
  Hive.registerAdapter(ExerciseCardAdapter());
  Hive.registerAdapter(ImagesAdapter());
  boxWorkouts = await Hive.openBox<Workout>('workoutBox');
  boxImages = await Hive.openBox<Images>('imagesBox');

  if (boxImages.isEmpty) {
    print("Empty");
    var imgDir = await Directory('assets/exercise_images').create(recursive: true);

    if (imgDir.existsSync()) {
      print("Exists");
    } else {
      print("FUCK");
    }
  }

  runApp(MaterialApp(
    initialRoute: "/navigation",
    routes: {
      "/navigation": (context) => const Navigation(),
    },
  ));
} 