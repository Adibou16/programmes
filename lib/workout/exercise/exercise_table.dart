import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:programmes/themes/theme_extensions.dart';
import 'package:programmes/database/workout_repository.dart';


class ExerciseTable extends StatefulWidget {
  final List<List<int>> tableData;
  final String? workoutId;
  final int? exerciseIndex;
  const ExerciseTable({super.key, required this.tableData, this.workoutId, this.exerciseIndex});

  @override
  State<ExerciseTable> createState() => _ExerciseTableState();
}

class _ExerciseTableState extends State<ExerciseTable> {
  late List<TextEditingController> controllers = [];

  @override
  void initState() {
    super.initState();
    buildControllers();
  }

  @override
  void didUpdateWidget(covariant ExerciseTable oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.tableData.length != widget.tableData.length) {
      buildControllers();
    }
  }
  
  void buildControllers() {
    for (var c in controllers) c.dispose();

    controllers = List.generate(
      widget.tableData.length,
      (i) {
        final value = widget.tableData[i][3];
        return TextEditingController(text: value == 0 ? "" : value.toString());
      },
    );
  }

  @override
  void dispose() {
    for (var c in controllers) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final headers = ["Séries", "Répétitions", "Repos", "Charge"];
    List<List<int>> tableData = widget.tableData;

    final width = MediaQuery.of(context).size.width;

    final colors = Theme.of(context).extension<AppColors>()!;
    final titleStyle = TextStyle(color: colors.header, fontSize: width * 0.035);
    final headingStyle = TextStyle(color: colors.header, fontWeight: FontWeight.bold, fontSize: width * 0.03, overflow: TextOverflow.ellipsis);
    final dataStyle = TextStyle(color: colors.text, fontSize: width * 0.03);

    // Data row builder 
    TableRow buildDataRow(List<int> cells, TextStyle dataStyle, int rowIndex) {
      final row = tableData[rowIndex];

      return TableRow(
        children: [
          
          // First three columns
          for (var i = 0; i < 3; i++)
              Center(
                child: Text(
                  row[i].toString(),
                  style: dataStyle,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),

          // Last column with TextField
          TextField(
            controller: controllers[rowIndex],
            textAlign: TextAlign.center,
            style: TextStyle(color: Theme.of(context).colorScheme.primary, fontSize: dataStyle.fontSize),
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
            decoration: InputDecoration(
              isDense: true,
              contentPadding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 0),
              hintText: "poids (lbs)",
              hintStyle: dataStyle,
              border: InputBorder.none,
            ),
          
            onChanged: (value) async {
              final newVal = int.tryParse(value) ?? 0;

              widget.tableData[rowIndex][3] = newVal;

              final repo = WorkoutRepository();
              await repo.updateExerciseValue(
                widget.workoutId!,
                widget.exerciseIndex!,
                rowIndex,
                newVal,
              );
            },
          ),
        ],
      );
    }

    return Column(
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
            border: TableBorder.all(width: 1.0, color: colors.border),
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
}