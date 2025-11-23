import 'package:flutter/material.dart';
import 'package:programmes/auth/login.dart';
import 'package:programmes/auth/register.dart';
import 'package:programmes/themes/theme_extensions.dart';


class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColors>()!;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Text(
                "Bienvenue",
                style: textTheme.headlineLarge
              ),

              const SizedBox(height: 10),

              Text(
                "Veuillez vous connecter ou créer un nouveau compte.",
                textAlign: TextAlign.center,
                style: textTheme.bodyMedium,
              ),

              const SizedBox(height: 40),

              // Bouton Connexion
              FilledButton(
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const Login())),
                child: Text(
                  "Connexion",
                  style: textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const Register())),
                  child: Text(
                    "Créer un compte",
                    style: textTheme.bodyMedium,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}