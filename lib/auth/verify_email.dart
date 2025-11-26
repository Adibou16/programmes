import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class VerifyEmail extends StatefulWidget {
  const VerifyEmail({super.key});

  @override
  State<VerifyEmail> createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {
  Timer? timer;

  @override
  void initState() {
    super.initState();

    timer = Timer.periodic(const Duration(seconds: 5), (_) async {
      await FirebaseAuth.instance.currentUser?.reload();
      final isVerified = FirebaseAuth.instance.currentUser?.emailVerified ?? false;

      if (isVerified) {
        timer?.cancel();
        if (mounted) Navigator.pushReplacementNamed(context, "/home");
      }
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: const Text("Vérifier votre email")),
      
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const Icon(Icons.email_outlined, size: 100),
          
              const SizedBox(height: 20),
          
              Text(
                "Un lien a été envoyé à votre email",
                style: textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),

              const Text(
                "Il se peut qu'il se retouvre dans vos indésirés.",
                textAlign: TextAlign.center,
              ),
          
              const SizedBox(height: 20),
          
              FilledButton(
                onPressed: () async {
                  await FirebaseAuth.instance.currentUser?.sendEmailVerification();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Le email de vérification a été renvoyé")),
                  );
                },
                child: Text(
                  "Renvoyer email de vérification",
                  style: textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              TextButton(
                onPressed: () async {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        "La vérification a été annulée.",
                        style: TextStyle(color: Theme.of(context).colorScheme.error)
                      ),
                    ),
                  );

                  await FirebaseAuth.instance.signOut();
                },
                child: const Text("Annuler"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
