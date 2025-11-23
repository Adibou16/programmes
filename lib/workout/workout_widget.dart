import 'package:flutter/material.dart';
import 'package:programmes/new_workout/new_workout_second.dart';
import 'package:programmes/workout/exercise/exercise_card.dart';
import 'package:programmes/database/boxes.dart';
import 'package:programmes/database/workout.dart';
import 'package:programmes/database/exercise_data.dart';


class WorkoutWidget extends StatefulWidget {
  final List<ExerciseData> exercises;
  final String workoutKey; 
  final String name;

  const WorkoutWidget({super.key, required this.exercises, required this.workoutKey, required this.name});

  @override
  State<WorkoutWidget> createState() => _WorkoutWidgetState();
}

class _WorkoutWidgetState extends State<WorkoutWidget> {
  @override

  Widget build(BuildContext context) {
    var exercises = widget.exercises;
    final workoutKey = widget.workoutKey;
    final name = widget.name;
    final Workout? workout = boxWorkouts.get(workoutKey);
    
    if (workout == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pop(context);
      });
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }
    
    final String description = workout.description;
    
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
 
        actions: <Widget> [
          CircleAvatar(
            backgroundColor: Colors.blue,
            child: IconButton(
              icon: const Icon(Icons.edit, color: Colors.black),
              onPressed: () {
                showDialog(
                  context: context, 
                  builder: (context) => AlertDialog(
                    title: const Text("Modifier programme d'entrainement"),
                    content: Text('Voulez-vous modifier "$name"?'),
                    actions: [
                      MaterialButton(
                        onPressed: () => Navigator.pop(context), 
                        child: const Text('Non')
                      ),

                      MaterialButton(
                        onPressed: () {
                          if (exercises.isEmpty) {
                            exercises =  [ExerciseData(
                              exerciseName: 'no name',
                              imagePath: 'exercise_images/other;/null.jpg',
                              tableData: [[0, 0, 0, 0]]
                            )];
                          }
                          Navigator.pop(context);
                          Navigator.push(
                            context, 
                            MaterialPageRoute(
                              builder: (context) => NewWorkoutSecond(
                                name: name, 
                                description: description, 
                                weeks: exercises[0].tableData.length, 
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


      body: ListView.builder(
        itemCount: exercises.length,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return ExerciseCard(
            exerciseName: exercises[index].exerciseName ?? exercises[index].imagePath.split('/').last.split('.').first,
            imagePath: exercises[index].imagePath,
            tableData: exercises[index].tableData,
            workoutName: name,
            exerciseIndex: index,
          );
        },
      ),
    );
  }
}