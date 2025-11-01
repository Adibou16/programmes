import 'package:flutter/material.dart';
import 'package:programmes/new_workout/new_exercise_image.dart';
import 'package:programmes/new_workout/new_exercise_table.dart';


class NewExerciseCard extends StatefulWidget {
  const NewExerciseCard({super.key});

  @override
  State<NewExerciseCard> createState() => _NewExerciseCardState();
}

class _NewExerciseCardState extends State<NewExerciseCard> {
  @override

  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      clipBehavior: Clip.antiAlias,
      color: Colors.grey[900],
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
      
          Padding(
            padding: EdgeInsets.all(10.0),
            child: NewExerciseImage(),
          ),
      
          Expanded(
            child: Padding(
              padding: EdgeInsets.fromLTRB(0.0, 10.0, 10.0, 10.0),
              child: NewExerciseTable(),
            ),
          )
        ],
      ),
    );
  }
}