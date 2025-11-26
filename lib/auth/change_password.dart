import 'package:flutter/material.dart';
import 'package:programmes/auth/auth_service.dart';
import 'package:programmes/themes/theme_extensions.dart';


class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  TextEditingController emailController = TextEditingController();
  TextEditingController currentPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  void updatePassword() async {
    try {
      await authService.value.resetPasswordFromCurrentPassword(
        email: emailController.text,
        currentPassword: currentPasswordController.text,
        newPassword: newPasswordController.text 
      );  
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Theme.of(context).snackBarTheme.backgroundColor,
        content: const Text('Mot de passe changer')
        )
      );
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Theme.of(context).colorScheme.error,
        content: const Text('Échec du changement de mot de passe')
        )
      );
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
                "Changer le mot de passe",
                textAlign: TextAlign.center,
                style: textTheme.headlineMedium,
              ),
          
              const SizedBox(height: 20),
          
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

              // Current
              TextField(
                controller: currentPasswordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: "Mot de passe actuel",
                    labelStyle: textTheme.bodyMedium,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: colors.border),
                    ),
                ),
              ),

              const SizedBox(height: 10),

              // New
              TextField(
                controller: newPasswordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: "Nouveau mot de passe",
                    labelStyle: textTheme.bodyMedium,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: colors.border),
                    ),
                ),
              ),
          
              const SizedBox(height: 30),
          
              FilledButton(
                onPressed: () => updatePassword(), 
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