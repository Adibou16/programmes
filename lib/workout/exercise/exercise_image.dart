import 'package:flutter/material.dart';
import 'dart:io';
import 'package:programmes/themes/theme_extensions.dart';


class ExerciseImage extends StatefulWidget {
  final String exerciseName;
  final String imagePath;
  const ExerciseImage({super.key, required this.exerciseName, required this.imagePath});

  @override
  State<ExerciseImage> createState() => _ExerciseImageState();
}

class _ExerciseImageState extends State<ExerciseImage> {
  ImageProvider getImageProvider(String path) {
    if (path.startsWith('exercise_images') | path.startsWith('exercise_images')) {
      return AssetImage(path);
    }
    return FileImage(File(path));
  }

  @override
  Widget build(BuildContext context) {
    String imageName = widget.exerciseName;
    String imagePath = widget.imagePath;

    double width = MediaQuery.of(context).size.width;
    final colors = Theme.of(context).extension<AppColors>()!;


    return Column(
      children: [
        ConstrainedBox(
          constraints: BoxConstraints(maxWidth: width * 0.25),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              imageName,
              maxLines: 2,
              style: TextStyle(color: colors.header),
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: getImageProvider(imagePath),
              fit: BoxFit.cover,
              ),
          ),
          width: width * 0.25,
          height: width * 0.25,
        ),
      ],
    );
  }
}