import 'package:flutter/material.dart';
import 'package:programmes/database/workout_repository.dart';
import 'package:programmes/database/workout.dart';
import 'package:programmes/database/exercise_data.dart';
import 'package:programmes/workout/exercise/exercise_card.dart';
import 'package:programmes/new_workout/new_workout_second.dart';

class WorkoutWidget extends StatefulWidget {
  final String workoutId;
  final String name;

  const WorkoutWidget({super.key, required this.workoutId, required this.name});

  @override
  State<WorkoutWidget> createState() => _WorkoutWidgetState();
}

class _WorkoutWidgetState extends State<WorkoutWidget> {
  final WorkoutRepository _repo = WorkoutRepository();
  Workout? _workout;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadWorkout();
  }

  Future<void> _loadWorkout() async {
    final w = await _repo.getWorkoutById(widget.workoutId);

    if (w == null) {
      if (mounted) Navigator.pop(context);
    } else {
      setState(() {
        _workout = w;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading || _workout == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final exercises = _workout!.exercises;
    final description = _workout!.description;
    final name = widget.name;

    return Scaffold(
      appBar: AppBar(
        title: Text(name),
        actions: [
          CircleAvatar(
            backgroundColor: Colors.blue,
            child: IconButton(
              icon: const Icon(Icons.edit, color: Colors.black),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: const Text("Modifier programme d'entrainement"),
                    content: Text('Voulez-vous modifier "$name"?'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Non'),
                      ),
                      TextButton(
                        onPressed: () {
                          if (exercises.isEmpty) {
                            exercises.add(ExerciseData(
                              exerciseName: 'no name',
                              imagePath: 'exercise_images/other;/null.jpg',
                              tableData: [[0, 0, 0, 0]],
                            ));
                          }
                          Navigator.pop(context);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => NewWorkoutSecond(
                                name: name,
                                description: description,
                                weeks: exercises[0].tableData.length,
                                exercises: exercises,
                              ),
                            ),
                          );
                        },
                        child: const Text('Modifier', style: TextStyle(color: Colors.blue)),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: exercises.length,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          final e = exercises[index];
          return ExerciseCard(
            exerciseName: e.exerciseName.isNotEmpty
                ? e.exerciseName
                : e.imagePath.split('/').last.split('.').first,
            imagePath: e.imagePath,
            tableData: e.tableData,
            workoutId: widget.workoutId,
            exerciseIndex: index,
          );
        },
      ),
    );
  }
}
