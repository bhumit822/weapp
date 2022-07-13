import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:share_plus/share_plus.dart';
import 'package:social_share/social_share.dart';
import 'package:weapp/constdata/textstyles.dart';
import 'package:flutter_share_me/flutter_share_me.dart';

class ShareMediaDemo extends StatefulWidget {
  const ShareMediaDemo({Key? key}) : super(key: key);

  @override
  State<ShareMediaDemo> createState() => _ShareMediaDemoState();
}

class _ShareMediaDemoState extends State<ShareMediaDemo> {
  TextEditingController _msg = TextEditingController();

  FlutterShareMe _share = FlutterShareMe();
  SocialShare _socialShare = SocialShare();
  File? _image;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [
        IconButton(
            onPressed: () {
              _image = null;
              _msg.text = "";
              setState(() {});
            },
            icon: Icon(Icons.restart_alt))
      ]),
      body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(30),
          child: SingleChildScrollView(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              InkWell(
                  onTap: () async {
                    final _pickImage = await ImagePicker.platform
                        .getImage(source: ImageSource.gallery);

                    _image = File(_pickImage!.path);
                    setState(() {});
                  },
                  child: SizedBox(
                      height: 220,
                      width: 220,
                      child: _image == null
                          ? Center(child: Icon(Icons.add_a_photo_outlined))
                          : Image.file(_image!))),
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: _msg,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15)),
                    hintText: "Message"),
              ),
              MaterialButton(
                onPressed: () async {
                  if (_image != null && _msg.text.length > 1 && _msg != "") {
                    await Share.shareFiles([_image!.path], text: _msg.text);
                  } else if (_msg.text.length > 1 && _msg != "") {
                    await Share.share(_msg.text);
                  } else if (_image != null) {
                    await Share.shareFiles([_image!.path]);
                  } else {
                    Fluttertoast.showToast(
                        msg: "Enter msg Or Select Image or both");
                  }
                },
                child: Text(
                  "Share",
                  style: AppTextStyles.h3_Bold.copyWith(color: AppColors.white),
                ),
                color: AppColors.blue1,
              ),
              SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MaterialButton(
                    color: AppColors.blue2,
                    onPressed: () {
                      if (_image != null || _msg.text.length > 0) {
                        _share.shareToWhatsApp(
                            msg: _msg.text,
                            fileType: FileType.image,
                            imagePath: _image != null
                                ? _image!.path
                                : ""); //  complate
                      } else {
                        Fluttertoast.showToast(
                            msg: "Enter msg Or Select Image or both");
                      }

                      // _share.shareToFacebook(msg: _msg.text, url: _image!.path);
                      // _share.shareToInstagram(
                      //     filePath: _image!.path, fileType: FileType.image);  //  complate

                      // _share.shareToTwitter(msg: "asdasd");
                    },
                    child: Text("WhatsApp"),
                  ),
                  MaterialButton(
                    color: AppColors.blue2,
                    onPressed: () {
                      // _share.shareToWhatsApp(
                      //     msg: _msg.text,
                      //     fileType: FileType.image,
                      //     imagePath: _image!.path);    //  complate

                      // _share.shareToFacebook(msg: _msg.text);

                      if (_image != null && _msg.text.length > 0) {
                        _share.shareToInstagram(
                            filePath: _image!.path,
                            fileType: FileType.image); //  complate

                      } else {
                        Fluttertoast.showToast(
                            msg: "Select image ,Image is required ");
                      }

                      // _share.shareToTwitter(msg: "asdasd");
                    },
                    child: Text("Instagram"),
                  ),
                  MaterialButton(
                    color: AppColors.blue2,
                    onPressed: () {
                      // _share.shareToWhatsApp(
                      //     msg: _msg.text,
                      //     fileType: FileType.image,
                      //     imagePath: _image!.path);    //  complate

                      if (_msg.text.length > 0) {
                        SocialShare.shareTwitter(_msg.text,
                            url: 'https://pub.dev/packages/social_share ');
                        // SocialShare.shareFacebookStory(
                        //     _image!.path, "black", "blue", "",
                        //     appId: '364768665718186');
                        // _share.shareToTwitter(
                        //   msg: _msg.text,
                        // );
                      } else {
                        Fluttertoast.showToast(msg: "Enter Text Content");
                      }
                      // _share.shareToInstagram(
                      //     filePath: _image!.path, fileType: FileType.image);  //  complate

                      // _share.shareToTwitter(msg: "asdasd");
                    },
                    child: Text("Twitter"),
                  ),
                ],
              )
            ]),
          )),
    );
  }
}
