import 'package:flutter/material.dart';
import 'package:weapp/constdata/textstyles.dart';

class DataTabledemo extends StatefulWidget {
  const DataTabledemo({Key? key}) : super(key: key);

  @override
  _DataTabledemoState createState() => _DataTabledemoState();
}

class _DataTabledemoState extends State<DataTabledemo> {
  List<TableData> data = [
    TableData(name: "Abc", email: "Abc@mail", rollNo: 1),
    TableData(name: "Def", email: "Def@mail", rollNo: 2)
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bluewhite,
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: AppColors.blue1,
              )),
          title: Text(
            "Data Table",
            style: AppTextStyles.h3_Bold.copyWith(color: AppColors.blue1),
          )),
      body: Center(
          child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
          border: TableBorder.all(borderRadius: BorderRadius.circular(15)),
          columns: [
            DataColumn(label: Text("Roll No.")),
            DataColumn(label: Text("Name")),
            DataColumn(label: Text("Email"))
          ],
          rows: data.map((e) {
            return DataRow(cells: [
              DataCell(Text(
                e.rollNo.toString(),
              )),
              DataCell(Text(e.name)),
              DataCell(Text(e.email))
            ]);
          }).toList(),
        ),
      )),
    );
  }
}

class TableData {
  String name, email;
  int rollNo;

  TableData({required this.name, required this.email, required this.rollNo});
}
