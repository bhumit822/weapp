import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:masonry_grid/masonry_grid.dart';
import 'package:weapp/Screens/week3/Sqflight/databsehelper.dart';
import 'package:weapp/Screens/week3/Sqflight/sqlcontroller.dart';
import 'package:weapp/constdata/iconstring.dart';
import 'package:weapp/constdata/textstyles.dart';

class SqLiteHome222 extends StatefulWidget {
  const SqLiteHome222({Key? key}) : super(key: key);

  @override
  State<SqLiteHome222> createState() => _SqLiteHome222State();
}

class _SqLiteHome222State extends State<SqLiteHome222> {
  final _controller = Get.put(SqfLiteController());
  @override
  void initState() {
    super.initState();
    _controller.fetchdata();
  }

  Offset? _tapDownPosition;
  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // print(_controller.data.length);
    return Scaffold(
      resizeToAvoidBottomInset: false,

      // extendBody: true,
      backgroundColor: AppColors.bluewhite,
      appBar: AppBar(
        backgroundColor: AppColors.bluewhite,
        leading: Container(
          padding: EdgeInsets.all(15),
          height: 30,
          width: 30,
          child: SvgPicture.asset(
            SvgIcons.grid,
            color: Color(0xff50c878),
            fit: BoxFit.fitHeight,
          ),
        ),
        elevation: 0,
        actions: [
          Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                image: DecorationImage(image: AssetImage(SvgIcons.avatar))),
          ),
          SizedBox(
            width: 20,
          )
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(70),
          child: Container(
            height: 70,
            padding: EdgeInsets.all(20),
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "My Notes",
                  style: AppTextStyles.h2_Bold,
                ),
              ],
            ),
          ),
        ),
      ),
      // body: Container(
      //   padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      //   clipBehavior: Clip.none,
      //   height: MediaQuery.of(context).size.height,
      //   width: MediaQuery.of(context).size.width,
      //   child: CustomScrollView(
      //     clipBehavior: Clip.none,
      //     physics: BouncingScrollPhysics(),
      //     slivers: [
      //       SliverToBoxAdapter(
      //           // child:
      //           ),
      //     ],
      //   ),
      // ),

      body: Container(
        child: Obx(
          () => ListView.builder(
              itemCount: _controller.data.length,
              itemBuilder: (context, index) {
                log("message");

                final _data = _controller.data[index];
                return Container(
                  child: Column(
                    children: [
                      Text(_data.title),
                      // _data.image != null
                      //     ? Image.memory(base64Decode(_data.image!))
                      //     : Image.asset(AppImages.mapbg)
                    ],
                  ),
                );
              }),
        ),
      ),

      floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Color(0xff50c878),
          onPressed: () {
            Sqldialog(context);
          },
          label: Text("Add New Note"),
          icon: Icon(Icons.add)),
    );
  }

  GlobalKey<FormState> _form = GlobalKey<FormState>();

  File? _image;
  Future<dynamic> Sqldialog(BuildContext context, [NotesModel? note]) async {
    print("object");
    if (note != null) {
      title.text = note.title;
      description.text = note.description ?? "";
    }
    return await showDialog(
        useSafeArea: true,
        context: context,
        builder: (contex) {
          print("object1111");
          return Dialog(
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.all(20),
                child: Form(
                  key: _form,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "New Note",
                        style: AppTextStyles.h2_regular,
                      ),
                      Divider(),
                      Container(
                        padding: EdgeInsets.all(10),
                        child: TextFormField(
                          validator: (v) {
                            if (v == null || v.isEmpty || v.length < 5) {
                              return "Title is Required";
                            } else {
                              return null;
                            }
                          },
                          controller: title,
                          decoration: InputDecoration(
                              hintText: "Title",
                              border: UnderlineInputBorder()),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        constraints:
                            BoxConstraints(maxHeight: 150, minHeight: 100),
                        child: Scrollbar(
                          child: TextFormField(
                            controller: description,
                            maxLines: null,
                            decoration: InputDecoration(
                                hintText: "Description",
                                border: UnderlineInputBorder()),
                          ),
                        ),
                      ),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Text("Image(optional)")),
                      SizedBox(
                        height: 10,
                      ),
                      StatefulBuilder(builder: (context, setState) {
                        return MaterialButton(
                          onPressed: () async {
                            final _picked = await ImagePicker.platform
                                .pickImage(
                                    source: ImageSource.gallery,
                                    imageQuality: 50);
                            setState(() {
                              _image = File(_picked!.path);
                            });
                          },
                          child: _image != null
                              ? Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      height: 50,
                                      width: 100,
                                      child: Image.file(_image!),
                                    ),
                                    IconButton(
                                        onPressed: () {
                                          setState(() {
                                            _image = null;
                                          });
                                        },
                                        icon: Icon(Icons.cancel))
                                  ],
                                )
                              : note != null && note.image != null
                                  ? Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                          // SizedBox(
                                          //   height: 50,
                                          //   width: 100,
                                          //   child: Image.memory(
                                          //     base64Decode(note.image!),
                                          //   ),
                                          // ),
                                          IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  note.image = null;
                                                });
                                              },
                                              icon: Icon(Icons.cancel))
                                        ])
                                  : Text(
                                      "Select Image",
                                      style: AppTextStyles.h3_Bold.copyWith(
                                          decoration: TextDecoration.underline),
                                    ),
                        );
                      }),
                      SizedBox(
                        height: 30,
                      ),
                      MaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        minWidth: 100,
                        color: Color(0xff50c878),
                        onPressed: () async {
                          // DBHelper.instance.deleterrr();
                          if (_form.currentState!.validate()) {
                            String? xstring;
                            if (_image != null) {
                              xstring = imageTobase64String(File(_image!.path));
                              print(base64Decode(
                                      imageTobase64String(File(_image!.path)))
                                  .length);
                            }
                            if (note != null) {
                              _controller.updaterow(note.id, title.text,
                                  description.text, xstring);
                            } else {
                              print(base64Decode(
                                      imageTobase64String(File(_image!.path)))
                                  .length);
                              _controller.addData(
                                  title.text, description.text, xstring);
                            }
                            // setState(() {});
                            // description.clear();
                            // title.clear();
                            // _image = null;

                            Navigator.of(context).pop();
                          }
                        },
                        child: Text(
                          "Add",
                          style: AppTextStyles.h3_Bold
                              .copyWith(color: AppColors.white),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        }).then((value) {
      title.clear();
      description.clear();
      _image = null;
    });
  }
}

String imageTobase64String(File file) {
  String base64String = base64Encode(file.readAsBytesSync());
  return base64String;
}
