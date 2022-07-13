import 'dart:developer';

import 'package:get/get.dart';
import 'package:flutter_inapp_purchase/flutter_inapp_purchase.dart';

class InAppPurchaseHelper extends GetxController {
  RxString platformVersion = "".obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    initializeInAppPurchas();
  }

  initializeInAppPurchas() async {
    final result = await FlutterInappPurchase.instance.initialize();
// platformVersion.value=await FlutterInappPurchase.instance.;
    log("$result");
  }
}
