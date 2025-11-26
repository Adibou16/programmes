import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'workout.dart';

class WorkoutRepository {
  Box<Workout>? _box;
  StreamSubscription? _firestoreListener;

  // ----------------------------
  //  BOX NAME PER USER
  // ----------------------------
  String get _boxName {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) throw Exception("User not logged in");
    return 'workoutBox_$uid';
  }

  // ----------------------------
  // ENSURE BOX IS OPEN
  // ----------------------------
  Future<Box<Workout>> _openIfNeeded() async {
    _box ??= Hive.isBoxOpen(_boxName)
        ? Hive.box<Workout>(_boxName)
        : await Hive.openBox<Workout>(_boxName);

    return _box!;
  }

  // ----------------------------
  // GET WORKOUTS
  // ----------------------------
  Future<List<Workout>> getAllWorkoutsAsync() async {
    final box = await _openIfNeeded();
    return box.values.toList();
  }

  List<Workout> getAllWorkouts() {
    if (!Hive.isBoxOpen(_boxName)) return [];
    _box ??= Hive.box<Workout>(_boxName);
    return _box!.values.toList();
  }

  Future<Workout?> getWorkoutById(String id) async {
    final box = await _openIfNeeded(); // private method used internally
    return box.get(id);
  }

  // ----------------------------
  // ADD / UPDATE / DELETE
  // ----------------------------
  Future<void> saveWorkout(Workout w) async {
    final box = await _openIfNeeded();
    await box.put(w.id, w);
    await uploadWorkout(w);
  }

  Future<void> deleteWorkout(String id) async {
    final box = await _openIfNeeded();
    await box.delete(id);

    // Remove from Firestore also
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid != null) {
      FirebaseFirestore.instance
          .collection("users")
          .doc(uid)
          .collection("workouts")
          .doc(id)
          .delete();
    }
  }

  // ----------------------------
  // FIRESTORE UPLOAD
  // ----------------------------
  Future<void> uploadWorkout(Workout w) async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return;

    await FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .collection("workouts")
        .doc(w.id)
        .set(w.toMap(), SetOptions(merge: true));
  }

  Future<void> uploadAll() async {
    final box = await _openIfNeeded();
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return;

    final col = FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .collection("workouts");

    for (var workout in box.values) {
      await col.doc(workout.id).set(workout.toMap(), SetOptions(merge: true));
    }
  }

  Future<void> updateExerciseValue(
    String workoutId,
    int exerciseIndex,
    int rowIndex,
    int colIndex, 
    int newValue
  ) async {
    final box = await _openIfNeeded();
    final workout = box.get(workoutId);
    if (workout == null) return;

    // Update the specific cell
    workout.exercises[exerciseIndex].tableData[rowIndex][colIndex] = newValue;

    // Save back to Hive
    await box.put(workoutId, workout);

    // Optionally upload to Firestore
    await uploadWorkout(workout);
  }


  // ----------------------------
  // FIRESTORE DOWNLOAD (ONE TIME)
  // ----------------------------
  Future<void> downloadWorkouts() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return;

    final box = await _openIfNeeded();

    final snapshot = await FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .collection("workouts")
        .get();

    for (var doc in snapshot.docs) {
      final w = Workout.fromMap(doc.data());
      await box.put(w.id, w);
    }
  }

  // ----------------------------
  // LIVE FIRESTORE → HIVE SYNC
  // ----------------------------
  void liveSync() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return;

    // Avoid duplicate listener
    await _firestoreListener?.cancel();

    final col = FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .collection("workouts");

    final box = await _openIfNeeded();

    _firestoreListener = col.snapshots().listen((snapshot) async {
      for (var doc in snapshot.docs) {
        final w = Workout.fromMap(doc.data());
        await box.put(w.id, w);
      }

      // Delete removed workouts locally
      final serverIds = snapshot.docs.map((d) => d.id).toSet();
      final localIds = box.keys.cast<String>().toSet();

      for (final id in localIds) {
        if (!serverIds.contains(id)) {
          await box.delete(id);
        }
      }
    });
  }

  // ----------------------------
  // CLEANUP ON LOGOUT
  // ----------------------------
  Future<void> closeForLogout() async {
    await _firestoreListener?.cancel();
    _firestoreListener = null;

    if (_box != null && _box!.isOpen) {
      await _box!.close();
      _box = null;
    }
  }
}
