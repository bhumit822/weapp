import 'dart:developer';

import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:weapp/Screens/week6/googleads/adhelper.dart';
import 'package:weapp/Screens/week6/googleads/googleadshome.dart';

class AdController extends GetxController {
  late BannerAd bannerAd;
  RxBool isBannerLoaded = false.obs;
  late InterstitialAd interstitialAd;
  RxBool isInterstitialLoaded = false.obs;
  late InterstitialAd interstitialVideoAd;
  RxBool isInterstitialVideoLoaded = false.obs;
  late RewardedInterstitialAd rewardedInterstitialAd;

  late RewardedAd rewardedAd;

  NativeAd? adSmall;
  RxBool nativeSmallLoaded = false.obs;

  Future<void> initializeRewardedInterstitialAd() async {
    try {
      await RewardedInterstitialAd.load(
          adUnitId: 'ca-app-pub-3940256099942544/5354046379',
          request: AdRequest(),
          rewardedInterstitialAdLoadCallback:
              RewardedInterstitialAdLoadCallback(
                  onAdLoaded: (RewardedInterstitialAd ad) {
            log("RewardedInterstitialAd===========");
            rewardedInterstitialAd = ad;
          }, onAdFailedToLoad: (err) {
            log(err.toString());
          }));
    } catch (e) {
      log("rewardedinterstitial======================${e}");
    }
  }

  void loadNAtiveAd() {
    adSmall = NativeAd(
      // Here in adUnitId: add your own ad unit ID before release build
      adUnitId: NativeAd.testAdUnitId,
      factoryId: 'listTileSmall',
      request: const AdRequest(),
      listener: NativeAdListener(
        onAdLoaded: (_) {
          nativeSmallLoaded.value = true;
          log("Native Ad small Loaded");
        },
        onAdFailedToLoad: (ad, error) {
          // Releases an ad resource when it fails to load
          ad.dispose();

          print('Ad load failed (code=${error.code} message=${error.message})');
        },
      ),
    );

    adSmall!.load();
  }

  void intializeRewardedAd() async {
    RewardedAd.load(
      adUnitId: 'ca-app-pub-3940256099942544/5224354917',
      request: AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (RewardedAd ad) {
          // print('$ad loaded.');
          // // Keep a reference to the ad so you can show it later.
          rewardedAd = ad;
        },
        onAdFailedToLoad: (LoadAdError error) {
          print('RewardedAd failed to load====================: $error');
        },
      ),
    );
  }

  void intializeBannerAd() async {
    log("banner Ad");
    try {
      bannerAd = BannerAd(
          size: AdSize.banner,
          adUnitId: "ca-app-pub-3940256099942544/6300978111",
          listener: BannerAdListener(onAdLoaded: (ad) async {
            log("Banner add loaded");
            isBannerLoaded.value = true;
          }, onAdClosed: (ad) async {
            ad.dispose();
            isBannerLoaded.value = false;
          }, onAdFailedToLoad: (ad, err) {
            log(err.toString());
            isBannerLoaded.value = false;
          }),
          request: AdRequest());

      bannerAd.load();
    } catch (e) {
      print("Ads===========================$e");
    }
  }

  Future<void> intializeInterstitialAd() async {
    try {
      await InterstitialAd.load(
        adUnitId: "ca-app-pub-3940256099942544/1033173712",
        request: AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdFailedToLoad: (err) {
            log("$err");
            isInterstitialLoaded.value = false;
          },
          onAdLoaded: (ad) async {
            log("Interstitial ");
            interstitialAd = ad;
            isInterstitialLoaded.value = true;
            // ad.fullScreenContentCallback =
            //     FullScreenContentCallback(onAdDismissedFullScreenContent: (ad) {
            //   GoogleAdsDemo();
            // });
          },
        ),
      );
    } catch (e) {
      print("interstitial ad============================$e");
    }
  }

  Future<void> intializeInterstitialVideoAd() async {
    try {
      await InterstitialAd.load(
        adUnitId: "ca-app-pub-3940256099942544/8691691433",
        request: AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdFailedToLoad: (err) {
            log("$err");
            isInterstitialVideoLoaded.value = false;
          },
          onAdLoaded: (ad) async {
            log("Interstitial ");
            interstitialVideoAd = ad;
            isInterstitialVideoLoaded.value = true;
            // ad.fullScreenContentCallback =
            //     FullScreenContentCallback(onAdDismissedFullScreenContent: (ad) {
            //   GoogleAdsDemo();
            // });
          },
        ),
      );
    } catch (e) {
      print("interstitial ad============================$e");
    }
  }
//
//
//
//
//

  RxInt coins = 10.obs;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    log("Disposed");
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    log("Disposed============Ads");
    interstitialAd.dispose();
    interstitialVideoAd.dispose();
    bannerAd.dispose();
    rewardedAd.dispose();
    rewardedInterstitialAd.dispose();
  }
}

extension HEllo on AdController {
  AdController VV(Function(int a)) {
    log("-------------------=======================================--------------------------------object");
    return AdController();
  }
}
