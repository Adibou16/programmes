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
  double height = MediaQuery.of(context).size.height;
  TextStyle inputStyle = TextStyle(color: Colors.white, fontSize: height * 0.03);
  TextStyle inputLabelStyle = TextStyle(color: Colors.grey[400], fontSize: height * 0.025);


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
      body: Center(
        child: ListView(
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          children: [
            TextField(
              controller: titleController,
              style: inputStyle,
              decoration: InputDecoration(
                labelText: 'Nom du workout',
                labelStyle: inputLabelStyle,
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
              style: inputStyle,
              decoration: InputDecoration(
                labelText: 'Description du workout',
                labelStyle: inputLabelStyle,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey[700]!),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                ),
              ),
            ),
        
            SizedBox(height: height * 0.06),
        
            Center(
              child: Text(
                'Nombre de Semaines',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: height * 0.03,
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
              selectedTextStyle: TextStyle(
                color: Colors.blue,
                fontSize: height * 0.04,
              ),
              axis: Axis.horizontal,
              itemWidth: width / 5,
              itemCount: 5,
            ),
        
            SizedBox(height: height * 0.06),
        
            CircleAvatar(
              radius: height * 0.05,
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
      ),
    );
  }  
}