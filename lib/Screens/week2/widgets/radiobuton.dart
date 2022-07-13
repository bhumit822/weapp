import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:weapp/constdata/textstyles.dart';

class RadioButtondemo extends StatefulWidget {
  RadioButtondemo({Key? key}) : super(key: key);

  @override
  State<RadioButtondemo> createState() => _RadioButtondemoState();
}

class _RadioButtondemoState extends State<RadioButtondemo> {
  String selectd = "Yes";
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
            "CheckBox",
            style: AppTextStyles.h3_Bold.copyWith(color: AppColors.blue1),
          )),
      body: Center(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Yes",
                  style: AppTextStyles.h3_regular,
                ),
                Radio(
                  value: "Yes",
                  groupValue: selectd,
                  onChanged: (String? v) {
                    setState(() {
                      selectd = v!;
                      Fluttertoast.showToast(msg: "Selected Value is $v");
                    });
                  },
                ),
              ],
            ),
            Text(
              "or",
              style: AppTextStyles.h3_regular,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "No",
                  style: AppTextStyles.h3_regular,
                ),
                Radio(
                  value: "No",
                  groupValue: selectd,
                  onChanged: (String? v) {
                    setState(() {
                      selectd = v!;
                      Fluttertoast.showToast(msg: "Selected Value is $v");
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
