import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hive/hive.dart';
import 'package:programmes/database/workout.dart';

class WorkoutRepository {
  final Box<Workout> _workoutsBox = Hive.box<Workout>('workoutBox');

  String get uid => FirebaseAuth.instance.currentUser!.uid;

  CollectionReference<Map<String, dynamic>> get _firestore =>
      FirebaseFirestore.instance
          .collection("users")
          .doc(uid)
          .collection("workouts");

  /// Download all workouts from Firestore to Hive
  Future<void> downloadWorkouts() async {
    try {
      final snapshot = await _firestore.get();

      for (var doc in snapshot.docs) {
        final workout = WorkoutMapper.fromMap(doc.data());
        await _workoutsBox.put(doc.id, workout);
      }
    } catch (e) {
      print('Error downloading workouts: $e');
    }
  }

  /// Upload a workout to Hive and Firestore safely
  Future<void> uploadWorkout(String workoutId, Workout workout) async {
    try {
      await _workoutsBox.put(workoutId, workout);
      await _firestore.doc(workoutId).set(workout.toMap());
    } catch (e) {
      print('Error uploading workout $workoutId: $e');
    }
  }

  /// Update a single exercise value
  Future<void> updateExerciseValue(
    String workoutId,
    int exerciseIndex,
    int rowIndex,
    int newValue,
  ) async {
    try {
      final workout = _workoutsBox.get(workoutId);
      if (workout == null) return;

      workout.exercises[exerciseIndex].tableData[rowIndex][3] = newValue;

      // Save to Hive
      await _workoutsBox.put(workoutId, workout);

      // Save to Firestore (toMap() now converts nested arrays correctly)
      await _firestore.doc(workoutId).set(workout.toMap());
    } catch (e) {
      print('Error updating exercise value: $e');
    }
  }

  /// Delete a workout from Hive and Firestore
  Future<void> deleteWorkout(String workoutId) async {
    try {
      await _workoutsBox.delete(workoutId);
      await _firestore.doc(workoutId).delete();
    } catch (e) {
      print('Error deleting workout $workoutId: $e');
    }
  }

  /// Listen to Firestore and keep Hive in sync
  void liveSync() {
    _firestore.snapshots().listen((snapshot) {
      for (var change in snapshot.docChanges) {
        final id = change.doc.id;

        try {
          if (change.type == DocumentChangeType.added ||
              change.type == DocumentChangeType.modified) {
            _workoutsBox.put(id, WorkoutMapper.fromMap(change.doc.data()!));
          } else if (change.type == DocumentChangeType.removed) {
            _workoutsBox.delete(id);
          }
        } catch (e) {
          print('Error syncing workout $id: $e');
        }
      }
    });
  }

  /// Get all workouts from Hive
  List<Workout> getAllWorkouts() => _workoutsBox.values.toList();
}