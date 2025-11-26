import 'package:flutter/material.dart';
import 'package:programmes/workout/workout_widget.dart';
import 'package:programmes/database/workout_repository.dart';
import 'package:programmes/database/workout.dart';


class SelectWorkout extends StatefulWidget {
  const SelectWorkout({super.key});

  @override
  State<SelectWorkout> createState() => _SelectWorkoutState();
}

class _SelectWorkoutState extends State<SelectWorkout> {
  final WorkoutRepository repo = WorkoutRepository();
  List<Workout> workouts = [];

  @override
  void initState() {
    super.initState();
    _loadWorkouts();
  }

  Future<void> _loadWorkouts() async {
    final loaded = await repo.getAllWorkoutsAsync();
    setState(() {
      workouts = loaded;
    });
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    if (workouts.isEmpty) {
      return Center(child: Text('Ajoutez un workout!', style: textTheme.bodySmall));
    }

    return ListView.builder(
      itemCount: workouts.length,
      itemBuilder: (context, index) {
        final workout = workouts[index];

        return Dismissible(
          key: ValueKey(workout.id),
          direction: DismissDirection.endToStart,
          onDismissed: (direction) async {
            final removedWorkout = workouts.removeAt(index);
            setState(() {}); // rebuild the list

            await repo.deleteWorkout(removedWorkout.id);

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("${removedWorkout.title} deleted")),
            );
          },
          background: Container(
            color: Theme.of(context).colorScheme.error,
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: const Icon(Icons.delete, color: Colors.white),
          ),
          child: Card(
            margin: const EdgeInsets.all(8),
            child: ListTile(
              title: Text(workout.title, style: textTheme.bodyLarge),
              subtitle: Text(workout.description, style: textTheme.bodySmall),
              trailing: const Icon(Icons.arrow_forward),
              onTap: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => WorkoutWidget(
                      workoutId: workout.id,
                      name: workout.title,
                    ),
                  ),
                );
                // Reload after returning in case of edits
                _loadWorkouts();
              },
            ),
          ),
        );
      },
    );
  }
}
