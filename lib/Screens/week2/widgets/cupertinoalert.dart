import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weapp/constdata/textstyles.dart';

class CupertinoAlertDialogdemo extends StatefulWidget {
  const CupertinoAlertDialogdemo({Key? key}) : super(key: key);

  @override
  _CupertinoAlertDialogdemoState createState() =>
      _CupertinoAlertDialogdemoState();
}

class _CupertinoAlertDialogdemoState extends State<CupertinoAlertDialogdemo> {
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
            "Cupertno Alert box",
            style: AppTextStyles.h3_Bold.copyWith(color: AppColors.blue1),
          )),
      body: Center(
        child: MaterialButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          color: AppColors.blue1,
          onPressed: () {
            showCupertinoDialog(
                context: context,
                builder: (contex) {
                  return CupertinoAlertDialog(
                    title: Text("Cupertino Alert Dialog"),
                    content:
                        Text("this is cupertino alert dialog box in flutter."),
                    actions: [Actionbutton()],
                  );
                });
          },
          child: Text(
            "Show cupertino Alert Dialog",
            style: AppTextStyles.h3_Bold.copyWith(color: AppColors.bluewhite),
          ),
        ),
      ),
    );
  }
}

class Actionbutton extends StatelessWidget {
  const Actionbutton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoDialogAction(
        onPressed: () {
          Navigator.pop(context);
        },
        child: Text("Allow"));
  }
}
