import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:programmes/auth/auth_service.dart';
import 'package:programmes/themes/theme_extensions.dart';


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
    final colors = Theme.of(context).extension<AppColors>()!;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "Réinitialiser le mot de passe",
                textAlign: TextAlign.center,
                style: textTheme.headlineMedium,
              ),
          
              const SizedBox(height: 10),
          
              // Email
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: "Email",
                    labelStyle: textTheme.bodyMedium,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: colors.border),
                    ),
                ),
              ),
          
              const SizedBox(height: 10),
          
              Text(
                errorMessage,
                style: const TextStyle(color: Colors.redAccent),
              ),
          
              const SizedBox(height: 10),
          
              FilledButton(
                onPressed: () => resetPassword(), 
                child: Text(
                  "Changer le mot de passe",
                  style: textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
              )
            ],
          ),
        ),
      ),
    );
  }
}