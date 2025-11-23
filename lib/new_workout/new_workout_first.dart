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
  TextStyle inputStyle = TextStyle(color: colors.header, fontSize: height * 0.03);
  TextStyle inputLabelStyle = TextStyle(color: colors.text, fontSize: height * 0.025);


    return Scaffold(
      appBar: AppBar(
        title: const Text('Nouveau workout'),
      ),
      body: Center(
        child: ListView(
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: titleController,
                style: inputStyle,
                decoration: InputDecoration(
                  labelText: 'Nom du workout',
                  labelStyle: inputLabelStyle,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: colors.border),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Theme.of(context).colorScheme.primary),
                  ),
                ),
              ),
            ),
        
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: descriptionController,
                style: inputStyle,
                decoration: InputDecoration(
                  labelText: 'Description du workout',
                  labelStyle: inputLabelStyle,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: colors.border),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Theme.of(context).colorScheme.primary),
                  ),
                ),
              ),
            ),
        
            SizedBox(height: height * 0.06),
        
            Center(
              child: Text(
                'Nombre de Semaines',
                style: TextStyle(
                  color: colors.header,
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
                color: Theme.of(context).colorScheme.primary,
                fontSize: height * 0.04,
              ),
              textStyle: TextStyle(
                color: colors.text,
                fontSize: height * 0.025,
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