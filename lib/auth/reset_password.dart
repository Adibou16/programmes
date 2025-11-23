import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:programmes/auth/auth_service.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  TextEditingController emailController = TextEditingController();
  String errorMessage = '';

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  void resetPassword() async {
    try {
      await authService.value.resetPassword(email: emailController.text);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('SVP regarder vos emails')),
      );  
      setState(() {
        errorMessage = '';
      });
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message ?? 'Il y a un erreur';
      });
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Center(
              child: Text("Réinitialiser le mot de passe"),
            ),

            const SizedBox(height: 10),

            // Email
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: "Email",
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            const SizedBox(height: 10),

            Text(
              errorMessage,
              style: const TextStyle(color: Colors.redAccent),
            ),

            const SizedBox(height: 10),

            TextButton(
              onPressed: () => resetPassword(), 
              child: const Text("Changer le mot de passe"),
            )
          ],
        ),
      ),
    );
  }
}