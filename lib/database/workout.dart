import 'package:programmes/workout/exercise/exercise_card.dart';
import 'package:hive/hive.dart';

part 'workout.g.dart';

@HiveType(typeId: 0)
class Workout {
  @HiveField(0)
  String title;

  @HiveField(1)
  String description;

  @HiveField(2)
  List<ExerciseCard> exercises;

  Workout({
    required this.title, 
    required this.description, 
    required this.exercises
  });
}