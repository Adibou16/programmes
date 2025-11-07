import 'package:flutter/material.dart';
import 'package:programmes/workout/exercise/exercise_image.dart';
import 'package:programmes/workout/exercise/exercise_table.dart';


class ExerciseCard extends StatefulWidget {
  final String imagePath;

  final List<List<int>> tableData;

  final int? workoutIndex;
  final int? exerciseIndex;

  const ExerciseCard({super.key, required this.imagePath, required this.tableData, this.workoutIndex, this.exerciseIndex});

  @override
  State<ExerciseCard> createState() => _ExerciseCardState();
}

class _ExerciseCardState extends State<ExerciseCard> {
  @override

  Widget build(BuildContext context) {
    final String imagePath = widget.imagePath;
    final List<List<int>> tableData = widget.tableData;

    return Card(
      elevation: 0,
      clipBehavior: Clip.antiAlias,
      color: Colors.grey[900],
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
      
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: ExerciseImage(imagePath: imagePath),
          ),
      
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
              child: ExerciseTable(tableData: tableData, workoutIndex: widget.workoutIndex, exerciseIndex: widget.exerciseIndex),
            ),
          ),
          
          const SizedBox(width: 10)
        ],
      ),
    );
  }
}