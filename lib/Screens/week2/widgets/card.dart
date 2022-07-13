import 'package:flutter/material.dart';
import 'package:weapp/constdata/textstyles.dart';

class Carddemo extends StatelessWidget {
  const Carddemo({Key? key}) : super(key: key);

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
      body: Center(
        child: Card(
          child: Container(
              padding: EdgeInsets.all(20),
              alignment: Alignment.center,
              height: 150,
              width: 300,
              child: Text(
                """this is card widget in flutter.\ncolor,shadow color,elevation,shape can change.""",
                style: AppTextStyles.h4_Bold,
                textAlign: TextAlign.center,
              )),
        ),
      ),
    );
  }
}
