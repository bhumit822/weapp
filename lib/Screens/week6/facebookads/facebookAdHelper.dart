import 'dart:developer';

import 'package:facebook_audience_network/ad/ad_interstitial.dart';
import 'package:facebook_audience_network/ad/ad_rewarded.dart';
import 'package:get/get.dart';

class FbAdHelper extends GetxController {
  RxInt reward = 0.obs;
  static initializeFbInterstitialAd() async {
    await FacebookInterstitialAd.loadInterstitialAd(
        placementId: 'IMG_16_9_APP_INSTALL#YOUR_PLACEMENT_ID',
        listener: (r, v) {
          if (r == InterstitialAdResult.LOADED) {
            log("Facebook interstitial Loaded==============");
          }
          if (r == InterstitialAdResult.DISMISSED) {
            initializeFbInterstitialAd();
          }
        });
  }

  static initializFbRewardedVideoAd() async {
    FacebookRewardedVideoAd.loadRewardedVideoAd(
      placementId: "YOUR_PLACEMENT_ID",
      listener: (result, value) {
        print("Rewarded Ad: $result --> $value");
        if (result == RewardedVideoAdResult.LOADED) log("object");
        if (result == RewardedVideoAdResult.VIDEO_COMPLETE)

        /// Once a Rewarded Ad has been closed and becomes invalidated,
        /// load a fresh Ad by calling this function.
        if (result == RewardedVideoAdResult.VIDEO_CLOSED &&
            (value == true || value["invalidated"] == true)) {
          // _isRewardedAdLoaded = false;
          log("Failed rewarded");
          initializFbRewardedVideoAd();
        }
      },
    );

    // await FacebookRewardedVideoAd.loadRewardedVideoAd(
    //     placementId: 'YOUR_PLACEMENT_ID',
    //     listener: (r, v) {
    //       print("Rewarded Ad: $r --> $v");
    //       if (r == InterstitialAdResult.LOADED) {
    //         log("Facebook rewarder video ad Loaded==============");
    //       }

    //       if (r == InterstitialAdResult.DISMISSED) {
    //         initializFbRewardedVideoAd();
    //       }

    //       log(r.toString());
    //     });
    // log("in side rewarder video =====================");

    // try {
    // FacebookRewardedVideoAd.loadRewardedVideoAd(
    //   placementId: "VID_HD_9_16_39S_APP_INSTALL#YOUR_PLACEMENT_ID",
    //   listener: (result, value) {
    //     print("Rewarded Ad: $result --> $value");
    //     if (result == RewardedVideoAdResult.LOADED) ;
    //     if (result == RewardedVideoAdResult.VIDEO_COMPLETE) {
    //       initializFbRewardedVideoAd();
    //     }

    //     if (result == RewardedVideoAdResult.ERROR) {
    //       log("Facebook Rewarder video Error");
    //     }

    //     /// Once a Rewarded Ad has been closed and becomes invalidated,
    //     /// load a fresh Ad by calling this function.
    //     if (result == RewardedVideoAdResult.VIDEO_CLOSED &&
    //         (value == true || value["invalidated"] == true)) {
    //       initializFbRewardedVideoAd();
    //     }
    //   },
    // FacebookRewardedVideoAd.loadRewardedVideoAd(
    //   placementId:
    //       // "VID_HD_9_16_39S_APP_INSTALL#898853027568012_965302514256396",
    //       "VID_HD_9_16_39S_APP_INSTALL#YOUR_PLACEMENT_ID",
    //   listener: (result, value) {
    //     print("Rewarded Ad: $result --> $value");
    //     if (result == RewardedVideoAdResult.LOADED) {
    //       print("Rewarded Loaded");
    //       // _isRewardedAdLoaded = true;
    //     }

    //     if (result == RewardedVideoAdResult.VIDEO_CLOSED) {
    //       // _isRewardedAdLoaded = false;
    //       initializFbRewardedVideoAd();
    //     }
    //     if (result == RewardedVideoAdResult.VIDEO_COMPLETE &&
    //         (value == true || value["invalidated"] == true)) {
    //       print("User Got Rewaed");
    //       // rewardedcoins = rewardedcoins + 10;
    //       // Fluttertoast.showToast(
    //       //     msg: "Reward Collected",
    //       //     // msg: "${revordpoint} coins",
    //       //     toastLength: Toast.LENGTH_SHORT,
    //       //     gravity: ToastGravity.BOTTOM,
    //       //     timeInSecForIosWeb: 1,
    //       //     backgroundColor: Colors.black54,
    //       //     textColor: Colors.white,
    //       //     fontSize: 16.0);
    //       // print(rewardedcoins);
    //     }
    //   },
    // );
    // } catch (e) {
    //   log(e.toString());
    // }
  }
}
