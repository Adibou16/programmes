import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:programmes/workout/exercise/exercise_image.dart';
import 'package:programmes/workout/exercise/exercise_table.dart';

part 'exercise_card.g.dart';

@HiveType(typeId: 1)
class ExerciseCard extends StatefulWidget {
  @HiveField(0)
  final String imageName;

  @HiveField(1)
  final List<List<int>> tableData;

  const ExerciseCard({super.key, required this.imageName, required this.tableData});

  @override
  State<ExerciseCard> createState() => _ExerciseCardState();
}

class _ExerciseCardState extends State<ExerciseCard> {
  @override

  Widget build(BuildContext context) {
    final String imageName = widget.imageName;
    final List<List<int>> tableData = widget.tableData;

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [

        Padding(
          padding: const EdgeInsets.all(10.0),
          child: ExerciseImageWidget(imageName: imageName),
        ),

        Expanded(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0.0, 10.0, 10.0, 10.0),
            child: ExerciseTableWidget(tableData: tableData),
          ),
        )
      ],
    );
  }
}