import 'package:flutter/material.dart';
import 'package:weapp/constdata/textstyles.dart';

class Aligndemo extends StatefulWidget {
  const Aligndemo({Key? key}) : super(key: key);

  @override
  State<Aligndemo> createState() => _AligndemoState();
}

class _AligndemoState extends State<Aligndemo> {
  List<AlignmentGeometry> _alignment = [
    Alignment.bottomCenter,
    Alignment.bottomLeft,
    Alignment.bottomRight,
    Alignment.center,
    Alignment.centerLeft,
    Alignment.centerRight,
    Alignment.topCenter,
    Alignment.topLeft,
    Alignment.topRight,
  ];

  // List _values = _alignment.map((e) => e.value).toList();
  AlignmentGeometry _value = Alignment.bottomCenter;
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
            "Flutter Widgets",
            style: AppTextStyles.h3_Bold.copyWith(color: AppColors.blue1),
          )),
      body: Column(
        children: [
          DropdownButton(
              value: _value,
              items: _alignment.map((AlignmentGeometry e) {
                return DropdownMenuItem(
                  value: e,
                  child:
                      Text(e.toString().split(".").toList()[1].toUpperCase()),
                );
              }).toList(),
              onChanged: (AlignmentGeometry? value) {
                setState(() {
                  _value = value!;
                });
              }),
          Flexible(
            child: Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.all(30),
              decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(10)),
              child: Align(
                alignment: _value,
                child: Container(
                  color: Colors.amber,
                  height: 70,
                  width: 70,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
