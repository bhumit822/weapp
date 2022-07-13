import 'package:flutter/material.dart';
import 'package:weapp/Screens/week2/datatransfer/page2.dart';
import 'package:weapp/constdata/textstyles.dart';
import 'package:weapp/widgets/commonbutton.dart';

class Transferscreen1 extends StatefulWidget {
  Transferscreen1({Key? key, this.name = "", this.email = ""})
      : super(key: key);
  String name;
  String email;
  @override
  State<Transferscreen1> createState() => _Transferscreen1State();
}

class _Transferscreen1State extends State<Transferscreen1> {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    name.text = widget.name;
    email.text = widget.email;
  }

  GlobalKey<FormState> _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bluewhite,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Screen 1",
          style: AppTextStyles.h3_Bold.copyWith(color: AppColors.blue3),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            )),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        padding: EdgeInsets.all(40),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Form(
          key: _key,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // customtextfieldweek2(
              //   validator: (v) {
              //     if (v == null && v!.isEmpty && v.length < 5) {
              //       return "Enter Fullname";
              //     } else {
              //       return null;
              //     }
              //   },
              //   controller: name,
              //   hint: "Name",
              // ),
              TextFormField(
                validator: (v) {
                  if (v == null || v.isEmpty || v.length < 5) {
                    return "Enter Fullname";
                  } else {
                    return null;
                  }
                },
                controller: name,
                decoration: InputDecoration(
                    label: Text("Full Name"),
                    hintText: "Full Name",
                    alignLabelWithHint: true,
                    focusedBorder: UnderlineInputBorder(
                        borderRadius: BorderRadius.circular(5)),
                    labelStyle:
                        AppTextStyles.p1.copyWith(color: AppColors.blue1),
                    border: UnderlineInputBorder(
                        borderRadius: BorderRadius.circular(5))),
              ),
              SizedBox(
                height: 20,
              ),
              customtextfieldweek2(
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
                controller: email,
                hint: "Email",
              ),
              SizedBox(
                height: 20,
              ),
              CommonButton(
                  ontap: () {
                    if (_key.currentState!.validate()) {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => Transferscreen2(
                                email: email.text,
                                name: name.text,
                              )));
                    }
                  },
                  title: "Submit",
                  color: AppColors.blue1)
            ],
          ),
        ),
      ),
    );
  }
}

class customtextfieldweek2 extends StatelessWidget {
  customtextfieldweek2({
    Key? key,
    required this.controller,
    required this.hint,
    required this.validator,
  }) : super(key: key);
  final TextEditingController controller;
  final String hint;
  final FormFieldValidator<String>? validator;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      controller: controller,
      decoration: InputDecoration(
          label: Text(hint),
          hintText: hint,
          alignLabelWithHint: true,
          focusedBorder:
              UnderlineInputBorder(borderRadius: BorderRadius.circular(5)),
          labelStyle: AppTextStyles.p1.copyWith(color: AppColors.blue1),
          border: UnderlineInputBorder(borderRadius: BorderRadius.circular(5))),
    );
  }
}
