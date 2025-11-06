import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:programmes/database/boxes.dart';

// ignore: must_be_immutable
class ExerciseTable extends StatefulWidget {
  List<List<int>> tableData;
  final int? workoutIndex;
  final int? exerciseIndex;
  ExerciseTable({super.key, required this.tableData, this.workoutIndex, this.exerciseIndex});

  @override
  State<ExerciseTable> createState() => _ExerciseTableState();
}

class _ExerciseTableState extends State<ExerciseTable> {

  @override
  Widget build(BuildContext context) {
    final headers = ["Séries", "Répétitions", "Repos", "Charge"];
    List<List<int>> tableData = widget.tableData;
    final width = MediaQuery.of(context).size.width;
    final titleStyle = TextStyle(color: Colors.grey[300], fontSize: width * 0.035);
    final headingStyle = TextStyle(color: Colors.grey[350], fontWeight: FontWeight.bold, fontSize: width * 0.03);
    final dataStyle = TextStyle(color: Colors.grey[400], fontSize: width * 0.03);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Descriptifs',
            style: titleStyle,
          ),
    
          LayoutBuilder(builder: (context, constraints) {
            final totalWidth = constraints.maxWidth.isFinite ? constraints.maxWidth : MediaQuery.of(context).size.width;
            const minColWidth = 40.0;
            final colWidth = (totalWidth / headers.length).clamp(minColWidth, totalWidth);
            final columnWidths = <int, TableColumnWidth>{ for (var i = 0; i < headers.length; i++) i: FixedColumnWidth(colWidth) };
          
            return Table(
              columnWidths: columnWidths,
              border: TableBorder.all(width: 1.0, color: Colors.grey),
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              children: [
                // Header row
                TableRow(
                  decoration: const BoxDecoration(),
                  children: headers.map((h) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 0),
                    child: Center(
                      child: Text(
                        h,
                        style: headingStyle,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                  )).toList(),
                ),
                // Data rows 
                for (var i = 0; i < tableData.length; i++)
                  buildDataRow(tableData[i], dataStyle, i),
              ],
            );
          }),
        ],
      );
    }

  // Data row builder 
  TableRow buildDataRow(List<int> cells, TextStyle dataStyle, int rowIndex) {
    
    // Build controller
    final weight = (widget.workoutIndex != null && widget.exerciseIndex != null)
        ? boxWorkouts.getAt(widget.workoutIndex!).exercises[widget.exerciseIndex].tableData[rowIndex][3]
        : 0;
    final rowController = TextEditingController(text: weight != 0 ? weight.toString() : '');

    return TableRow(
      children: [
        
        // First three columns
        for (var i = 0; i < 3; i++)
            Center(
              child: Text(
                i < cells.length ? cells[i].toString() : '',
                style: dataStyle,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),

        // Last column with TextField
        TextField(
          controller: rowController,
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.blue[600], fontSize: dataStyle.fontSize),
          keyboardType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
          decoration: InputDecoration(
            isDense: true,
            contentPadding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 0),
            hintText: "poids (lbs)",
            hintStyle: dataStyle,
            border: InputBorder.none,
          ),
        
          onChanged: (value) {
            try {
              final int newVal = int.tryParse(value) ?? 0;
        
              if (widget.workoutIndex == null || widget.exerciseIndex == null) return;
        
              final workout = boxWorkouts.getAt(widget.workoutIndex!);
              final ex = workout.exercises[widget.exerciseIndex];
              ex.tableData[rowIndex][3] = newVal;
              
              workout.exercises[widget.exerciseIndex] = ex;
              boxWorkouts.putAt(widget.workoutIndex!, workout);
            }
            catch (e) {
              print("ERROR: $e");
            }
          },
        ),
      ],
    );
  }
}