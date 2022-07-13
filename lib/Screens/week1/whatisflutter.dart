import 'package:flutter/material.dart';
import 'package:weapp/constdata/strings.dart';
import 'package:weapp/constdata/textstyles.dart';

class WhatIsFlutter extends StatefulWidget {
  const WhatIsFlutter({Key? key}) : super(key: key);

  @override
  State<WhatIsFlutter> createState() => _WhatIsFlutterState();
}

class _WhatIsFlutterState extends State<WhatIsFlutter> {
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
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30), topRight: Radius.circular(30))),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppStrings.whatIsFlutter,
                  style: AppTextStyles.h1_Bold.copyWith(color: AppColors.blue1),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  AppStrings.whatIsFlutterdescription,
                  style: AppTextStyles.p1
                      .copyWith(height: 1.6, letterSpacing: 0.7),
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  AppStrings.importantFeaturesOfFlutter,
                  style: AppTextStyles.h1_Bold.copyWith(color: AppColors.blue1),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: AppStrings
                          .importantFeaturesOfFlutterdescription.length,
                      itemBuilder: (context, index) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppStrings
                                  .importantFeaturesOfFlutterdescription.keys
                                  .elementAt(index),
                              style: AppTextStyles.h2_Bold,
                            ),
                            Text(
                              AppStrings
                                  .importantFeaturesOfFlutterdescription.values
                                  .elementAt(index),
                              style: AppTextStyles.p1
                                  .copyWith(height: 1.6, letterSpacing: 0.7),
                            ),
                            SizedBox(
                              height: 10,
                            )
                          ],
                        );
                      }),
                ),
                SizedBox(
                  height: 25,
                ),
              ],
            ),
          )),
    );
  }
}
