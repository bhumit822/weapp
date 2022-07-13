import 'dart:io';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:weapp/Screens/week3/Api/model/dio.dart';
import 'package:weapp/Screens/week3/Api/model/usermodel.dart';
import 'package:weapp/constdata/textstyles.dart';
import 'package:weapp/widgets/weekbutton.dart';

class ApiDemo extends StatefulWidget {
  const ApiDemo({Key? key}) : super(key: key);

  @override
  State<ApiDemo> createState() => _ApiDemoState();
}

class _ApiDemoState extends State<ApiDemo> {
  // String intialMenuItem;
  List<String> menuitem = ["Delete", "Edit"];
  List<UserModal>? data;
  bool isLoading = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdata();
  }

  getdata() async {
    DioApi get = DioApi();
    data = await get.getUserList();
    setState(() {});
  }

  XFile? image;

  TextEditingController name = TextEditingController();
  TextEditingController mail = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Api",
          style: AppTextStyles.h2_Bold.copyWith(color: Color(0xff01d449)),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Color(0xff01d449),
            )),
        backgroundColor: Color.fromARGB(255, 255, 250, 250),
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Color(0xff01d449),
        onPressed: () async {
          await newMethod(context);
        },
        label: Text("User"),
        icon: Icon(Icons.add),
      ),
      body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: data != null
              ? ListView.builder(
                  padding: EdgeInsets.all(20),
                  itemCount: data!.length,
                  itemBuilder: (context, index) {
                    final res = data![index];

                    return Container(
                      margin: EdgeInsets.only(top: 10),
                      decoration: BoxDecoration(
                        border: Border.all(
                            width: 1,
                            color: Color(0xff01d449).withOpacity(0.3)),
                        boxShadow: [
                          BoxShadow(
                              color: Color(0xff01d449).withOpacity(0.1),
                              offset: Offset(-4, 5))
                        ],
                        borderRadius: BorderRadius.circular(8),
                        color: Color.fromARGB(255, 255, 250, 250),
                      ),
                      // margin: EdgeInsets.only(top: 10),
                      padding: EdgeInsets.all(10),
                      child: Row(
                        children: [
                          SizedBox(
                            height: 50,
                            width: 50,
                            child: CircleAvatar(
                                backgroundImage:
                                    NetworkImage(res.profilPicture)),
                          ),
                          SizedBox(width: 15),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                res.name,
                                style: AppTextStyles.h3_Bold,
                              ),
                              Text(
                                res.email,
                                style: AppTextStyles.p1
                                    .copyWith(color: Colors.grey),
                              ),
                            ],
                          ),
                          Spacer(),
                          PopupMenuButton(
                            color: Color(0xff50c878),
                            offset: Offset(-20, 15),
                            itemBuilder: (context) {
                              return menuitem
                                  .map((e) => PopupMenuItem(
                                      value: e,
                                      child: Text(
                                        e,
                                        style: AppTextStyles.h3_Bold
                                            .copyWith(color: Colors.white),
                                      )))
                                  .toList();
                            },
                            icon: Icon(Icons.more_vert),
                            onSelected: (v) async {
                              if (v == "Delete") {
                                deleteUser(res);
                              } else {
                                await newMethod(context, user: res);
                              }
                            },
                          )
                        ],
                      ),
                    );
                    // return ListTile(
                    //   trailing: Container(
                    //     child: Row(
                    //       mainAxisSize: MainAxisSize.min,
                    //       children: [
                    //         IconButton(
                    //           icon: Icon(Icons.delete),
                    //           onPressed: () async {
                    //             final isDeleted = await DioApi()
                    //                 .deleteUser({"user_id": res.userId});
                    //             if (isDeleted) {
                    //               setState(() {
                    //                 data!.removeWhere((element) =>
                    //                     element.userId == res.userId);
                    //               });
                    //             }
                    //           },
                    //         ),
                    //         IconButton(
                    //           icon: Icon(Icons.edit),
                    //           onPressed: () async {
                    //             await newMethod(context, user: res);
                    //           },
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    //   leading: CircleAvatar(
                    //       backgroundImage: NetworkImage(res.profilPicture)),
                    //   title: Text(res.name),
                    //   subtitle: Text(res.email),
                    // );
                  })
              : Center(child: CircularProgressIndicator())),
    );
  }

  deleteUser(UserModal res) async {
    final isDeleted = await DioApi().deleteUser({"user_id": res.userId});
    if (isDeleted) {
      setState(() {
        data!.removeWhere((element) => element.userId == res.userId);
      });
    }
  }

  GlobalKey<FormState> _form = GlobalKey<FormState>();
  newMethod(BuildContext context, {UserModal? user}) async {
    if (user != null) {
      name.text = user.name;
      mail.text = user.email;
    }
    showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(
            builder: (BuildContext context, setState) {
              return Dialog(
                child: Container(
                  padding: EdgeInsets.all(20),
                  child: Form(
                    key: _form,
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          InkWell(
                            onTap: () async {
                              final pikedImage = await ImagePicker.platform
                                  .getImage(source: ImageSource.gallery);
                              image = pikedImage;
                              setState(() {});
                            },
                            child: Container(
                              child: image != null
                                  ? SizedBox(
                                      height: 80,
                                      width: 80,
                                      child: CircleAvatar(
                                        backgroundImage:
                                            FileImage(File(image!.path)),
                                      ))
                                  : user != null
                                      ? SizedBox(
                                          height: 80,
                                          width: 80,
                                          child: CircleAvatar(
                                              backgroundImage: NetworkImage(
                                                  user.profilPicture)),
                                        )
                                      : SizedBox(
                                          height: 80,
                                          width: 80,
                                          child: CircleAvatar(
                                            child: Icon(Icons.add_a_photo),
                                          )),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: name,
                            validator: (v) {
                              if (v == null || v.isEmpty) {
                                return "Enter User name";
                              } else {
                                return null;
                              }
                            },
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: "User Name"),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          TextFormField(
                            controller: mail,
                            validator: (v) {
                              bool emailValid = RegExp(
                                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                  .hasMatch(v!);
                              if (v == null ||
                                  v.isEmpty ||
                                  v.length < 5 ||
                                  !emailValid ||
                                  v == "") {
                                return "Enter valid mail";
                              } else {
                                return null;
                              }
                            },
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: "Email"),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          isLoading
                              ? Center(
                                  child: CircularProgressIndicator(
                                      color: AppColors.blue1),
                                )
                              : WeekButton(
                                  ontap: () async {
                                    if (image == null) {
                                      Fluttertoast.showToast(
                                          msg: "Please Select Profile Picture",
                                          gravity: ToastGravity.TOP);
                                    }
                                    if (_form.currentState!.validate() &&
                                        image != null) {
                                      setState(() {
                                        isLoading = true;
                                      });
                                      if (user == null) {
                                        final _data = {
                                          "name": name.text,
                                          "email": mail.text,
                                        };
                                        final UserModal? newUser =
                                            await DioApi().addnewUser(
                                                _data, File(image!.path));

                                        if (newUser != null) {
                                          setState(() {
                                            getdata();
                                            setState(() {
                                              isLoading = false;
                                              name.clear();
                                              mail.clear();
                                              image = null;
                                            });

                                            Navigator.of(context).pop();
                                          });
                                        }
                                      } else {
                                        setState(() {
                                          isLoading = true;
                                        });
                                        final _data = {
                                          "user_id": user.userId,
                                          "name": name.text,
                                          "email": mail.text,
                                        };
                                        print("object");

                                        if (image != null) {
                                          await DioApi().changeProfilepicture(
                                              {"user_id": user.userId},
                                              File(image!.path));
                                        }

                                        await DioApi().updateUserdetail(_data);
                                        await getdata();
                                        setState(() {
                                          isLoading = false;
                                          name.clear();
                                          mail.clear();
                                          image = null;
                                        });
                                        Navigator.of(context).pop();
                                      }
                                    }
                                  },
                                  title: "Add User")
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        }).then((value) {
      name.clear();
      mail.clear();
      image = null;
    });
  }
}
