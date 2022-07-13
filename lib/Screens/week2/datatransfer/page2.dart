import 'package:flutter/material.dart';
import 'package:weapp/Screens/week2/datatransfer/page1.dart';
import 'package:weapp/constdata/textstyles.dart';
import 'package:weapp/widgets/commonbutton.dart';

class Transferscreen2 extends StatefulWidget {
  const Transferscreen2({Key? key, required this.name, required this.email})
      : super(key: key);
  final String name;
  final String email;

  @override
  State<Transferscreen2> createState() => _Transferscreen2State();
}

class _Transferscreen2State extends State<Transferscreen2> {
  TextEditingController name = TextEditingController();
  GlobalKey<FormState> _key = GlobalKey<FormState>();

  TextEditingController email = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    name.text = widget.name;
    email.text = widget.email;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bluewhite,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Screen 2",
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
            children: [
              customtextfieldweek2(
                validator: (v) {
                  if (v == null || v.isEmpty || v.length < 5) {
                    return "Enter Fullname";
                  } else {
                    return null;
                  }
                },
                controller: name,
                hint: "Name",
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
                          builder: (context) => Transferscreen1(
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
