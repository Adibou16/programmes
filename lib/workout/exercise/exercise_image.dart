import 'package:flutter/material.dart';



class ExerciseImageWidget extends StatefulWidget {
  final String imagePath;
  const ExerciseImageWidget({super.key, required this.imagePath});

  @override
  State<ExerciseImageWidget> createState() => _ExerciseImageWidgetState();
}

class _ExerciseImageWidgetState extends State<ExerciseImageWidget> {
  @override
  Widget build(BuildContext context) {
    String imagePath = widget.imagePath;
    String imageName = imagePath.split('/').last.split('.').first;
    double width = MediaQuery.of(context).size.width;

    return Column(
      children: [
        Text(
          imageName,
          style: TextStyle(color: Colors.grey[300]),
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