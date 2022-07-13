import 'package:flutter/material.dart';
import 'package:weapp/constdata/textstyles.dart';

class Dismissibledemo extends StatefulWidget {
  const Dismissibledemo({Key? key}) : super(key: key);

  @override
  _DismissibledemoState createState() => _DismissibledemoState();
}

class _DismissibledemoState extends State<Dismissibledemo> {
  List<Widget> items = [
    Container(
      color: Colors.blue,
      height: 70,
    ),
    Container(
      color: Colors.amber,
      height: 70,
    ),
    Container(
      color: Colors.blue,
      height: 70,
    ),
    Container(
      color: Colors.amber,
      height: 70,
    ),
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
            "Dismissable",
            style: AppTextStyles.h3_Bold.copyWith(color: AppColors.blue1),
          )),
      body: ListView.builder(
          itemCount: items.length,
          itemBuilder: (contex, index) {
            return Dismissible(
                onDismissed: (direction) {
                  setState(() {
                    items.removeAt(index);
                  });
                },
                background: Container(
                  color: Colors.redAccent,
                ),
                key: ValueKey<Widget>(items[index]),
                child: items[index]);
          }),
    );
  }
}
