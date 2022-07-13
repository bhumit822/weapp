import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:flutter_sms/flutter_sms.dart';
import 'package:url_launcher/url_launcher.dart' as launch;
import 'package:weapp/Screens/week4/call_sms_mail/mailerdemo.dart';
import 'package:weapp/constdata/textstyles.dart';

class CallSmsMail extends StatefulWidget {
  const CallSmsMail({Key? key}) : super(key: key);

  @override
  State<CallSmsMail> createState() => _CallSmsMailState();
}

class _CallSmsMailState extends State<CallSmsMail> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // custommail();
  }

  custommail() async {
    final Email a = Email(
      subject: "fLUTTER tEST",
      recipients: ["bhumitantala999@gmail.com"],
      body: "Test mail Templet ",
      isHTML: false,
    );

    await FlutterEmailSender.send(a);
  }

  // senMail() {
  //   final Uri params = Uri(
  //     scheme: 'mailto',

  //     path: 'Bantala822@gmail.com',
  //     query:
  //         'subject=App Feedback&body=App Version 3.23', //add subject and body here
  //   );
  //   launch.launchUrl(params, mode: launch.LaunchMode.platformDefault);
  // }

  call() async {
    await launch.launchUrl(Uri.parse("tel://+919913376667"));
  }

  sms() async {
    final a =
        await sendSMS(message: "test sMS Templet", recipients: ['9913376667']);
    print(a);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.arrow_back_ios,
            color: AppColors.blue1,
          ),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // MaterialButton(
            //   color: Colors.amber,
            //   onPressed: () {
            //     call();
            //   },
            //   child: Text("Call us"),
            // ),
            InvertedButtonFb2(
                text: "Call Us",
                onPressed: () {
                  call();
                }),
            SizedBox(
              height: 20,
            ),
            InvertedButtonFb2(
                text: "Mail Us",
                onPressed: () {
                  custommail();
                }),
            SizedBox(
              height: 20,
            ),
            InvertedButtonFb2(
                text: "Send SMS",
                onPressed: () {
                  sms();
                }),
            SizedBox(
              height: 20,
            ),
            InvertedButtonFb2(
                text: "InApp Mailer",
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (contex) => MailerDemo()));
                }),
            SizedBox(
              height: 20,
            ),

            // MaterialButton(
            //   color: Colors.amber,
            //   onPressed: () {
            //     // senMail();
            //   },
            //   child: Text("Mail Us"),
            // ),
          ],
        ),
      ),
    );
  }
}

class InvertedButtonFb2 extends StatelessWidget {
  final String text;
  final Function() onPressed;
  InvertedButtonFb2({required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xff4338CA);

    return OutlinedButton(
      style: ButtonStyle(
          elevation: MaterialStateProperty.all(0),
          alignment: Alignment.center,
          side: MaterialStateProperty.all(
              const BorderSide(width: 1, color: primaryColor)),
          padding: MaterialStateProperty.all(const EdgeInsets.only(
              right: 50, left: 50, top: 12.5, bottom: 12.5)),
          backgroundColor: MaterialStateProperty.all(Colors.transparent),
          shape: MaterialStateProperty.all(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0)))),
      onPressed: onPressed,
      child: Text(
        text,
        style: const TextStyle(color: primaryColor, fontSize: 16),
      ),
    );
  }
}
