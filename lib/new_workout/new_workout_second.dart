import 'package:flutter/material.dart';
import 'package:programmes/database/boxes.dart';
import 'package:programmes/database/workout.dart';
import 'package:programmes/new_workout/new_exercise_card.dart';
import 'package:programmes/pages/navigation.dart';
import 'package:programmes/workout/exercise/exercise_card.dart';

class NewWorkoutSecond extends StatefulWidget {
  final String name;
  final String description;
  final int weeks;

  const NewWorkoutSecond({super.key, required this.name, required this.description, required this.weeks});

  @override
  State<NewWorkoutSecond> createState() => _NewWorkoutSecondState();
}

class _NewWorkoutSecondState extends State<NewWorkoutSecond> {
  late List<NewExerciseCard> exercisesWidgets = [];
  late List<ExerciseCard> exercisesData = [];
  final ExerciseCard blank = const ExerciseCard(imagePath: 'exercise_images/null.jpg', tableData: [[0, 0, 0, 0]]);

  @override
  void initState() {
    super.initState();
    addNewExerciseCard(0);
  }

  void addNewExerciseCard(index) {
    exercisesData.add(blank);
    final newCard = NewExerciseCard(
      weeks: widget.weeks,
      exerciseIndex: index,
      workoutUpdated: (exercise) {
        print("UPDATED");
        setState(() {
          exercisesData[index] = exercise;
        });
      },
    );

    setState(() {
      exercisesWidgets.add(newCard);
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
              itemCount: exercisesWidgets.length,
              itemBuilder: (context, index) {
                return exercisesWidgets[index];
              }
            )
          ),

          const SizedBox(height: 10),

          CircleAvatar(
            backgroundColor: Colors.blue,
            child: IconButton(
              onPressed: () {
                setState(() {
                  addNewExerciseCard(exercisesWidgets.length + 1);
                });
              }, 
              icon: const Icon(Icons.add, color: Colors.black,)
            ),
          ),

          TextButton(
            onPressed: () {
              setState(() {
                boxWorkouts.put('key_$name', 
                  Workout(
                    title: name, 
                    description: description, 
                    exercises: exercisesData
                  )
                );
                print(exercisesData);
              });
              Navigator.pushAndRemoveUntil(
                context, 
                MaterialPageRoute(builder: (context) => Navigation()),
                ModalRoute.withName('/')
              );
            },
            style: ButtonStyle(backgroundColor: WidgetStateProperty.all(Colors.blue)),
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