import 'package:flutter/material.dart';
import 'package:programmes/auth/auth_service.dart';
import 'package:programmes/auth/verify_email.dart';
import 'package:programmes/auth/welcome_page.dart';
import 'package:programmes/widgets/navigation.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthLayout extends StatelessWidget {
  final Widget? pageIfNotConnected;

  const AuthLayout({super.key, this.pageIfNotConnected});

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

            return const Navigation();
          },
        );
      }
    );
  }
}