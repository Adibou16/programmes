import 'package:flutter/material.dart';
import 'package:programmes/auth/login.dart';
import 'package:programmes/auth/register.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              const Text(
                "Bienvenue",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              const Text(
                "Veuillez vous connecter ou créer un nouveau compte.",
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 40),

              // Bouton Connexion
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const Login())),
                  child: const Text(
                    "Connexion",
                  ),
                ),
              ),

              const SizedBox(height: 20),

              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const Register())),
                  child: const Text(
                    "Créer un compte",
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