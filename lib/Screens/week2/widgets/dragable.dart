import 'package:flutter/material.dart';
import 'package:weapp/constdata/textstyles.dart';

class Draggabledemo extends StatefulWidget {
  const Draggabledemo({Key? key}) : super(key: key);

  @override
  _DraggablePageState createState() => _DraggablePageState();
}

class _DraggablePageState extends State<Draggabledemo> {
  Widget a = Container(
    alignment: Alignment.center,
    child: Text(
      "Drag and drop here.",
    ),
    color: Colors.red,
    height: 200,
  );
  Widget b = Container(
    alignment: Alignment.center,
    child: Material(child: Text("Yes")),
    color: Colors.amber,
    height: 100,
    width: 100,
  );

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
            "Dragable",
            style: AppTextStyles.h3_Bold.copyWith(color: AppColors.blue1),
          )),
      body: Container(
          height: double.infinity,
          width: double.infinity,
          child: Column(
            children: [
              Draggable(
                  data: b,
                  child: Container(
                    alignment: Alignment.center,
                    child: Text("Drag this box"),
                    color: Colors.amber,
                    height: 70,
                    width: 70,
                  ),
                  feedback: b),
              Spacer(),
              Container(
                width: 300,
                height: 300,
                child: DragTarget(
                  builder: (context, ace, rej) {
                    return a;
                  },
                  onAccept: (data) {
                    setState(() {
                      a = b;
                    });
                  },
                ),
              )
            ],
          )),
    );
  }
}
