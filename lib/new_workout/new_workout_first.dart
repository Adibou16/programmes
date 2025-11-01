import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:programmes/new_workout/new_workout_second.dart';

class NewWorkoutFirst extends StatefulWidget {
  const NewWorkoutFirst({super.key});

  @override
  State<NewWorkoutFirst> createState() => _NewWorkoutFirstState();
}

class _NewWorkoutFirstState extends State<NewWorkoutFirst> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  var weeks = 4;

  @override
  Widget build(BuildContext context) {
  double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Nouveau workout'),
        backgroundColor: Colors.grey[850],
        centerTitle: true,
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            controller: titleController,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              labelText: 'Nom du workout',
              labelStyle: TextStyle(color: Colors.grey[400]),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey[700]!),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue),
              ),
            ),
          ),
      
          TextField(
            controller: descriptionController,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              labelText: 'Description du workout',
              labelStyle: TextStyle(color: Colors.grey[400]),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey[700]!),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue),
              ),
            ),
          ),

          const SizedBox(height: 30),

          const Center(
            child: Text(
              'Nombre de Semaines',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                ),
            ),
          ),

          NumberPicker(
            minValue: 1,
            maxValue: 9, 
            value: weeks, 
            onChanged: (value) {
              setState(() {
                weeks = value;
              });
            },
            selectedTextStyle: const TextStyle(
              color: Colors.blue,
              fontSize: 24,
            ),
            axis: Axis.horizontal,
            itemWidth: width / 5,
            itemCount: 5,
          ),

          const SizedBox(height: 30),

          CircleAvatar(
            radius: 30,
            backgroundColor: Colors.blue,
            child: IconButton(
              onPressed: () {
                Navigator.push( 
                  context, 
                  MaterialPageRoute(builder: (context) => NewWorkoutSecond(
                    name: titleController.text,
                    description:  descriptionController.text,
                    weeks: weeks
                  ))
                );
              }, 
              icon: const Icon(
                Icons.navigate_next, 
                color: Colors.black, 
              ),
            ),
          )
        ]
      ),
    );
  }  
}