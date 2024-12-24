import 'package:flutter/material.dart';

class Exercice extends StatefulWidget {
  const Exercice({super.key});

  @override
  State<Exercice> createState() => _ExerciceState();
}

class _ExerciceState extends State<Exercice> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Exercice"),
        backgroundColor: Colors.grey[850],
        centerTitle: true,
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Column(
            children: [
              Text(
                'BenchPress',
                style: TextStyle(color: Colors.grey[300]),
              ),
              Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/benchpress.jpg'),
                    fit: BoxFit.cover,
                    ),
                ),
                width: 100,
                height: 100,
              ),
            ],
          ),
          const SizedBox(width: 20),
          Column(
            children: [
              Text(
                'DESCRIPTIFS',
                style: TextStyle(color: Colors.grey[300]),
              ),
              DataTable(
                border: TableBorder.all(),
                columnSpacing: 10,
                horizontalMargin: 10,
                headingTextStyle: TextStyle(
                  color: Colors.grey[350],
                  fontWeight: FontWeight.bold
                ),
                dataTextStyle: TextStyle(
                  color: Colors.grey[400]
                ),
      
                columns: buildColumn(
                    ["Séries", "Répétitions", "Repos", "Charges"]),
                rows: const [
                  DataRow(cells: [
                    DataCell(Text("X")),
                    DataCell(Text("X")),
                    DataCell(Text("X")),
                    DataCell(Text("X")),
                  ]),
                  DataRow(cells: [
                    DataCell(Text("X")),
                    DataCell(Text("X")),
                    DataCell(Text("X")),
                    DataCell(Text("X")),
                  ]),
                ],
              )
          ],
        )
      ],
        ),
    );
}
  List<DataColumn> buildColumn(List<String> columns) => columns
      .map((String column) => DataColumn(
            label: Text(column),
          ))
      .toList();
}