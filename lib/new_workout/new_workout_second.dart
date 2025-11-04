import 'package:flutter/material.dart';
import 'package:programmes/database/boxes.dart';
import 'package:programmes/database/workout.dart';
import 'package:programmes/new_workout/new_exercise_card.dart';
import 'package:programmes/pages/navigation.dart';
import 'package:programmes/workout/exercise/exercise_card.dart';
import 'package:uuid/uuid.dart';

class NewWorkoutSecond extends StatefulWidget {
  final String name;
  final String description;
  final int weeks;

  const NewWorkoutSecond({
    super.key,
    required this.name,
    required this.description,
    required this.weeks,
  });

  @override
  State<NewWorkoutSecond> createState() => _NewWorkoutSecondState();
}

class _NewWorkoutSecondState extends State<NewWorkoutSecond> {
  late List<Map<String, dynamic>> exercisesData = [];

  final ExerciseCard blank = const ExerciseCard(
    imagePath: 'exercise_images/null.jpg',
    tableData: [[0, 0, 0, 0]],
  );

  @override
  void initState() {
    super.initState();
    addNewExerciseCard();
  }

  void addNewExerciseCard() {
    setState(() {
      exercisesData.add({
        'id': const Uuid().v4(), 
        'data': blank,
        'key': GlobalKey(), // Added GlobalKey
      });
    });
  }

  void deleteExerciseCard(String id) {
    setState(() {
      exercisesData.removeWhere((item) => item['id'] == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final name = widget.name;
    final description = widget.description;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Nouveau workout'),
        backgroundColor: Colors.grey[850],
        centerTitle: true,
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: exercisesData.length,
              itemBuilder: (context, index) {
                final exercise = exercisesData[index];
                return Stack(
                  children: [
                    NewExerciseCard(
                      key: exercise['key'], // Using GlobalKey instead of ValueKey
                      weeks: widget.weeks,
                      exerciseIndex: index,
                      initialData: exercise['data'],
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
                        onPressed: () => deleteExerciseCard(exercise['id']),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          const SizedBox(height: 10),
          CircleAvatar(
            backgroundColor: Colors.blue,
            child: IconButton(
              onPressed: addNewExerciseCard,
              icon: const Icon(Icons.add, color: Colors.black),
            ),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                boxWorkouts.put(
                  'key_$name',
                  Workout(
                    title: name,
                    description: description,
                    exercises: exercisesData.map((e) => e['data'] as ExerciseCard).toList(),
                  ),
                );
              });
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => Navigation()),
                ModalRoute.withName('/'),
              );
            },
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all(Colors.blue),
            ),
            child: const Text(
              'Créer nouveau workout',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}