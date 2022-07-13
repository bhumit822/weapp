import 'package:flutter/material.dart';
import 'package:weapp/Screens/week1/basicprogramin.dart';
import 'package:weapp/Screens/week1/dartintro.dart';
import 'package:weapp/Screens/week1/navigation.dart';
import 'package:weapp/Screens/week1/viewcontrollerlifecycle.dart';
import 'package:weapp/Screens/week1/whatisflutter.dart';
import 'package:weapp/constdata/textstyles.dart';
import 'package:weapp/widgets/contentButton.dart';

class Week1 extends StatefulWidget {
  const Week1({Key? key}) : super(key: key);

  @override
  State<Week1> createState() => _Week1State();
}

class _Week1State extends State<Week1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blue3,
      appBar: AppBar(
        backgroundColor: AppColors.blue3,
        elevation: 0,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30))),
        child: GridView(
          padding: EdgeInsets.all(20),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
          ),
          children: [
            ContentButton(
              ontap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => WhatIsFlutter()));
              },
              title: "What \nis \nFlutter ?",
            ),
            ContentButton(
              ontap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => BasicOfProgramin()));
              },
              title: "Basics \nof\nlanguage",
            ),
            ContentButton(
              ontap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => DartIntro()));
              },
              title: "Dart \nPrograming",
            ),
            ContentButton(
              ontap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ControllerLifeCycleScreen()));
              },
              title: "View \ncontroller \nlife \ncycle/activity",
            ),
            ContentButton(
              ontap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => NavigationScreen(),
                    settings: RouteSettings(name: "navigation")));
              },
              title: "Navigation \nin \nFlutter",
            ),
          ],
        ),
      ),
    );
  }
}
