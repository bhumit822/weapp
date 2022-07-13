import 'dart:io';

class AdHelper {
  static String BanerAd() {
    if (Platform.isAndroid) {
      return "ca-app-pub-8137289727083314/6897620618";
    } else {
      return "";
    }
  }

  static String InterstitialAd() {
    if (Platform.isAndroid) {
      return "ca-app-pub-8137289727083314/4271457279";
    } else {
      return "";
    }
  }

  static String Native_advancedAd() {
    if (Platform.isAndroid) {
      return "ca-app-pub-8137289727083314/2080408201";
    } else {
      return "";
    }
  }

  static String RewardedAd() {
    if (Platform.isAndroid) {
      return "ca-app-pub-8137289727083314/6035130936";
    } else {
      return "";
    }
  }

  static String Rewarded_interstitialAd() {
    if (Platform.isAndroid) {
      return "ca-app-pub-8137289727083314/9870186745";
    } else {
      return "";
    }
  }

  static String App_openAd() {
    if (Platform.isAndroid) {
      return "ca-app-pub-8137289727083314/7052451714";
    } else {
      return "";
    }
  }
}
