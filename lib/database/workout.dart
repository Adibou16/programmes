import 'package:programmes/database/exercise_data.dart';
import 'package:hive/hive.dart';

part 'workout.g.dart';

@HiveType(typeId: 0)
class Workout {
  @HiveField(0)
  String id;

  @HiveField(1)
  String title;

  @HiveField(2)
  String description;

  @HiveField(3)
  List<ExerciseData> exercises;

  Workout({
    required this.id,
    required this.title, 
    required this.description, 
    required this.exercises
  });

  factory Workout.fromMap(Map<String, dynamic> map) {
    return Workout(
      id: map['id'],
      title: map['title'] ?? "",
      description: map['description'] ?? "",
      exercises: (map['exercises'] as List<dynamic>? ?? [])
          .map((e) => ExerciseData.fromMap(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "title": title,
      "description": description,
      "exercises": exercises.map((e) => e.toMap()).toList(),
    };
  }
}

