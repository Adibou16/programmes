import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:programmes/auth/auth_service.dart';
import 'package:programmes/themes/theme_extensions.dart';


class DeleteAccount extends StatefulWidget {
  const DeleteAccount({super.key});

  @override
  State<DeleteAccount> createState() => _DeleteAccountState();
}

class _DeleteAccountState extends State<DeleteAccount> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String errorMessage = '';

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  void deleteAccount() async {
    try {
      await authService.value.deleteAccount(
        email: emailController.text,
        password: passwordController.text,
      );  
      setState(() {
        errorMessage = '';
      });
      Navigator.pop(context);
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
              "Supprimer mon compte",
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

            // Password
            TextField(
              controller: passwordController,
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
          
              Text(
                errorMessage,
                style: TextStyle(color: Theme.of(context).colorScheme.error),
              ),
        
            const SizedBox(height: 10),
        
            FilledButton(
              onPressed: () => showDialog (
                context: context, 
                builder: (context) => AlertDialog(
                  title: const Text("Supprimer votre compte"),
                  content: const Text('Voulez-vous vraiment supprimer le compte pour toujours?'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(false),
                      child: const Text('Non'),
                    ),
                    TextButton(
                      onPressed: () => deleteAccount(),
                      child: const Text('Supprimer', style: TextStyle(color: Colors.redAccent)),
                    ),
                  ],
                )
              ),
              child: Text(
                "Supprimer le compte pour toujours",
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