import 'package:facebook_audience_network/ad/ad_banner.dart';
import 'package:facebook_audience_network/ad/ad_interstitial.dart';
import 'package:facebook_audience_network/ad/ad_rewarded.dart';
import 'package:facebook_audience_network/facebook_audience_network.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:weapp/Screens/week6/facebookads/facebookAdHelper.dart';
import 'package:weapp/constdata/textstyles.dart';

class FacebookAdsDemo extends StatefulWidget {
  const FacebookAdsDemo({Key? key}) : super(key: key);

  @override
  State<FacebookAdsDemo> createState() => _FacebookAdsDemoState();
}

class _FacebookAdsDemoState extends State<FacebookAdsDemo> {
  FbAdHelper _con = Get.put(FbAdHelper());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    FbAdHelper.initializeFbInterstitialAd();
    // FbAdHelper.initializFbRewardedVideoAd();
    _RewardedVideoAd();
  }

  void _RewardedVideoAd() {
    FacebookRewardedVideoAd.loadRewardedVideoAd(
      placementId:
          // "VID_HD_9_16_39S_APP_INSTALL#898853027568012_965302514256396",
          "VID_HD_16_9_15S_APP_INSTALL#YOUR_PLACEMENT_ID",
      listener: (result, value) {
        print("Rewarded Ad: $result --> $value");
        if (result == RewardedVideoAdResult.LOADED) {
          print("Rewarded Loaded");
          // _isRewardedAdLoaded = true;
        }

        if (result == RewardedVideoAdResult.VIDEO_CLOSED) {
          // _isRewardedAdLoaded = false;
          _RewardedVideoAd();
        }
        if (result == RewardedVideoAdResult.VIDEO_COMPLETE &&
            (value == true || value["invalidated"] == true)) {
          _con.reward.value += 10;
          print("User Got Rewaed");
          // rewardedcoins = rewardedcoins + 10;

        }
      },
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    FacebookRewardedVideoAd.destroyRewardedVideoAd();
    FacebookInterstitialAd.destroyInterstitialAd();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Center(
              child: Obx(
                () => Text(
                  _con.reward.value.toString(),
                  style: AppTextStyles.h2_Bold,
                ),
              ),
            ),
          )
        ],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text("FAceBook BanerAd"),
              Container(
                  child: FacebookBannerAd(
                bannerSize: BannerSize.STANDARD,
                keepAlive: true,
                placementId:
                    "IMG_16_9_APP_INSTALL#2312433698835503_2964944860251047", //testid
                listener: (res, dynamic) {
                  print(res);
                },
              )),
              Text("  Medium rectangle"),
              Container(
                  child: FacebookBannerAd(
                bannerSize: BannerSize.MEDIUM_RECTANGLE,
                keepAlive: true,
                placementId: 'IMG_16_9_APP_INSTALL#YOUR_PLACEMENT_ID',
                listener: (res, dynamic) {
                  print(res);
                },
              )),
              Text("Large Size Banner"),
              Container(
                  child: FacebookBannerAd(
                bannerSize: BannerSize.LARGE,
                keepAlive: true,
                placementId: 'IMG_16_9_APP_INSTALL#YOUR_PLACEMENT_ID',
                listener: (res, dynamic) {
                  print(res);
                },
              )),
              MaterialButton(
                color: Colors.amber,
                onPressed: () {
                  FacebookInterstitialAd.showInterstitialAd();
                },
                child: Text("FaceBook Interstitial AD"),
              ),
              MaterialButton(
                color: Colors.amber,
                onPressed: () async {
                  await FacebookRewardedVideoAd.showRewardedVideoAd()
                      .whenComplete(() {
                    Get.dialog(Center(
                      child: Material(
                        child: Container(
                            padding: EdgeInsets.all(20),
                            child: Text("Reward Collected")),
                      ),
                    ));
                  });
                },
                child: Text("FaceBook Rewarded AD"),
              ),
              SizedBox(
                height: 50,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 30),
                color: Colors.black.withOpacity(0.5),
                child: Text("NATIVE_AD",
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 10),
                alignment: Alignment(0.5, 1),
                child: FacebookNativeAd(
                  adType: NativeAdType.NATIVE_AD,
                  placementId: "IMG_16_9_APP_INSTALL#YOUR_PLACEMENT_ID",
                  width: double.infinity,
                  height: 200,
                  backgroundColor: Colors.white,
                  titleColor: Colors.black,
                  descriptionColor: Colors.white60,
                  labelColor: Colors.white60,
                  buttonColor: Colors.purple,
                  buttonTitleColor: Colors.white,
                  buttonBorderColor: Colors.white,
                  listener: (result, value) {
                    print("Native Banner Ad: $result --> $value");
                  },
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 30),
                color: Colors.black.withOpacity(0.5),
                child: Text("NATIVE_BANNER_AD",
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
              ),
              Container(
                height: NativeBannerAdSize.HEIGHT_100.height!.toDouble(),
                child: FacebookNativeAd(
                  // placementId: "YOUR_PLACEMENT_ID",
                  placementId:
                      "IMG_16_9_APP_INSTALL#2312433698835503_2964953543583512",
                  adType: NativeAdType.NATIVE_BANNER_AD,
                  bannerAdSize: NativeBannerAdSize.HEIGHT_100,
                  width: double.infinity,
                  backgroundColor: Colors.white,
                  titleColor: Colors.black,
                  descriptionColor: Colors.black,
                  buttonColor: Colors.deepPurple,
                  buttonTitleColor: Colors.white,
                  buttonBorderColor: Colors.white,
                  listener: (result, value) {
                    print("Native Banner Ad: $result --> $value");
                  },
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 30),
                color: Colors.black.withOpacity(0.5),
                child: Text("NATIVE_AD_VERTICAL",
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
              ),
              FacebookNativeAd(
                placementId:
                    "IMG_16_9_APP_INSTALL#2312433698835503_2964952163583650",
                // placementId: "CAROUSEL_IMG_SQUARE_APP_INSTALL",
                adType: NativeAdType.NATIVE_AD_VERTICAL,
                width: double.infinity,
                height: 300,
                backgroundColor: Colors.white,
                titleColor: Colors.black,
                descriptionColor: Colors.black,
                buttonColor: Colors.deepPurple,
                buttonTitleColor: Colors.white,
                buttonBorderColor: Colors.white,
                listener: (result, value) {
                  print("Native Ad: $result --> $value");
                },
                keepExpandedWhileLoading: true,
                expandAnimationDuraion: 1000,
              )
            ],
          ),
        ),
      ),
    );
  }
}
