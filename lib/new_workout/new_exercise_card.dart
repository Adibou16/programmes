import 'package:flutter/material.dart';
import 'package:programmes/new_workout/new_exercise_image.dart';
import 'package:programmes/new_workout/new_exercise_table.dart';
import 'package:programmes/workout/exercise/exercise_card.dart';


class NewExerciseCard extends StatefulWidget {
  final int weeks;
  final int exerciseIndex;
  final ExerciseCard initialData;
  final Function(ExerciseCard)? workoutUpdated;

  const NewExerciseCard({
    super.key, 
    required this.weeks, 
    required this.exerciseIndex, 
    required this.initialData,
    this.workoutUpdated
  });

  @override
  State<NewExerciseCard> createState() => _NewExerciseCardState();
}

class _NewExerciseCardState extends State<NewExerciseCard> {
  late String imagePath;
  late List<List<int>> tableData;

  @override
  void initState() {
    super.initState();
    _loadDataFromWidget();
  }

  void _loadDataFromWidget() {
    imagePath = widget.initialData.imagePath;
    tableData = List.from(widget.initialData.tableData.map((row) => List<int>.from(row)));
  }

  @override
  void didUpdateWidget(covariant NewExerciseCard oldWidget) {
    super.didUpdateWidget(oldWidget);
     if (widget.initialData != oldWidget.initialData) {
      setState(() {
        _loadDataFromWidget();
      });
    }
  }

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

    return Card(
      elevation: 0,
      clipBehavior: Clip.antiAlias,
      color: Colors.grey[900],
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: NewExerciseImage(
              initialImagePath: imagePath,
              onImageSelected: (path) {
                setState(() {
                  imagePath = path;
                });
                notifyParent();
              },
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 10.0, 10.0, 10.0),
              child: NewExerciseTable(
                weeks: weeks,
                initialTableData: tableData,
                onTableChanged: (table) {
                  setState(() {
                    tableData = table;
                  });
                  notifyParent();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}