import 'package:flutter/material.dart';
import 'package:programmes/auth/auth_service.dart';
import 'package:programmes/auth/verify_email.dart';
import 'package:programmes/auth/welcome_page.dart';
import 'package:programmes/widgets/navigation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:programmes/database/workout_repository.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:programmes/database/workout.dart';

class AuthLayout extends StatefulWidget {
  final Widget? pageIfNotConnected;

  const AuthLayout({super.key, this.pageIfNotConnected});

  @override
  State<AuthLayout> createState() => _AuthLayoutState();
}

class _AuthLayoutState extends State<AuthLayout> {
  User? _lastUser;
  bool _loading = false;

  Future<void> _onLoginSuccess(User user) async {
    if (_loading) return; 
    _loading = true;

    if (_lastUser != null && _lastUser!.uid != user.uid) {
      await Hive.box<Workout>('workoutBox_${_lastUser!.uid}').close();
    }

    _lastUser = user;

    final repo = WorkoutRepository();

    await Hive.openBox<Workout>('workoutBox_${user.uid}');

    await repo.downloadWorkouts();
    repo.liveSync();

    _loading = false;
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: authService,
      builder: (context, auth, child) {
        return StreamBuilder<User?>(
          stream: authService.value.authStateChanges,
          builder: (context, snapshot) {
            final user = snapshot.data;

            if (user == null) {
              return const WelcomePage();
            }

            if (!user.emailVerified) {
              return const VerifyEmail();
            }

            if (_lastUser?.uid != user.uid) {
              _onLoginSuccess(user);
            }

            return const Navigation();
          },
        );
      },
    );
  }
}
