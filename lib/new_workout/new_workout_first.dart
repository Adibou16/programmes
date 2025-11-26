import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:programmes/new_workout/new_workout_second.dart';
import 'package:programmes/themes/theme_extensions.dart';


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

  final colors = Theme.of(context).extension<AppColors>()!;
  final textTheme = Theme.of(context).textTheme;


    return Scaffold(
      appBar: AppBar(
        title: const Text('Nouveau workout'),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(12.0),
          child: Column (
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(
                  labelText: 'Nom du workout',
                  labelStyle: textTheme.bodyMedium,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: colors.border),
                  ),
                ),
              ),

              const SizedBox(height: 20.0),
          
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(
                  labelText: 'Description du workout',
                  labelStyle: textTheme.bodyMedium,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: colors.border),
                  ),
                ),
              ),
              const SizedBox(height: 30),
          
              Center(
                child: Text(
                  'Nombre de Semaines',
                  style: textTheme.headlineMedium
                ),
              ),
          
              const SizedBox(height: 10),

              NumberPicker(
                minValue: 1,
                maxValue: 9, 
                value: weeks, 
                onChanged: (value) {
                  setState(() {
                    weeks = value;
                  });
                },
                selectedTextStyle: textTheme.bodyLarge?.copyWith(color: Colors.blue),
                textStyle: textTheme.bodyMedium,
                axis: Axis.horizontal,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  border: Border.all(color: colors.border)
                ),
                itemWidth: (width - 24) / 5,
                itemCount: 5,
              ),
          
              const SizedBox(height: 30),
          
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
      ),
    );
  }  
}