import 'package:flutter/material.dart';
import 'package:programmes/profile/settings.dart';


class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profil"),

        actions: <Widget> [
          CircleAvatar(
            backgroundColor: Colors.blue,
            child: IconButton(
              icon: const Icon(Icons.settings, color: Colors.black),
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const Settings())),
            )
          )
        ]
      ),
    );
  }
}
