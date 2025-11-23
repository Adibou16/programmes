import 'package:flutter/material.dart';
import 'package:programmes/database/boxes.dart';
import 'package:programmes/workout/workout_widget.dart';
import 'package:programmes/database/workout.dart';


class SelectWorkout extends StatefulWidget {
  SelectWorkout({super.key});

  @override
  State<SelectWorkout> createState() => _SelectWorkoutState();
}

class _SelectWorkoutState extends State<SelectWorkout> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: boxWorkouts.length,
      itemBuilder: (context, index) {

        if (index >= boxWorkouts.length) {
          return const SizedBox.shrink();
        }

        Workout workout = boxWorkouts.getAt(index);
        String title = workout.title;
        String workoutKey = 'key_$title'; // Get the actual key

        return Dismissible(
          key: ValueKey(workoutKey), // Use the workout key instead of index
          direction: DismissDirection.endToStart,
          background: Container(
            color: Colors.red[700],
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: const Icon(Icons.delete, color: Colors.white),
          ),

          confirmDismiss: (direction) async {
            final bool? confirm = await showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text("Supprimer programme d'entrainement",),
                content: Text('Voulez-vous vraiment supprimer "$title"?',),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: const Text('Non'),
                  ),
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(true),
                    child: const Text('Supprimer', style: TextStyle(color: Colors.red)),
                  ),
                ],
              ),
            );

            return confirm ?? false;
          },

          onDismissed: (direction) {
            setState(() {
              boxWorkouts.delete(workoutKey); // Delete by key instead of index
            });
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Supprimer "$title"')),
            );
          },

          child: Card(
            margin: const EdgeInsets.all(10.0),
            child: ListTile(
              title: Text(title),
              subtitle: Text(workout.description),
              trailing: const Icon(Icons.arrow_forward),
              onTap: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => WorkoutWidget(
                      exercises: workout.exercises,
                      workoutKey: workoutKey, 
                      name: title,
                    ),
                  ),
                );
                
                // Refresh the list when coming back
                if (mounted) {
                  setState(() {});
                }
              },
            ),
          ),
        );
      }
    );
  }
}