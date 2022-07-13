import 'package:flutter/material.dart';
import 'package:weapp/Screens/week4/call_sms_mail/call_sms_mail.dart';
import 'package:weapp/Screens/week4/lazyloading.dart';
import 'package:weapp/Screens/week4/mapp.dart';
import 'package:weapp/constdata/iconstring.dart';
import 'package:weapp/constdata/textstyles.dart';

class Week4 extends StatefulWidget {
  const Week4({Key? key}) : super(key: key);

  @override
  State<Week4> createState() => _Week4State();
}

class _Week4State extends State<Week4> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: ListView(
            padding: EdgeInsets.all(20),
            children: [
              ListCard(
                ontap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (contex) => LazyLoading()));
                },
                image: Image.asset(
                  AppImages.lazy,
                  fit: BoxFit.fitHeight,
                ),
                title: "Lazy Loading",
              ),
              SizedBox(
                height: 20,
              ),
              ListCard(
                ontap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (contex) => MapDemo()));
                },
                image: Image.asset(
                  AppImages.mapbg,
                  fit: BoxFit.fitHeight,
                ),
                title: "Map Integration",
              ),
              SizedBox(
                height: 20,
              ),
              ListCard(
                ontap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (contex) => CallSmsMail()));
                },
                image: Image.asset(
                  AppImages.callsmsmail,
                  fit: BoxFit.fitHeight,
                ),
                title: "send email/sms/call",
              ),
            ],
          )),
    );
  }
}

class ListCard extends StatefulWidget {
  const ListCard(
      {Key? key, required this.image, required this.title, required this.ontap})
      : super(key: key);
  final Widget image;
  final String title;
  final VoidCallback ontap;

  @override
  State<ListCard> createState() => _ListCardState();
}

class _ListCardState extends State<ListCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.ontap,
      child: Container(
        height: 250,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: AppColors.white,
          boxShadow: [
            BoxShadow(
                color: AppColors.grey, offset: Offset(2, 5), blurRadius: 6),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Column(children: [
            Container(height: 200, child: widget.image),
            Container(
              padding: EdgeInsets.all(10),
              child: Text(
                widget.title,
                style: AppTextStyles.h2_Bold,
              ),
            )
          ]),
        ),
      ),
    );
  }
}
