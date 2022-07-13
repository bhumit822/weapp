import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:weapp/Screens/week3/Sqflight/databsehelper.dart';
import 'package:weapp/constdata/textstyles.dart';

class Sqflite extends StatefulWidget {
  const Sqflite({Key? key}) : super(key: key);

  @override
  State<Sqflite> createState() => _SqfliteState();
}

class _SqfliteState extends State<Sqflite> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // oninit();
  }

  // oninit() async {
  //   await DBHelper.instance.database;
  // }
  XFile? image;
  Uint8List? i2;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MaterialButton(
              color: Colors.red,
              onPressed: () async {
                final _pick = await ImagePicker.platform
                    .getImage(source: ImageSource.gallery);
                setState(() {
                  image = _pick;
                });
              },
              child: Text("Image")),
          MaterialButton(
              color: Colors.red,
              onPressed: () async {
                File _f = File(image!.path);

                String imageString = base64Encode(_f.readAsBytesSync());
                setState(() {
                  i2 = base64Decode(imageString);
                });
                await DBHelper.instance.insert({
                  DBHelper.columnTitle: "hello",
                  DBHelper.columnImage: imageString
                });
              },
              child: Text("insert")),
          MaterialButton(
              color: Colors.red,
              onPressed: () async {
                final a = await DBHelper.instance.queryAll();
                print(a.length);
                // setState(() {
                //   i2 = base64Decode(a[0].image!);
                // });
              },
              child: Text("read")),
          MaterialButton(
              color: Colors.red,
              onPressed: () async {
                // final a = await DBHelper.instance.query();
                // print(a.length);
                DBHelper.instance.drpotable();
              },
              child: Text("Delet table")),
          i2 != null ? Image.memory(i2!) : SizedBox()
        ],
      )),
    );
  }
}
