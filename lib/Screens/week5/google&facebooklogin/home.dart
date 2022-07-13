import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:weapp/Screens/week5/google&facebooklogin/googlefacebook_authcontroller.dart';
import 'package:weapp/Screens/week5/google&facebooklogin/signin.dart';
import 'package:weapp/constdata/textstyles.dart';
import 'package:weapp/main.dart';

import '../../week3/Api/model/usermodel.dart';

class SigninHome extends StatelessWidget {
  final data = box.get("userData");
  FGAuthControler _con = Get.put(FGAuthControler());
  @override
  Widget build(BuildContext context) {
    print(box.get("userData"));
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(box.get("providerId")),
          actions: [
            InkWell(
              onTap: () async {
                _con.signout();
              },
              child: Center(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    "Logout",
                    style: AppTextStyles.h3_Bold,
                  ),
                ),
              ),
            )
          ],
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  Get.dialog(
                      Center(
                        child: Material(
                          child: SizedBox(
                            height: 200,
                            width: 200,
                            child: Image.network(
                              data["photoURL"],
                              fit: BoxFit.fitWidth,
                            ),
                          ),
                          color: Colors.transparent,
                        ),
                      ),
                      barrierDismissible: true);
                },
                child: SizedBox(
                  height: 120,
                  width: 120,
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(data["photoURL"]),
                  ),
                ),
              ),
              Text(
                data['name'],
                style: AppTextStyles.h2_Bold,
              ),
              Text(
                data['email'],
                style: AppTextStyles.p1,
              ),
            ],
          ),
        )

        // body:
        );
  }
}
