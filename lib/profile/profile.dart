import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:programmes/auth/auth_service.dart';
import 'package:programmes/auth/reset_password.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  void logout() async {
    try {
      await authService.value.signOut();
    } on FirebaseException catch (e) {
      print(e.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profil"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Settings",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
              ),
            ),

            const SizedBox(height: 15),

            _buildSettingItem(
              title: "Changer le mot de passe",
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const ResetPassword())),
            ),

            const SizedBox(height: 20),

            GestureDetector(
              onTap: () => logout(),
              child: const Text(
                "Logout",
                style: TextStyle(
                  color: Colors.redAccent,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingItem({required String title, required VoidCallback onTap}) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(
        title,
        style: const TextStyle(fontSize: 17, color: Colors.white),
      ),
      trailing: const Icon(Icons.arrow_forward_ios, color: Colors.white60, size: 18),
      onTap: onTap,
    );
  }
}
