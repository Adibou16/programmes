import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:programmes/database/boxes.dart';
import 'package:programmes/database/images.dart';
import 'package:programmes/database/workout.dart';
import 'package:programmes/pages/navigation.dart';
import 'package:programmes/workout/exercise/exercise_card.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart';

Future<void> main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(WorkoutAdapter());
  Hive.registerAdapter(ExerciseCardAdapter());
  Hive.registerAdapter(ImagesAdapter());
  boxWorkouts = await Hive.openBox<Workout>('workoutBox');
  boxImages = await Hive.openBox<Images>('imagesBox');

  if (boxImages.isEmpty) {
    final appDir = await getApplicationDocumentsDirectory();
    final imgDir = Directory('${appDir.path}/exercise_images');

    final assetManifest = await AssetManifest.loadFromAssetBundle(rootBundle);
    final imagePaths = assetManifest
      .listAssets()
      .where((path) => path.startsWith('assets/exercise_images/'))
      .toList();
  
    for (String assetPath in imagePaths) {
      final fileName = assetPath.split('/').last;
      final byteData = await rootBundle.load(assetPath);
      final file = File('${imgDir.path}/$fileName');
      await file.writeAsBytes(byteData.buffer.asUint8List());
    }

      if (imgDir.existsSync()) {
        final files = imgDir.listSync(recursive: false, followLinks: false);

        for (var file in files) {
          final String fileName = file.path.split('/').last;

          if (file is File) {
            final imgBytes = await file.readAsBytes();
            boxImages.put('key_$fileName', Images(name: fileName, image: imgBytes));
          }
        }
      } else {
        print("ERROR CREATING IMAGES");
      }
  }

  runApp(MaterialApp(
    initialRoute: "/navigation",
    routes: {
      "/navigation": (context) => const Navigation(),
    },
  ));
} 