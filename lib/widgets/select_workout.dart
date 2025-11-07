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

      // Defensive: skip if index is out of range (can happen after deletion)
        if (index >= boxWorkouts.length) {
          return const SizedBox.shrink();
        }

        Workout workout = boxWorkouts.getAt(index);
        String title = workout.title;

        return  Dismissible(
          key: ValueKey('workout_$index'),
          direction: DismissDirection.endToStart, // swipe left to delete
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
                backgroundColor: Colors.grey[900],
                title: const Text(
                  "Supprimer programme d'entrainement",
                  style: TextStyle(color: Colors.white),
                ),
                content: Text(
                  'Voulez-vous vraiment supprimer "$title"?',
                  style: const TextStyle(color: Colors.white70),
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: const Text('Non', style: TextStyle(color: Colors.white70)),
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
            setState(() => boxWorkouts.deleteAt(index)); // Refresh list
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Supprimer "$title"')),
            );
          },

          child: Card (
            color: Colors.grey[900],
            margin: const EdgeInsets.all(10.0),
            child: ListTile(
              title: Text(title, style: const TextStyle(color: Colors.white)),
              subtitle: Text(workout.description, style: TextStyle(color: Colors.white)),
              trailing: const Icon(Icons.arrow_forward, color: Colors.white),
              onTap: () async {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) => const Center(child: CircularProgressIndicator()),
                );
                await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => WorkoutWidget(exercises: workout.exercises, workoutIndex: index, name: title)),
                );
                
                // Show loading again after pop
                if (mounted) {
                  Navigator.of(context).pop(); // Remove previous loading dialog
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) => const Center(child: CircularProgressIndicator()),
                  );
                  if (mounted) Navigator.of(context).pop(); // Remove loading dialog
                  setState(() {}); // Refresh when coming back
                }
              },
            ),
          ),
        );
      }
    );
  }
}


