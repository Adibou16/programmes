import 'package:flutter/material.dart';
import 'package:programmes/workout/workout_widget.dart';
import 'package:programmes/database/workout_repository.dart';


class SelectWorkout extends StatefulWidget {
  const SelectWorkout({super.key});

  @override
  State<SelectWorkout> createState() => _SelectWorkoutState();
}

class _SelectWorkoutState extends State<SelectWorkout> {
  final WorkoutRepository repo = WorkoutRepository();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return FutureBuilder(
      future: repo.getAllWorkoutsAsync(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final workouts = snapshot.data!;

        return ListView.builder(
          itemCount: workouts.length,
          itemBuilder: (context, index) {
            final workout = workouts[index];

            return Dismissible(
              key: ValueKey(workout.id),
              direction: DismissDirection.endToStart,
              onDismissed: (direction) async {
                await repo.deleteWorkout(workout.id);
                setState(() {}); // refresh
              },
              background: Container(
                color: Colors.redAccent,
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
                    setState(() {});
                  },
                ),
              ),
            );
          },
        );
      },
    );
  }
}