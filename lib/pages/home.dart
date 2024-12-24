import 'package:flutter/material.dart';
import 'package:programmes/widgets/select_workout.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( // App Bar
        title: const Text("Acceuil"),
        backgroundColor: Colors.grey[850],
        centerTitle: true,
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: Colors.black,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.grey[850],
        fixedColor: Colors.blue,
        unselectedItemColor: Colors.white,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Acceuil",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: "Nouveau Programme",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: "Profil",
          ),  
        ],
      ),
      
      body: SelectWorkout(),
    );
  }
}