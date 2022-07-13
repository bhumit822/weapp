import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:weapp/Screens/week2/layout/data/layoutdata.dart';
import 'package:weapp/Screens/week2/layout/layouthome.dart';
import 'package:weapp/constdata/iconstring.dart';
import 'package:weapp/constdata/textstyles.dart';

class LayoutMainView extends StatefulWidget {
  const LayoutMainView({Key? key}) : super(key: key);

  @override
  State<LayoutMainView> createState() => _LayoutMainViewState();
}

class _LayoutMainViewState extends State<LayoutMainView> {
  int selected = 0;

  List pages = [
    LayoutHome(),
    Container(
      color: AppColors.blue3,
    ),
    Container(
      color: AppColors.grey,
    ),
    Container(
      color: Colors.amber,
    )
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bluewhite,
      extendBody: true,
      resizeToAvoidBottomInset: false,
      body: pages[botmsel],
      bottomNavigationBar: Container(
        height: 70,
        margin: EdgeInsets.all(20),
        decoration: BoxDecoration(
            color: Color.fromARGB(255, 26, 25, 25),
            borderRadius: BorderRadius.circular(20)),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(
                4,
                (index) => InkWell(
                      onTap: () {
                        setState(() {
                          botmsel = index;
                        });
                      },
                      child: botmitem(
                        icon: botmsel == index ? botmf[index] : botml[index],
                        isselected: botmsel == index,
                      ),
                    ))),
      ),
    );
  }

  int botmsel = 0;
  List botml = [SvgIcons.home, SvgIcons.location, SvgIcons.hert, SvgIcons.user];
  List botmf = [
    SvgIcons.homesolid,
    SvgIcons.locationsolid,
    SvgIcons.hertsolid,
    SvgIcons.usersolid
  ];
}

class botmitem extends StatefulWidget {
  const botmitem({Key? key, required this.icon, required this.isselected})
      : super(key: key);
  final String icon;
  final bool isselected;
  @override
  State<botmitem> createState() => _botmitemState();
}

class _botmitemState extends State<botmitem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(70),
            color: widget.isselected
                ? Colors.white.withOpacity(0.2)
                : Colors.transparent),
        padding: EdgeInsets.all(10),
        child: SvgPicture.asset(
          widget.icon,
          color: Colors.white,
        ),
      ),
    );
  }
}

class Titlebar extends StatelessWidget {
  const Titlebar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20.0, 20, 20, 0),
      child: Row(
        children: [
          SizedBox(
            child: CircleAvatar(
                backgroundImage: AssetImage("assets/images/simba.jpg")),
          ),
          SizedBox(
            width: 15,
          ),
          Text(
            "Hi,Loreum!",
            style: AppTextStyles.h3_Bold,
          ),
          Spacer(),
          Iconbg(
            icons: Icons.notifications,
          )
        ],
      ),
    );
  }
}

class Iconbg extends StatelessWidget {
  const Iconbg({Key? key, required this.icons}) : super(key: key);
  final IconData icons;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      height: 40,
      width: 40,
      decoration: BoxDecoration(
          color: Color.fromARGB(255, 236, 236, 236),
          borderRadius: BorderRadius.circular(100),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.3),
                offset: Offset(0, 3),
                blurRadius: 5)
          ]),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.7),
            borderRadius: BorderRadius.circular(100)),
        child: Icon(icons),
      ),
    );
  }
}
