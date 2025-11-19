import 'package:flutter/material.dart';

class ExerciseImage extends StatefulWidget {
  final String imagePath;
  const ExerciseImage({super.key, required this.imagePath});

  @override
  State<ExerciseImage> createState() => _ExerciseImageState();
}

class _ExerciseImageState extends State<ExerciseImage> {
  @override
  Widget build(BuildContext context) {
    String imagePath = widget.imagePath;
    String imageName = imagePath.split('/').last.split('.').first;
    double width = MediaQuery.of(context).size.width;

    return Column(
      children: [
        ConstrainedBox(
          constraints: BoxConstraints(maxWidth: width * 0.25),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              imageName,
              maxLines: 2,
              style: TextStyle(color: Colors.grey[300]),
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(imagePath),
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