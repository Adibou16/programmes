import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:programmes/auth/auth_service.dart';
import 'package:programmes/auth/register.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String errorMessage = '';

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void login() async {
    try {
      await authService.value.signIn(email: emailController.text, password: passwordController.text);
      Navigator.pop(context);
    } on FirebaseException catch (e) {
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

      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                "Connexion",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 40),

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

              const SizedBox(height: 20),

              // Password
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: "Mot de passe",
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
                onPressed: () => login(),
                child: const Text(
                  "Se connecter",
                ),
              ),

              const SizedBox(height: 10),

              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const Register()));
                },
                child: const Text(
                  "Créer un compte",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
