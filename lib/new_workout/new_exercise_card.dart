import 'package:flutter/material.dart';
import 'package:programmes/new_workout/new_exercise_image.dart';
import 'package:programmes/new_workout/new_exercise_table.dart';
import 'package:programmes/workout/exercise/exercise_card.dart';


class NewExerciseCard extends StatefulWidget {
  final int weeks;
  final int exerciseIndex;
  final Function(ExerciseCard)? workoutUpdated;

  const NewExerciseCard({super.key, required this.weeks, required this.exerciseIndex, this.workoutUpdated});

  @override
  State<NewExerciseCard> createState() => _NewExerciseCardState();
}

class _NewExerciseCardState extends State<NewExerciseCard> {
  String imagePath = '';
  List<List<int>> tableData = [[0, 0, 0]];

  void notifyParent() {
    if (widget.workoutUpdated != null) {
      final exercise = ExerciseCard(
        imagePath: imagePath,
        tableData: tableData,
      );
      widget.workoutUpdated!(exercise);
    }
  }

  @override
  Widget build(BuildContext context) {
    int weeks = widget.weeks;

    final NewExerciseImage exerciseImage = NewExerciseImage(
      onImageSelected: (path) {
        setState(() {
          imagePath = path;
        });
        notifyParent();
      },
    );

    final NewExerciseTable exerciseTable = NewExerciseTable(
      weeks: weeks,
      onTableChanged: (table) {
        setState(() {
          tableData = table;
        });
        notifyParent();
      },
    );

    return Card(
      elevation: 0,
      clipBehavior: Clip.antiAlias,
      color: Colors.grey[900],
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
      
          Padding(
            padding: EdgeInsets.all(10.0),
            child: exerciseImage,
          ),
      
          Expanded(
            child: Padding(
              padding: EdgeInsets.fromLTRB(0.0, 10.0, 10.0, 10.0),
              child: exerciseTable,
            ),
          )
        ],
      ),
    );
  }
}