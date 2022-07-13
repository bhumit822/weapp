import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weapp/Screens/week5/audioplayer/audioplayer.dart';
import 'package:weapp/Screens/week5/google&facebooklogin/home.dart';
import 'package:weapp/Screens/week5/google&facebooklogin/signin.dart';
import 'package:weapp/Screens/week5/videoPlayer/folderList.dart';
import 'package:weapp/Screens/week5/videoPlayer/videoplayerControler.dart';
import 'package:weapp/constdata/textstyles.dart';

class Week5 extends StatefulWidget {
  const Week5({Key? key}) : super(key: key);

  @override
  State<Week5> createState() => _Week5State();
}

class _Week5State extends State<Week5> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.blue3,
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(Icons.arrow_back_ios_new_rounded),
        ),
        title: Text(
          "Week 5",
          style: AppTextStyles.h2_Bold,
        ),
      ),
      body: Container(
          child: ListView(
        padding: EdgeInsets.all(20),
        children: [
          MaterialButton(
            elevation: 6,
            splashColor: AppColors.blue1,
            height: 100,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(33)),
            minWidth: 200,
            padding: EdgeInsets.symmetric(vertical: 20),
            color: AppColors.blue3,
            onPressed: () {
              final _page = FirebaseAuth.instance.currentUser != null
                  ? SigninHome()
                  : GoogleAndFacebookSignin();
              Get.to(() => _page);
            },
            child: Text(
              "Google/Facebook\nAuthentication",
              textAlign: TextAlign.center,
              style: AppTextStyles.h3_regular.copyWith(color: AppColors.white),
            ),
          ),
          SizedBox(
            height: 12,
          ),
          MaterialButton(
            elevation: 6,
            splashColor: AppColors.blue1,
            height: 100,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            minWidth: 200,
            padding: EdgeInsets.symmetric(vertical: 20),
            color: AppColors.blue3,
            onPressed: () {
              Get.to(() => AudioPlayerDemo());
            },
            child: Text(
              "Audio Player",
              textAlign: TextAlign.center,
              style: AppTextStyles.h3_regular.copyWith(color: AppColors.white),
            ),
          ),
          SizedBox(
            height: 12,
          ),
          MaterialButton(
            elevation: 6,
            splashColor: AppColors.blue1,
            height: 100,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
            minWidth: 200,
            padding: EdgeInsets.symmetric(vertical: 20),
            color: AppColors.blue3,
            onPressed: () {
              Get.to(() => VideoPlayerDemo());
            },
            child: Text(
              "Video Player",
              textAlign: TextAlign.center,
              style: AppTextStyles.h3_regular.copyWith(color: AppColors.white),
            ),
          ),
        ],
      )),
    );
  }
}
