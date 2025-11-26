import 'package:flutter/material.dart';
import 'package:programmes/database/workout.dart';
import 'package:programmes/new_workout/new_exercise_card.dart';
import 'package:programmes/widgets/navigation.dart';
import 'package:programmes/workout/exercise/exercise_card.dart';
import 'package:programmes/database/exercise_data.dart';
import 'package:uuid/uuid.dart';
import 'package:programmes/database/workout_repository.dart';


class NewWorkoutSecond extends StatefulWidget {
  final String name;
  final String description;
  final int weeks;
  final List<ExerciseData>? exercises;

  const NewWorkoutSecond({
    super.key,
    required this.name,
    required this.description,
    required this.weeks,
    this.exercises,
  });

  @override
  State<NewWorkoutSecond> createState() => _NewWorkoutSecondState();
}

class _NewWorkoutSecondState extends State<NewWorkoutSecond> {
  late List<Map<String, dynamic>> exercisesData = [];

  final ExerciseCard blank = const ExerciseCard(
    exerciseName: '',
    imagePath: 'exercise_images/other/null.jpg',
    tableData: [[0, 0, 0, 0]],
  );

  @override
  void initState() {
    super.initState();
    if (widget.exercises != null && widget.exercises!.isNotEmpty) {
      for (final exerciseData in widget.exercises!) {
        addExerciseCardWithData(
          exerciseData.exerciseName ?? exerciseData.imagePath.split('/').last.split('.').first, 
          exerciseData.imagePath, 
          exerciseData.tableData
        );
      }
    } else {
      addNewExerciseCard();
    }
  }

  void addNewExerciseCard() {
    setState(() {
      exercisesData.add({
        'id': const Uuid().v4(), 
        'data': blank,
        'key': GlobalKey(),
      });
    });
  }

   void addExerciseCardWithData(String exerciseName, String imagePath, List<List<int>> tableData) {
    setState(() {
      exercisesData.add({
        'id': const Uuid().v4(), 
        'data': ExerciseCard(
          exerciseName: exerciseName,
          imagePath: imagePath,
          tableData: tableData,
        ),
        'key': GlobalKey(),
      });
    });
  }

  void deleteExerciseCard(String id) {
    setState(() {
      exercisesData.removeWhere((item) => item['id'] == id);
    });
  }

  void reorderExercises(int oldIndex, int newIndex) {
    setState(() {
      if (newIndex > oldIndex) {
        newIndex -= 1;
      }
      final item = exercisesData.removeAt(oldIndex);
      exercisesData.insert(newIndex, item);
    });
  }

  @override
  Widget build(BuildContext context) {
    final name = widget.name.isEmpty ? 'Sans nom' : widget.name;
    final description = widget.description;

    return Scaffold(
      appBar: AppBar(
        title: Text(name),

        actions: <Widget> [
          CircleAvatar(
            backgroundColor: Colors.blue,
            child: IconButton(
              icon: const Icon(Icons.save_alt, color: Colors.black),
              onPressed: () {
                showDialog(
                  context: context, 
                  builder: (context) => AlertDialog(
                    title: const Text("Sauvegarder programme d'entrainement"),
                    content: Text('Voulez-vous enregistrer "$name"?'),
                    actions: [
                      MaterialButton(
                        onPressed: () => Navigator.pop(context), 
                        child: const Text('Non')
                      ),
                      MaterialButton(
                        onPressed: () async {
                          final key = const Uuid().v4();
                          final workout = Workout(
                              id: key,
                              title: name,
                              description: description,
                              exercises: exercisesData
                                .map((e) {
                                  final ExerciseCard card = e['data'] as ExerciseCard;
                                  return ExerciseData(
                                    exerciseName: card.exerciseName,
                                    imagePath: card.imagePath,
                                    tableData: card.tableData,
                                  );
                                })
                                .toList(),
                            );

                          final repo = WorkoutRepository();
                          await repo.uploadWorkout(key, workout);

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Sauvegarder "$name"')),
                          );
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => const Navigation()),
                            (route) => false,
                          );
                        }, 
                        child: const Text('Sauvegarder', style: TextStyle(color: Colors.blue))
                      ),
                    ],
                  )
                );
              },
            ),
          ),
        ],
      ),

      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            ReorderableListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: exercisesData.length,
              onReorder: reorderExercises,
              proxyDecorator: (child, index, animation) {
                return Material(
                  elevation: 8,
                  color: Colors.transparent,
                  child: child,
                );
              },
              itemBuilder: (context, index) {
                final exercise = exercisesData[index];
                final ExerciseCard cardData = exercise['data'] as ExerciseCard;

                return Stack(
                  key: ValueKey(exercise['id']),
                  alignment: Alignment.center,
                  children: [
                    NewExerciseCard(
                      key: exercise['key'],
                      weeks: widget.weeks,
                      exerciseIndex: index,
                      initialData: cardData,
                      workoutUpdated: (updatedExercise) {
                        setState(() {
                          exercisesData[index]['data'] = updatedExercise;
                        });
                      },
                    ),
                    Positioned(
                      right: -6,
                      top: -6,
                      child: IconButton(
                        icon: const Icon(Icons.remove_circle, color: Colors.redAccent),
                        onPressed: () {
                          if (exercisesData.length <= 1) {
                            showDialog(
                              context: context, 
                              builder: (context) => AlertDialog(
                                title: const Text("Erreur", style: TextStyle(color: Colors.redAccent)),
                                content: const Text("Un programme d'entrainement doit contenir au moins 1 exercice."),
                                actions: [
                                  MaterialButton(
                                    onPressed: () => Navigator.pop(context), 
                                    child: const Text('Continuer')
                                  ),
                                 
                                ],
                              )
                            );
                          } else {
                            deleteExerciseCard(exercise['id']);
                          }
                        }
                      ),
                    ),
                    Positioned(
                      bottom: -4,
                      child: ReorderableDragStartListener(
                        index: index,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Icon(
                            Icons.drag_handle,
                            color: Colors.grey[600],
                            size: 24,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),

            const SizedBox(height: 10),

            CircleAvatar(
              backgroundColor: Colors.blue,
              child: IconButton(
                onPressed: () => addNewExerciseCard(),
                icon: const Icon(Icons.add, color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}