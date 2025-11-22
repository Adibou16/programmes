import 'package:hive/hive.dart';

part 'exercise_data.g.dart';

@HiveType(typeId: 1)
class ExerciseData {
  @HiveField(0)
  final String? exerciseName;

  @HiveField(1)
  final String imagePath;

  @HiveField(2)
  final List<List<int>> tableData;

  ExerciseData({
    required this.exerciseName,
    required this.imagePath,
    required this.tableData,
  });
}