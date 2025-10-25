import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:programmes/workout/workout.dart';

class WeightInput extends StatefulWidget {
  const WeightInput({super.key});

  @override
  State<WeightInput> createState() => _WeightInputState();
}

class _WeightInputState extends State<WeightInput> {
  String savedWeight = '';
  TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    savedWeight = Workout.getWeight() ?? '';
    _controller = TextEditingController(text: savedWeight);
  }

  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final dataStyle = TextStyle(color: Colors.grey[400], fontSize: width * 0.03);

    return TextField(
      controller: _controller,

      style: TextStyle(color: Colors.blue[600], fontSize: dataStyle.fontSize),
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
      decoration: InputDecoration(
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 6.0),
        hintText: "poids (lbs)",
        hintStyle: dataStyle,
        border: InputBorder.none,
      ),

      onChanged: (value) async {
        await Workout.saveWeight(value);
      },
    );
  }
}