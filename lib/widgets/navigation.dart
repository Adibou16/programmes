import 'package:flutter/material.dart';
import 'package:programmes/new_workout/new_workout_first.dart';
import 'package:programmes/widgets/home.dart';
import 'package:programmes/profile/profile.dart';

class Navigation extends StatefulWidget {
  const Navigation({super.key});

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    const Home(),
    const Placeholder(),
    const Profile(),
  ];

  void _onItemTapped(int index) async {
    if (index == 1) {
      await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const NewWorkoutFirst()),
      );
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
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
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
