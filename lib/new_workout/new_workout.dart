import 'package:flutter/material.dart';
import 'package:programmes/database/boxes.dart';
import 'package:programmes/database/workout.dart';
import 'package:programmes/new_workout/new_exercise_card.dart';
import 'package:programmes/new_workout/new_exercise_table.dart';
import 'package:programmes/pages/navigation.dart';
import 'package:programmes/workout/exercise/exercise_card.dart';

class NewWorkout extends StatefulWidget {
  const NewWorkout({super.key});

  @override
  State<NewWorkout> createState() => _NewWorkoutState();
}

class _NewWorkoutState extends State<NewWorkout> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  String imagePath = 'exercise_images/Back Squat.jpg';

  // List<ExerciseCard> hyperthropie1 = [
  //     ExerciseCard(imageName: 'Chin Ups', tableData: [[3, 10, 120, 0], [3, 12, 120, 0], [3, 12, 120, 0], [3, 8, 120, 0]]),
  //     ExerciseCard(imageName: 'Gorilla Pull', tableData: [[3, 8, 120, 0], [3, 8, 120, 0], [3, 8, 120, 0], [3, 8, 120, 0]]),
  //     ExerciseCard(imageName: 'Russian Twist', tableData: [[3, 20, 60, 0], [3, 20, 60, 0], [3, 20, 60, 0], [3, 20, 60, 0]])
  //     ];

  @override
  Widget build(BuildContext context) {
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

      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          TextField(
            controller: titleController,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              labelText: 'Workout Name',
              labelStyle: TextStyle(color: Colors.grey[400]),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey[700]!),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue),
              ),
            ),
          ),

          TextField(
            controller: descriptionController,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              labelText: 'Workout Description',
              labelStyle: TextStyle(color: Colors.grey[400]),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey[700]!),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue),
              ),
            ),
          ),

          const NewExerciseCard(),
          const NewExerciseCard(),
          const NewExerciseCard(),
          const NewExerciseCard(),
          const NewExerciseCard(),

          TextButton(
            onPressed: () {
              setState(() {
                boxWorkouts.put('key_${titleController.text}', 
                  Workout(
                    title: titleController.text, 
                    description: descriptionController.text, 
                    exercises: [ExerciseCard(imagePath: imagePath, tableData: [[3, 10, 120, 0], [3, 12, 120, 0], [3, 12, 120, 0], [3, 8, 120, 0]])])
                );
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

          // TextButton(
          //   onPressed: () async {
          //     imagePath = await Navigator.push(
          //       context, 
          //       MaterialPageRoute(builder: (context) => const ImageGallery()));
          //   },
          //   style: ButtonStyle(backgroundColor: WidgetStateProperty.all(Colors.blue)),
          //   child: const Text(
          //     'Choisir Image',
          //     style: TextStyle(
          //       color: Colors.white,
          //       fontSize: 20,
          //     ),
          //   ),
          // ),