import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weapp/Screens/week5/google&facebooklogin/home.dart';
import 'package:weapp/Screens/week5/google&facebooklogin/signin.dart';
import 'package:weapp/main.dart';

class FGAuthControler extends GetxController {
  static final auth = FirebaseAuth.instance;

  // dynamic firebaseUser = Rx<User>;

  Rx<AuthUserData> userdata = AuthUserData().obs;

  RxString providerId = "".obs;

  googleAuth() async {
    try {
      final googleSignIn = await GoogleSignIn().signIn();

      final authprovider = await googleSignIn!.authentication;

      final credential = GoogleAuthProvider.credential(
          accessToken: authprovider.accessToken, idToken: authprovider.idToken);

      Get.dialog(
          Material(
            color: Colors.transparent,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ),
          barrierDismissible: false);

      final user = await auth.signInWithCredential(credential);

      Get.back();

      if (user.user != null) {
        userdata.value = AuthUserData(
            name: user.user!.displayName,
            email: user.user!.email,
            photoURL: user.user!.photoURL);

        providerId.value = auth.currentUser!.providerData.first.providerId;
        box.put("providerId", providerId.value);
        box.put("userData", {
          "name": user.user!.displayName,
          "email": user.user!.email,
          "photoURL": user.user!.photoURL
        });
        Get.off(() => SigninHome());
      }
    } catch (e) {
      // Get.dialog(Center(child: Material(child: Text(e.toString()))));
    }
  }

  facebookAuth() async {
    try {
      final facebookSingIn = await FacebookAuth.instance.login();

      final data = await FacebookAuth.instance
          .getUserData(fields: "name,email,picture.width(200)");

      Get.dialog(
          Material(
            color: Colors.transparent,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ),
          barrierDismissible: false);

      final credential =
          FacebookAuthProvider.credential(facebookSingIn.accessToken!.token);

      final user = await auth.signInWithCredential(credential);
      Get.back();

      if (user.user != null) {
        userdata.value = AuthUserData(
            name: data["name"],
            email: data["email"],
            photoURL: data["picture"]["data"]["url"]);
        providerId.value = auth.currentUser!.providerData.first.providerId;
        box.put("providerId", providerId.value);
        box.put("userData", {
          "name": data["name"],
          "email": data["email"],
          "photoURL": data["picture"]["data"]["url"]
        });
        Get.off(() => SigninHome());
      }
    } catch (e) {
      // Get.dialog(Material(
      //   child: Text(e.toString()),
      // ));
    }
  }

  signout() async {
    if (providerId.value == "facebook.com") {
      await auth.signOut();
      await FacebookAuth.i.logOut();
    } else {
      await auth.signOut();
      GoogleSignIn().signOut();
    }

    Get.off(() => GoogleAndFacebookSignin());
  }
}

class AuthUserData {
  final String? name;
  final String? email;
  final String? photoURL;

  AuthUserData({this.name, this.email, this.photoURL});
}
