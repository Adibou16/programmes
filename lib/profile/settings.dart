import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:programmes/auth/auth_service.dart';
import 'package:programmes/auth/change_password.dart';
import 'package:programmes/auth/change_username.dart';
import 'package:programmes/auth/delete_account.dart';
import 'package:programmes/auth/reset_password.dart';
import 'package:programmes/database/workout_repository.dart';


class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  
  Future<void> logout() async {
    final repo = WorkoutRepository();
    await repo.closeForLogout();
    await FirebaseAuth.instance.signOut();
    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    const padding = EdgeInsets.all(8.0);


    Widget _buildSettingItem({required String title, required Widget page, required TextStyle? textTheme}) {
      return ListTile(
        contentPadding: EdgeInsets.zero,
        title: Text(
          title,
          style: textTheme,
        ),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => page)),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Paramètres"),
      ),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: padding,
              child: Text(
                authService.value.currentUser!.displayName ?? "Aucun nom d'utilisateur",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
      
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
              child: Column(
                children: [
                  _buildSettingItem(
                    title: "Changer le nom d'utilisateur",
                    page: const ChangeUsername(),
                    textTheme: textTheme.bodyMedium
                  ),
                  _buildSettingItem(
                    title: "Changer le mot de passe",
                    page: const ChangePassword(),
                    textTheme: textTheme.bodyMedium
                  ),
                  _buildSettingItem(
                    title: "Réinitialiser le mot de passe", 
                    page: const ResetPassword(), 
                    textTheme: textTheme.bodyMedium
                  ),
                  _buildSettingItem(
                    title: "Supprimer le compte", 
                    page: const DeleteAccount(), 
                    textTheme: textTheme.bodyMedium
                  ),
                ],
              ),
            ),
        
            const SizedBox(height: 20),
        
            Padding(
              padding: padding,
              child: GestureDetector(
                onTap: () {
                  logout();
                },
                child: Text(
                  "Logout",
                  style: textTheme.bodyMedium?.copyWith(color: Colors.redAccent)
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}