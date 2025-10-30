import 'package:flutter/material.dart';



class ExerciseImageWidget extends StatefulWidget {
  final String imageName;
  const ExerciseImageWidget({super.key, required this.imageName});

  @override
  State<ExerciseImageWidget> createState() => _ExerciseImageWidgetState();
}

class _ExerciseImageWidgetState extends State<ExerciseImageWidget> {
  @override
  Widget build(BuildContext context) {
    String imageName = widget.imageName;
    String imagePath = 'assets/exercise_images/$imageName.jpg';
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