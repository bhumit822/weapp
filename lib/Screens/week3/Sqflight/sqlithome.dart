import 'dart:convert';

import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:masonry_grid/masonry_grid.dart';
import 'package:weapp/Screens/week3/Sqflight/databsehelper.dart';
import 'package:weapp/Screens/week3/Sqflight/sqlcontroller.dart';
import 'package:weapp/constdata/iconstring.dart';
import 'package:weapp/constdata/textstyles.dart';

class SqLiteHome extends StatefulWidget {
  const SqLiteHome({Key? key}) : super(key: key);

  @override
  State<SqLiteHome> createState() => _SqLiteHomeState();
}

class _SqLiteHomeState extends State<SqLiteHome> {
  // List<NotesModel> data = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getData();
  }

  SqfLiteController _controller = SqfLiteController();

  Offset? _tapDownPosition;
  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();
  // Future getData() async {
  //   data = await DBHelper.instance.queryAll();
  //   setState(() {});
  //   print(data.length);
  // }
  int? tapedindex;
  TextEditingController _search = TextEditingController();
  @override
  Widget build(BuildContext context) {
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
                // SizedBox(
                //   height: 30,
                // ),
                // // Container(
                //   decoration: BoxDecoration(
                //       color: AppColors.white,
                //       borderRadius: BorderRadius.circular(12),
                //       boxShadow: [
                //         BoxShadow(
                //             color: AppColors.grey,
                //             offset: Offset(2, 4),
                //             blurRadius: 6)
                //       ]),
                //   child: TextField(
                //     autofocus: false,
                //     controller: _search,
                //     // onChanged: (v) {
                //     //   setState(() {

                //     //         .where((element) => element["Title"]
                //     //             .toString()
                //     //             .contains(_search.text))
                //     //         .toList();
                //     //   });
                //     // },
                //     decoration: InputDecoration(
                //         prefixIcon: Icon(Icons.search),
                //         constraints: BoxConstraints(maxHeight: 50),
                //         border: OutlineInputBorder(
                //             borderRadius: BorderRadius.circular(12),
                //             borderSide: BorderSide.none)),
                //   ),
                // )
              ],
            ),
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        clipBehavior: Clip.none,
        height: MediaQuery.of(context).size.height,
        // width: MediaQuery.of(context).size.width,
        child: CustomScrollView(
          clipBehavior: Clip.none,
          physics: BouncingScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(
              child: FutureBuilder<List<NotesModel>>(
                  future: DBHelper.instance.queryAll(),
                  builder: (context_, snapshot) {
                    if (snapshot.hasData && snapshot.data!.length != 0) {
                      final data = snapshot.data!;
                      return MasonryGrid(
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                          column: 2,
                          staggered: true,
                          children:
                              List.generate(snapshot.data!.length, (index) {
                            final _data = data[index];
                            Uint8List? a;
                            if (data[index].image != null) {
                              a = base64Decode(data[index].image!);
                            }
                            return GestureDetector(
                              onTapDown: (TapDownDetails details) {
                                _tapDownPosition = details.globalPosition;
                              },
                              onLongPress: () async {
                                final RenderObject? overlay =
                                    Overlay.of(context)!
                                        .context
                                        .findRenderObject();
                                overlay!.semanticBounds.size;
                                await showMenu(
                                  context: context,
                                  items: [
                                    PopupMenuItem(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 5),
                                      height: 0,
                                      value: "Edit",
                                      onTap: () async {},
                                      child: Text(
                                        "EDIT",
                                        style: AppTextStyles.h3_regular
                                            .copyWith(color: AppColors.white),
                                      ),
                                    ),
                                    PopupMenuItem(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 5),
                                      height: 0,
                                      onTap: () async {
                                        await DBHelper.instance
                                            .delete(_data.id);
                                        setState(() {});

                                        FocusManager.instance.primaryFocus!
                                            .unfocus();
                                      },
                                      child: Text(
                                        "DELETE",
                                        style: AppTextStyles.h3_regular
                                            .copyWith(color: AppColors.white),
                                      ),
                                    ),
                                  ],
                                  color: Color(0xff50c878),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8)),
                                  position: RelativeRect.fromLTRB(
                                    _tapDownPosition!.dx,
                                    _tapDownPosition!.dy,
                                    overlay.semanticBounds.size.width -
                                        _tapDownPosition!.dx,
                                    overlay.semanticBounds.size.height -
                                        _tapDownPosition!.dy,
                                  ),
                                ).then(
                                  (value) {
                                    if (value == "Edit") {
                                      Sqldialog(context, _data);
                                    }
                                  },
                                );

                                // widget.onItemSelected(value);
                              },
                              child: AnimatedContainer(
                                duration: Duration(milliseconds: 500),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                          color: AppColors.grey,
                                          offset: Offset(0, 3),
                                          blurRadius: 2)
                                    ],
                                    borderRadius: BorderRadius.circular(10)),
                                padding: EdgeInsets.symmetric(vertical: 5),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        _data.title,
                                        style: AppTextStyles.h3_Bold,
                                      ),
                                    ),
                                    data[index].image != null
                                        ? LayoutBuilder(
                                            builder: (context, constraints) {
                                            final w = constraints.maxWidth;
                                            return Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 8),
                                              width: w,
                                              constraints: BoxConstraints(
                                                  maxWidth: 200,
                                                  maxHeight: 200),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                child: Image.memory(
                                                  a!,
                                                  fit: BoxFit.cover,
                                                  alignment:
                                                      Alignment.topCenter,
                                                ),
                                              ),
                                            );
                                          })
                                        : SizedBox(),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        _data.description ?? "",
                                        style: AppTextStyles.p1,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }));
                    } else {
                      return Center(
                        child: Text("Create new notes."),
                      );
                    }
                  }),
            ),
          ],
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
          return SingleChildScrollView(
            child: Dialog(
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
                                          SizedBox(
                                            height: 50,
                                            width: 100,
                                            child: Image.memory(
                                              base64Decode(note.image!),
                                            ),
                                          ),
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
                          if (_form.currentState!.validate()) {
                            String? xstring;
                            if (_image != null) {
                              xstring = imageTobase64String(File(_image!.path));
                            }
                            if (note != null) {
                              final _data = {
                                DBHelper.columnId: note.id,
                                DBHelper.columnTitle: title.text,
                                DBHelper.columnDescription: description.text,
                                DBHelper.columnImage: xstring ?? note.image
                              };

                              await DBHelper.instance.update(_data);
                            } else {
                              final _data = {
                                DBHelper.columnTitle: title.text,
                                DBHelper.columnDescription: description.text,
                                DBHelper.columnImage: xstring ?? null
                              };
                              await DBHelper.instance.insert(_data);
                            }
                            setState(() {});
                            description.clear();
                            title.clear();
                            _image = null;

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
