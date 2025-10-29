import 'package:flutter/material.dart';
import 'package:programmes/database/boxes.dart';
import 'package:programmes/workout/workoutWidget.dart';
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

        return  Card (
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
        );
      }
    );
  }
}


