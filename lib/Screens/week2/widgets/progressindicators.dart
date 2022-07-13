import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:weapp/constdata/textstyles.dart';

class ProgressIndicatordemo extends StatefulWidget {
  const ProgressIndicatordemo({Key? key}) : super(key: key);

  @override
  State<ProgressIndicatordemo> createState() => _ProgressIndicatordemoState();
}

class _ProgressIndicatordemoState extends State<ProgressIndicatordemo> {
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
            "Progress Indicators",
            style: AppTextStyles.h3_Bold.copyWith(color: AppColors.blue1),
          )),
      body: Container(
        padding: EdgeInsets.only(top: 30),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(children: [
            CircularProgressIndicator(color: AppColors.blue1),
            SizedBox(
              height: 20,
            ),
            LinearProgressIndicator(color: AppColors.blue1),
            SizedBox(
              height: 20,
            ),
            RefreshProgressIndicator(color: AppColors.blue1),
            SizedBox(
              height: 20,
            ),
            SpinKitRotatingCircle(
              color: AppColors.blue1,
              size: 50.0,
            ),
            SizedBox(
              height: 20,
            ),
            SpinKitFadingCircle(
              itemBuilder: (BuildContext context, int index) {
                return DecoratedBox(
                  decoration: BoxDecoration(
                    color: index.isEven ? Colors.red : Colors.green,
                  ),
                );
              },
            ),
            SizedBox(
              height: 20,
            ),
            SpinKitDancingSquare(color: Colors.red),
            SizedBox(
              height: 20,
            ),
            SpinKitHourGlass(color: AppColors.blue1),
            SizedBox(
              height: 20,
            ),
            SpinKitDualRing(color: AppColors.blue1),
            SizedBox(
              height: 20,
            ),
            SpinKitFadingFour(
              color: AppColors.blue1,
            ),
            SizedBox(
              height: 20,
            ),
          ]),
        ),
      ),
    );
  }
}
