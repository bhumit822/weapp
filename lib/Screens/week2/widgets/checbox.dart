import 'package:flutter/material.dart';
import 'package:weapp/constdata/textstyles.dart';

class CheckBoxdemo extends StatefulWidget {
  CheckBoxdemo({Key? key}) : super(key: key);

  @override
  State<CheckBoxdemo> createState() => _CheckBoxdemoState();
}

class _CheckBoxdemoState extends State<CheckBoxdemo> {
  bool _checkboxval = false;
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
            Checkbox(
                value: _checkboxval,
                onChanged: (bool? value) {
                  setState(() {
                    _checkboxval = value!;
                  });
                }),
            SizedBox(
              height: 50,
              width: 50,
              child: FittedBox(
                fit: BoxFit.cover,
                child: Checkbox(
                    checkColor: Colors.white,
                    fillColor: MaterialStateProperty.all(
                        _checkboxval ? Colors.green : Colors.redAccent),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    value: _checkboxval,
                    onChanged: (bool? value) {
                      setState(() {
                        _checkboxval = value!;
                      });
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
