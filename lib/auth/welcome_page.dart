import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:programmes/auth/login.dart';
import 'package:programmes/auth/register.dart';
import 'package:programmes/auth/auth_service.dart';



class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  void login() async {
    await authService.value.signIn(email: 'filalbert16@gmail.com', password: '234567');
  }

  @override
  Widget build(BuildContext context) {
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

              TextButton(
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const Register())),
                child: Text(
                  "Créer un compte",
                  style: textTheme.bodyMedium,
                ),
              ),
              
              const SizedBox(height: 20),

              if (kDebugMode) TextButton (
                onPressed: () => login(),
                child: Text(
                  "Connecter comme administrateur",
                  style: textTheme.bodyMedium?.copyWith(color: Colors.amber),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}