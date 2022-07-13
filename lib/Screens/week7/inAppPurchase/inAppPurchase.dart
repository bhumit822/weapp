import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weapp/Screens/week7/inAppPurchase/inAppPurchaseHelper.dart';

class InAppPurchaseDemo extends StatefulWidget {
  const InAppPurchaseDemo({Key? key}) : super(key: key);

  @override
  State<InAppPurchaseDemo> createState() => _InAppPurchaseDemoState();
}

class _InAppPurchaseDemoState extends State<InAppPurchaseDemo> {
  InAppPurchaseHelper con = Get.put(InAppPurchaseHelper());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
    );
  }
}
