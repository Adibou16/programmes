import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class NewExerciseTable extends StatefulWidget {
  const NewExerciseTable({super.key});

  @override
  State<NewExerciseTable> createState() => _NewExerciseTableState();
}

class _NewExerciseTableState extends State<NewExerciseTable> {

  @override
  Widget build(BuildContext context) {
    final headers = ["Séries", "Répétitions", "Repos", "Charge"];
    List<List<int>> tableData = [[0, 0, 0, 0]];
    final width = MediaQuery.of(context).size.width;
    final titleStyle = TextStyle(color: Colors.grey[300], fontSize: width * 0.035);
    final headingStyle = TextStyle(color: Colors.grey[350], fontWeight: FontWeight.bold, fontSize: width * 0.03);
    final dataStyle = TextStyle(color: Colors.grey[400], fontSize: width * 0.03);

    print("BUILD");

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
                  buildDataRow(tableData[i], dataStyle, i),
              ],
            );
          }),
        ],
      );
    }

  // Data row builder 
  TableRow buildDataRow(List<int> cells, TextStyle dataStyle, int rowIndex) {
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

          onChanged: (value) {},
        ),
      ],
    );
  }
}