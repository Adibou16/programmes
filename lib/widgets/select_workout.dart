import 'package:flutter/material.dart';
import 'package:programmes/widgets/exercice.dart';

class SelectWorkout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Exercice();

    // return Card (
    //   color: Colors.grey[900],
    //   margin: const EdgeInsets.all(10.0),
    //   child: InkWell(
    //     child: Container(
    //       margin: const EdgeInsets.all(10.0),
    //       width: 200.0,
    //       child: Text(
    //         "Select Workout",
    //         style: TextStyle(
    //           color: Colors.white,
    //           fontSize: 20.0,
    //           fontWeight: FontWeight.bold,  
    //         ),
    //       )
    //     )
    //   ),
    // );
  }
}