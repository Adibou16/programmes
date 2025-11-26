import 'package:flutter/material.dart';
import 'package:programmes/workout/workout_widget.dart';
import 'package:programmes/database/workout.dart';
import 'package:programmes/database/workout_repository.dart';


class SelectWorkout extends StatefulWidget {
  SelectWorkout({super.key});

  @override
  State<SelectWorkout> createState() => _SelectWorkoutState();
}

class _SelectWorkoutState extends State<SelectWorkout> {
  final WorkoutRepository repo = WorkoutRepository();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    final workouts = repo.getAllWorkouts();

    return ListView.builder(
      itemCount: workouts.length,
      itemBuilder: (context, index) {

        if (index >= workouts.length) {
          return const SizedBox.shrink();
        }

        Workout workout = workouts[index];
        String title = workout.title;
        final workoutId = workout.id;

        return Dismissible(
          key: ValueKey(workoutId), 
          direction: DismissDirection.endToStart,
          background: Container(
            color: Colors.redAccent,
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
                    child: const Text('Supprimer', style: TextStyle(color: Colors.redAccent)),
                  ),
                ],
              ),
            );

            return confirm ?? false;
          },

          onDismissed: (direction) async {
           await repo.deleteWorkout(workoutId);
           if (mounted) setState(() {});
          },

          child: Card(
            margin: const EdgeInsets.all(8.0),
            child: ListTile(
              title: Text(title, style: textTheme.bodyLarge),
              subtitle: Text(workout.description, style: textTheme.bodySmall),
              trailing: const Icon(Icons.arrow_forward),
              onTap: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => WorkoutWidget(
                      exercises: workout.exercises,
                      workoutId: workoutId, 
                      name: title,
                    ),
                  ),
                );
                
                // Refresh the list when coming back
                if (mounted) {setState(() {});
                }
              },
            ),
          ),
        );
      }
    );
  }
}