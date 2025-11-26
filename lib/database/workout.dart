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
}

extension WorkoutMapper on Workout {
  Map<String, dynamic> toMap() => {
    "id": id,
    "title": title,
    "description": description,
    "exercises": exercises.map((e) => e.toMap()).toList(),
  };

  static Workout fromMap(Map<String, dynamic> map) => Workout(
    id: map["id"],
    title: map["title"],
    description: map["description"],
    exercises: (map["exercises"] as List)
        .map((e) => ExerciseData.fromMap(Map<String, dynamic>.from(e)))
        .toList(),
  );
}