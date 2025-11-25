import 'package:flutter/material.dart';
import 'package:programmes/auth/auth_service.dart';
import 'package:programmes/themes/theme_extensions.dart';


class ChangeUsername extends StatefulWidget {
  const ChangeUsername({super.key});

  @override
  State<ChangeUsername> createState() => _ChangeUsernameState();
}

class _ChangeUsernameState extends State<ChangeUsername> {
  TextEditingController usernameController = TextEditingController();

  @override
  void dispose() {
    usernameController.dispose();
    super.dispose();
  }

  void changeUsername() async {
    try {
      await authService.value.updateUsername(username: usernameController.text);  
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Theme.of(context).snackBarTheme.backgroundColor,
        content: const Text("Votre nom d'utilisateur a été changé")
        ),
      );
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Theme.of(context).colorScheme.error,
        content: const Text("Échec du changement nom d'utilisateur")
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
                "Changer votre nom d'utilisateur",
                textAlign: TextAlign.center,
                style: textTheme.headlineMedium,
              ),
          
              const SizedBox(height: 10),
          
              // Email
              TextField(
                controller: usernameController,
                decoration: InputDecoration(
                  labelText: "Nouveau nom d'utilisateur",
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
                onPressed: () => changeUsername(), 
                child: Text(
                  "Changer le nom d'utilisateur",
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