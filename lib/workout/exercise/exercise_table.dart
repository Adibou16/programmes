import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:programmes/workout/exercise/weight_input.dart';
import 'package:programmes/workout/workout.dart';

class ExerciseTableWidget extends StatefulWidget {
  final List<List<int>> tableData;
  const ExerciseTableWidget({super.key, required this.tableData});

  @override
  State<ExerciseTableWidget> createState() => _ExerciseTableWidgetState();
}

class _ExerciseTableWidgetState extends State<ExerciseTableWidget> {
  @override

  Widget build(BuildContext context) {
    final headers = ["Séries", "Répétitions", "Repos", "Charge"];
    final tableData = widget.tableData;
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
            const minColWidth = 60.0;
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
                    padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 6.0),
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
                  buildDataRow(tableData[i], dataStyle),
              ],
            );
          }),
        ],
      );
    }

  // Data row builder 
  TableRow buildDataRow(List<int> cells, TextStyle dataStyle) {
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
        const WeightInput()
      ],
    );
  }
}