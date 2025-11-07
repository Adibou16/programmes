import 'package:flutter/material.dart';
import 'package:programmes/new_workout/new_workout_second.dart';
import 'package:programmes/workout/exercise/exercise_card.dart';
import 'package:programmes/database/boxes.dart';
import 'package:programmes/database/workout.dart';
import 'package:programmes/database/exercise_data.dart';


class WorkoutWidget extends StatefulWidget {
  final List<ExerciseData> exercises;
  final int workoutIndex;
  final String name;

  const WorkoutWidget({super.key, required this.exercises, required this.workoutIndex, required this.name});

  @override
  State<WorkoutWidget> createState() => _WorkoutWidgetState();
}

class _WorkoutWidgetState extends State<WorkoutWidget> {
  @override

  Widget build(BuildContext context) {
    final exercises = widget.exercises;
    final workoutIndex = widget.workoutIndex;
    final name = widget.name;
    final Workout workout = boxWorkouts.getAt(workoutIndex);
    final String description = workout.description;
    
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
        backgroundColor: Colors.grey[850],
        centerTitle: true,
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
        ),
        actions: <Widget> [
          CircleAvatar(
            backgroundColor: Colors.blue,
            child: IconButton(
              icon: const Icon(Icons.edit, color: Colors.black),
              onPressed: () {
                showDialog(
                  context: context, 
                  builder: (context) => AlertDialog(
                    backgroundColor: Colors.grey[900],
                    title: const Text("Modifier programme d'entrainement", style: TextStyle(color: Colors.white70)),
                    content: Text('Voulez-vous modifier "$name"?', style: const TextStyle(color: Colors.white70)),
                    actions: [
                      MaterialButton(
                        onPressed: () => Navigator.pop(context), 
                        child: const Text('Non', style: TextStyle(color: Colors.white70))
                      ),
                      MaterialButton(
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.push(
                            context, 
                            MaterialPageRoute(
                              builder: (context) => NewWorkoutSecond(
                                name: name, 
                                description: description, 
                                weeks: exercises[0].tableData[0].length, 
                                exercises: exercises,
                              )
                            ),
                          );
                        }, 
                        child: const Text('Modifier', style: TextStyle(color: Colors.blue))
                      ),
                    ],
                  )
                );
              },
            ),
          ),
        ],
      ),

      backgroundColor: Colors.black,

      body: ListView.builder(
        itemCount: exercises.length,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return ExerciseCard(
            imagePath: exercises[index].imagePath,
            tableData: exercises[index].tableData,
            workoutIndex: workoutIndex,
            exerciseIndex: index,
          );
        },
      ),
    );
  }
}