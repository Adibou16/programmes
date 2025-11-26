import 'package:hive/hive.dart';

part 'exercise_data.g.dart';

@HiveType(typeId: 1)
class ExerciseData {
  @HiveField(0)
  final String exerciseName;

  @HiveField(1)
  final String imagePath;

  @HiveField(2)
  final List<List<int>> tableData;

  ExerciseData({
    required this.exerciseName,
    required this.imagePath,
    required this.tableData,
  });

  Map<String, dynamic> toMap() {
    return {
      "exerciseName": exerciseName,
      "imagePath": imagePath,
      "tableData": tableData.map((row) => {"row": row}).toList(),
    };
  }

  static ExerciseData fromMap(Map<String, dynamic> map) {
    return ExerciseData(
      exerciseName: map["exerciseName"],
      imagePath: map["imagePath"],
      tableData: (map["tableData"] as List)
          .map((e) => List<int>.from(e["row"]))
          .toList(),
    );
  }
}