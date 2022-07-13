import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:weapp/Screens/week3/Api/apidemo.dart';
import 'package:weapp/Screens/week3/Sqflight/sqlddd.dart';
import 'package:weapp/Screens/week3/Sqflight/sqlithome.dart';
import 'package:weapp/Screens/week3/gesturedetector.dart';
import 'package:weapp/Screens/week3/gesturemoveobject.dart';
import 'package:weapp/constdata/textstyles.dart';

class Week3 extends StatefulWidget {
  const Week3({Key? key}) : super(key: key);

  @override
  State<Week3> createState() => _Week3State();
}

class _Week3State extends State<Week3> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.amber,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text("Week 3",
            style: AppTextStyles.h2_regular.copyWith(color: Colors.black)),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(20),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(children: [
            CustomContainer(
              title: "GESTURE",
              ontap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => GestureDetectordemo()));
              },
            ),
            CustomContainer(
              title: "Move Object",
              ontap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => GestureMoveObject()));
              },
            ),
            CustomContainer(
              title: "Api",
              ontap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => ApiDemo()));
              },
            ),
            CustomContainer(
              title: "SQl Database",
              ontap: () async {
                await Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => SqLiteHome()));
                log('hekkp');
              },
            ),
          ]),
        ),
      ),
    );
  }
}

class CustomContainer extends StatelessWidget {
  const CustomContainer({Key? key, required this.title, required this.ontap})
      : super(key: key);
  final String title;
  final VoidCallback ontap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(20),
        margin: EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          color: Colors.amber,
          boxShadow: [
            BoxShadow(
                color: AppColors.grey, blurRadius: 4, offset: Offset(-3, 5))
          ],
          borderRadius: BorderRadius.circular(5),
        ),
        alignment: Alignment.center,
        child: Text(
          title,
          style: AppTextStyles.h4_regular,
        ),
      ),
    );
  }
}
