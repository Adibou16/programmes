import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:programmes/auth/auth_service.dart';
import 'package:programmes/auth/reset_password.dart';


class Settings extends StatelessWidget {
  const Settings({super.key});

  void logout() async {
    try {
      await authService.value.signOut();
    } on FirebaseException catch (e) {
      print(e.message);
    }
  }

  Widget _buildSettingItem({required String title, required VoidCallback onTap, required TextStyle? textTheme}) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(
        title,
        style: textTheme,
      ),
      trailing: const Icon(Icons.arrow_forward_ios),
      onTap: onTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    const padding = EdgeInsets.all(8.0);

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: padding,
            child: Text(
              'EMAIL: ${(authService.value.currentUser!.email ?? "Aucun email").toUpperCase()}',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
      
          Padding(
            padding: padding,
            child: Text(
              "Paramètres d'utilisateur",
              style: textTheme.headlineMedium
            ),
          ),
      
          Container(
            padding: const EdgeInsets.all(4.0),
            color: Theme.of(context).appBarTheme.backgroundColor,
            child: _buildSettingItem(
              title: "Changer le mot de passe",
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const ResetPassword())),
              textTheme: textTheme.bodyMedium
            ),
          ),
      
          const SizedBox(height: 20),
      
          Padding(
            padding: padding,
            child: GestureDetector(
              onTap: () => logout(),
              child: Text(
                "Logout",
                style: textTheme.bodyMedium?.copyWith(color: Colors.redAccent)
              ),
            ),
          ),
        ],
      ),
    );
  }
}