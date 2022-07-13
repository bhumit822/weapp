import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weapp/Screens/week5/google&facebooklogin/googlefacebook_authcontroller.dart';
import 'package:weapp/constdata/textstyles.dart';

class GoogleAndFacebookSignin extends StatelessWidget {
  GoogleAndFacebookSignin({Key? key}) : super(key: key);

  FGAuthControler _auth = Get.put(FGAuthControler());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            MaterialButton(
              color: Colors.yellow,
              onPressed: () {
                _auth.googleAuth();
              },
              child: Text("Google"),
            ),
            MaterialButton(
              color: AppColors.blue3,
              onPressed: () {
                _auth.facebookAuth();
              },
              child: Text("FaceBook"),
            ),
          ],
          mainAxisAlignment: MainAxisAlignment.center,
        ),
      ),
    );
  }
}
