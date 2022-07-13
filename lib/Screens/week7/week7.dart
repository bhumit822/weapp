import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weapp/Screens/week7/CameraCustom/cameraController.dart';
import 'package:weapp/Screens/week7/CameraCustom/cameraScreen.dart';
import 'package:weapp/Screens/week7/imagepickerCamera/defaultCamera.dart';
import 'package:weapp/Screens/week7/inAppPurchase/inAppPurchase.dart';
import 'package:weapp/constdata/textstyles.dart';

class Week7 extends StatefulWidget {
  const Week7({Key? key}) : super(key: key);

  @override
  State<Week7> createState() => _Week7State();
}

class _Week7State extends State<Week7> {
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bluewhite,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: AppColors.lightbalck,
            ),
            onPressed: () {
              Get.back();
            }),
        backgroundColor: AppColors.bluewhite,
        title: Text(
          "Week 7",
          style: AppTextStyles.h2_Bold.copyWith(color: AppColors.lightbalck),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        //   child: ListView.builder(
        //       padding: EdgeInsets.all(20),
        //       itemCount: 6,
        //       itemBuilder: (context, index) {
        //         return Container();
        //       }),
        // ),
        child: ListView(padding: EdgeInsets.all(20), children: [
          Week7Tile(
            icon: Icons.camera_enhance,
            onTap: () {
              // Get.to(() => CameraDemo());
            },
            title: "Camera",
          ),
          Week7Tile(
            icon: Icons.payments_outlined,
            onTap: () {
              // Get.to(() => DefaulCameraDemo());
            },
            title: "Default Camera ",
          ),
          Week7Tile(
            icon: Icons.payments_outlined,
            onTap: () {
              Get.to(() => InAppPurchaseDemo());
            },
            title: "InApp Purchase ",
          ),
          Week7Tile(
            icon: Icons.payment_rounded,
            onTap: () {},
            title: "Payment Gateway",
          ),
          Week7Tile(
            icon: Icons.replay_circle_filled_rounded,
            onTap: () {},
            title: "Pull to Refresh",
          ),
        ]),
      ),
    );
  }
}

class Week7Tile extends StatelessWidget {
  const Week7Tile({
    Key? key,
    required this.onTap,
    required this.title,
    required this.icon,
  }) : super(key: key);

  final VoidCallback onTap;
  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 20),
        height: 100,
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  color: AppColors.orangedull.withOpacity(0.5),
                  offset: Offset(0, 5),
                  blurRadius: 5)
            ],
            color: AppColors.orangedull,
            borderRadius: BorderRadius.circular(20)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
                height: 70,
                width: 70,
                child: Icon(
                  icon,
                  size: 30,
                  color: AppColors.white,
                )),
            SizedBox(
              width: 20,
            ),
            Text(
              title,
              style: AppTextStyles.h3_regular.copyWith(color: AppColors.white),
            ),
          ],
        ),
      ),
    );
  }
}
