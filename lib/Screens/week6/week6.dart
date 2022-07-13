import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weapp/Screens/week6/facebookads/facebookadshome.dart';
import 'package:weapp/Screens/week6/googleads/googleadshome.dart';
import 'package:weapp/Screens/week6/shareme.dart';
import 'package:weapp/constdata/textstyles.dart';

class Week6Demo extends StatelessWidget {
  const Week6Demo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Week 6",
          style: AppTextStyles.h3_Bold,
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: ListView(
          padding: EdgeInsets.all(20),
          children: [
            MaterialButton(
              elevation: 6,
              splashColor: AppColors.blue1,
              height: 100,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18)),
              minWidth: 200,
              padding: EdgeInsets.symmetric(vertical: 20),
              color: AppColors.blue1,
              onPressed: () {
                Get.to(() => ShareMediaDemo());
              },
              child: Text(
                "Share & Share With intent",
                textAlign: TextAlign.center,
                style:
                    AppTextStyles.h3_regular.copyWith(color: AppColors.white),
              ),
            ),
            SizedBox(
              height: 12,
            ),
            MaterialButton(
              elevation: 6,
              splashColor: AppColors.blue1,
              height: 100,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18)),
              minWidth: 200,
              padding: EdgeInsets.symmetric(vertical: 20),
              color: AppColors.blue1,
              onPressed: () {
                Get.to(() => GoogleAdsDemo());
              },
              child: Text(
                "Google AdMob",
                textAlign: TextAlign.center,
                style:
                    AppTextStyles.h3_regular.copyWith(color: AppColors.white),
              ),
            ),
            SizedBox(
              height: 12,
            ),
            MaterialButton(
              elevation: 6,
              splashColor: AppColors.blue1,
              height: 100,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18)),
              minWidth: 200,
              padding: EdgeInsets.symmetric(vertical: 20),
              color: AppColors.blue1,
              onPressed: () {
                Get.to(() => FacebookAdsDemo());
              },
              child: Text(
                "FaceBook Ad",
                textAlign: TextAlign.center,
                style:
                    AppTextStyles.h3_regular.copyWith(color: AppColors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
