import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:mailer/smtp_server/gmail.dart';
import 'package:weapp/constdata/textstyles.dart';

class MailerDemo extends StatefulWidget {
  const MailerDemo({Key? key}) : super(key: key);

  @override
  State<MailerDemo> createState() => _MailerDemoState();
}

class _MailerDemoState extends State<MailerDemo> {
  final _auth = FirebaseAuth.instance;
  @override
  void initState() {
    super.initState();
    getUser();
  }

  @override
  void dispose() {
    super.dispose();
    _auth.signOut();
    GoogleSignIn().signOut();
  }

  SmtpServer? _smtpServer;

  Message? message;
  String? mail;
  GoogleSignInAuthentication? token;
  bool sending = false;

  sendMail() async {
    setState(() {
      sending = true;
    });
    message = Message()
      ..from = Address(mail!, _name.text)
      ..recipients.add(_sendto.text)
      ..subject = _sbject.text
      ..text = _message.text;

    _smtpServer = gmailSaslXoauth2(mail!, token!.accessToken!);

    try {
      await send(message!, _smtpServer!);
      Fluttertoast.showToast(msg: "Mail sended");
      setState(() {
        sending = false;
      });
    } catch (e) {
      print(e);
      Fluttertoast.showToast(msg: e.toString());
      setState(() {
        sending = false;
      });
    }
  }

  Future<GoogleSignInAuthentication> getUser() async {
    final googleUser =
        await GoogleSignIn(scopes: ["https://mail.google.com/"]).signIn();

    final authprovder = await googleUser!.authentication;
    mail = googleUser.email;
    token = authprovder;
    setState(() {});
    Fluttertoast.showToast(msg: "signin as $mail");
    return authprovder;
  }

  GlobalKey<FormState> _form = GlobalKey<FormState>();

  String userName = "bantala822@gmail.com";
  String password = "bantala823";
  InputDecoration _inputDecoration = InputDecoration(border: InputBorder.none);

  TextEditingController _name = TextEditingController();
  TextEditingController _sendto = TextEditingController();
  TextEditingController _sbject = TextEditingController();
  TextEditingController _message = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            Text("InApp Mailer"),
            Text(
              mail ?? "",
              style: AppTextStyles.p2,
            ),
          ],
        ),
        centerTitle: true,
        backgroundColor: AppColors.blue3,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(20))),
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
        child: SingleChildScrollView(
          child: Form(
            key: _form,
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MailerTextField(
                  validator: (v) {
                    if (v == null || v.isEmpty) {
                      return "Enter Name";
                    } else {
                      return null;
                    }
                  },
                  title: "Name",
                  inputDecoration: _inputDecoration,
                  controller: _name,
                ),
                MailerTextField(
                  validator: (v) {
                    bool emailValid = RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                        .hasMatch(v!);
                    if (v == null ||
                        v.isEmpty ||
                        v.length < 5 ||
                        !emailValid ||
                        v == "") {
                      return "Enter valid E-mail Address!";
                    } else {
                      return null;
                    }
                  },
                  title: "Send To",
                  inputDecoration: _inputDecoration,
                  controller: _sendto,
                ),
                MailerTextField(
                  validator: (v) {
                    if (v == null || v.isEmpty) {
                      return "Enter Name";
                    } else {
                      return null;
                    }
                  },
                  title: "Subject",
                  inputDecoration: _inputDecoration,
                  controller: _sbject,
                ),
                MailerTextField(
                  title: "Message",
                  inputDecoration: _inputDecoration,
                  controller: _message,
                ),
                sending
                    ? Center(child: CircularProgressIndicator())
                    : MaterialButton(
                        color: Colors.amber,
                        onPressed: () {
                          setState(() {});
                          if (_form.currentState!.validate()) {
                            sendMail();
                          }
                        },
                        child: Text("Send"),
                      )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MailerTextField extends StatelessWidget {
  final String? error_message;

  const MailerTextField(
      {Key? key,
      required InputDecoration inputDecoration,
      required this.title,
      required this.controller,
      this.validator,
      this.error_message})
      : _inputDecoration = inputDecoration,
        super(key: key);

  final InputDecoration _inputDecoration;
  final String title;
  final String? Function(String?)? validator;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    print(validator);
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12), border: Border.all()),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                title,
                style: AppTextStyles.h4_Bold,
              ),
              SizedBox(
                width: 12,
              ),
              // title == "Message"
              //         controller.text.isEmpty ||
              //         controller.text.length < 5
              //     ? SizedBox()
              //     : Text(validator!.call(controller.text) ?? "")
            ],
          ),
          title == "Message"
              ? Container(
                  constraints: BoxConstraints(maxHeight: 300, minHeight: 230),
                  child: Scrollbar(
                    child: TextField(
                      scrollPadding: EdgeInsets.all(20),
                      controller: controller,
                      maxLines: null,
                      decoration: _inputDecoration.copyWith(),
                    ),
                  ),
                )
              : TextFormField(
                  validator: validator,
                  controller: controller,
                  decoration: _inputDecoration.copyWith(),
                ),
        ],
      ),
    );
  }
}
