import 'package:flutter/material.dart';
import 'package:weapp/constdata/textstyles.dart';

class Centerdemo extends StatelessWidget {
  const Centerdemo({Key? key}) : super(key: key);

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
            "Center",
            style: AppTextStyles.h3_Bold.copyWith(color: AppColors.blue1),
          )),
      body: Center(
          child: Container(
        margin: EdgeInsets.all(30),
        padding: EdgeInsets.all(30),
        color: Colors.blueAccent,
        child: Text(
            "center widgert show child widget in center of their parent widget."),
      )),
    );
  }
}
