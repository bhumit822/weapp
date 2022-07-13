import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:weapp/Screens/week6/googleads/Ad_provide.dart';
import 'package:weapp/Screens/week6/googleads/adhelper.dart';
import 'package:weapp/constdata/textstyles.dart';

class GoogleAdsDemo extends StatefulWidget {
  const GoogleAdsDemo({Key? key}) : super(key: key);

  @override
  State<GoogleAdsDemo> createState() => _GoogleAdsDemoState();
}

class _GoogleAdsDemoState extends State<GoogleAdsDemo> {
  AdController _ads = Get.put(AdController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _ads.intializeBannerAd();
    _ads.intializeInterstitialAd();
    _ads.intializeInterstitialVideoAd();
    _ads.initializeRewardedInterstitialAd();
    _ads.intializeRewardedAd();
    _ads.loadNAtiveAd();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Center(child: Obx(() => Text("Rewards : ${_ads.coins.value}"))),
          SizedBox(width: 20)
        ],
      ),
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              MaterialButton(
                color: Colors.amber,
                onPressed: () async {
                  // if (_ads.isInterstitialLoaded.value) {
                  await _ads.interstitialAd.show().whenComplete(
                      () async => await _ads.intializeInterstitialAd());
                  _ads.isInterstitialLoaded.value = false;
                  // } else {
                  //   await _ads.intializeInterstitialAd();

                  //   await _ads.interstitialAd.show();
                  // }
                  // if (_ads.isInterstitialLoaded.value) {
                  // }
                },
                child: Text("Interstitial"),
              ),
              MaterialButton(
                color: Colors.amber,
                onPressed: () async {
                  // if(_ads.)
                  // await _ads.intializeInterstitialVideoAd();
                  // if (_ads.isInterstitialLoaded.value) {
                  await _ads.interstitialVideoAd.show().whenComplete(
                      () async => await _ads.intializeInterstitialVideoAd());
                  // }
                },
                child: Text("Interstitial Video"),
              ),
              Obx(
                () => _ads.nativeSmallLoaded.value
                    ? Container(
                        height: 100,
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: AdWidget(ad: _ads.adSmall!),
                      )
                    : SizedBox.shrink(),
              ),
              MaterialButton(
                color: Colors.amber,
                onPressed: () async {
                  // _ads.intializeRewardedAd();
                  await _ads.rewardedAd.show(onUserEarnedReward: (view, item) {
                    print(item.amount);
                    _ads.coins.value += item.amount.toInt();
                  }).whenComplete(() => _ads.intializeRewardedAd());
                },
                child: Text("Rewarded Video"),
              ),
              MaterialButton(
                color: Colors.amber,
                onPressed: () async {
                  // await _ads.initializeRewardedInterstitialAd();

                  // _ads.rewardedInterstitialAd.fullScreenContentCallback =
                  //     FullScreenContentCallback(
                  //   onAdShowedFullScreenContent: (RewardedInterstitialAd ad) =>
                  //       print('$ad onAdShowedFullScreenContent.'),
                  //   onAdDismissedFullScreenContent:
                  //       (RewardedInterstitialAd ad) {
                  //     print('$ad onAdDismissedFullScreenContent.');
                  //     ad.dispose();
                  //     _ads.initializeRewardedInterstitialAd();
                  //   },
                  //   onAdFailedToShowFullScreenContent:
                  //       (RewardedInterstitialAd ad, AdError error) {
                  //     print('$ad onAdFailedToShowFullScreenContent: $error');
                  //     ad.dispose();
                  //     _ads.initializeRewardedInterstitialAd();
                  //   },
                  // );
                  _ads.rewardedInterstitialAd.show(
                      onUserEarnedReward: (view, item) {
                    print(item.amount);
                    _ads.coins.value += item.amount.toInt();
                  }).whenComplete(() async =>
                      await _ads.initializeRewardedInterstitialAd());
                },
                child: Text("Rewarded Interstitial"),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: _ads.bannerAd.size.height.toDouble(),
        child: Obx(
          () => _ads.isBannerLoaded.value
              ? SizedBox(
                  child: Container(
                    child: AdWidget(
                      ad: _ads.bannerAd,
                    ),
                  ),
                )
              : Container(),
        ),
      ),
    );
  }
}
