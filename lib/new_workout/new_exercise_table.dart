import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NewExerciseTable extends StatefulWidget {
  final int weeks;
  final List<List<int>> initialTableData;
  final Function(List<List<int>>)? onTableChanged;

  const NewExerciseTable({super.key, required this.weeks, required this.initialTableData, this.onTableChanged});

  @override
  State<NewExerciseTable> createState() => _NewExerciseTableState();
}

class _NewExerciseTableState extends State<NewExerciseTable> {
  late List<List<int>> tableData;
  late List<List<TextEditingController>> controllers;


  @override
  void initState() {
    super.initState();
    
    if (widget.initialTableData.isNotEmpty && widget.initialTableData.length == widget.weeks) {
      tableData = List.from(widget.initialTableData.map((row) => List<int>.from(row)));
    } else {
      tableData = List.generate(widget.weeks, (_) => [0, 0, 0, 0]);
    }
    
    controllers = List.generate(
      widget.weeks,
      (i) => List.generate(
        4,
        (j) => TextEditingController(text: tableData[i][j] == 0 ? '' : tableData[i][j].toString()),
      ),
    );
  }

  @override
  void dispose() {
    for (var row in controllers) {
      for (var ctrl in row) {
        ctrl.dispose();
      }
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final headers = ["Séries", "Répétitions", "Repos"];
    final width = MediaQuery.of(context).size.width;
    final titleStyle = TextStyle(color: Colors.grey[300], fontSize: width * 0.035);
    final headingStyle = TextStyle(color: Colors.grey[350], fontWeight: FontWeight.bold, fontSize: width * 0.03, overflow: TextOverflow.ellipsis);
    final dataStyle = TextStyle(color: Colors.grey[400], fontSize: width * 0.03);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text('Descriptifs', style: titleStyle),
        LayoutBuilder(builder: (context, constraints) {
          final totalWidth = constraints.maxWidth.isFinite ? constraints.maxWidth : MediaQuery.of(context).size.width;
          const minColWidth = 60.0;
          final colWidth = (totalWidth / headers.length).clamp(minColWidth, totalWidth);
          final columnWidths = <int, TableColumnWidth>{
            for (var i = 0; i < headers.length; i++) i: FixedColumnWidth(colWidth)
          };

          return Table(
            columnWidths: columnWidths,
            border: TableBorder.all(width: 1.0, color: Colors.grey),
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            children: [
              // Header row
              TableRow(
                children: headers
                    .map((h) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 6.0),
                          child: Center(
                            child: Text(
                              h,
                              style: headingStyle,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ))
                    .toList(),
              ),
              // Data rows
              for (var i = 0; i < tableData.length; i++)
                buildDataRow(i, dataStyle, headers),
            ],
          );
        }),
      ],
    );
  }

  TableRow buildDataRow(int rowIndex, TextStyle dataStyle, List<String> headers) {
    return TableRow(
      children: [
        for (var col = 0; col < 3; col++)
          Center(
            child: TextField(
              controller: controllers[rowIndex][col],
              style: TextStyle(color: Colors.blue[600], fontSize: dataStyle.fontSize, overflow: TextOverflow.fade),
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: InputDecoration(
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 6.0),
                hintText: headers[col],
                hintStyle: dataStyle,
                border: InputBorder.none,
              ),

              onChanged: (value) {
                final intVal = int.tryParse(value) ?? 0;
                setState(() {
                  tableData[rowIndex][col] = intVal;
                });
                widget.onTableChanged?.call(tableData);
                print(tableData);
              },

              onSubmitted: (value) {
                final intVal = int.tryParse(value) ?? 0;

                setState(() {
                  tableData[rowIndex][col] = intVal;
                  for (int i = 0; i < widget.weeks; i++) {
                    if (i != rowIndex && tableData[i][col] == 0) {
                      tableData[i][col] = intVal;
                      controllers[i][col].text = intVal == 0 ? '' : intVal.toString();
                    }
                  }
                });
                widget.onTableChanged?.call(tableData);
              },
            ),
          ),
      ],
    );
  }
}
