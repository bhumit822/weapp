import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:weapp/Screens/week2/layout/data/layoutdata.dart';
import 'package:weapp/Screens/week2/layout2/allmenuscreen.dart';
import 'package:weapp/constdata/iconstring.dart';
import 'package:weapp/constdata/textstyles.dart';

class Layout2home extends StatefulWidget {
  const Layout2home({Key? key}) : super(key: key);

  @override
  State<Layout2home> createState() => _Layout2homeState();
}

class _Layout2homeState extends State<Layout2home> {
  List tabs = [
    "All",
    "Dosa",
    "Chinese",
    "Pizza",
    "Italian",
    "Indian",
    "Punjabi",
    "Burgure"
  ];

  List<Widget> tabItems = [
    Allmenu(),
    Container(
      child: Center(
        child: Text(
          "Dosa",
        ),
      ),
    ),
    Container(
      child: Center(
        child: Text(
          "Chinese",
        ),
      ),
    ),
    Container(
      child: Center(
        child: Text(
          "Pizza",
        ),
      ),
    ),
    Container(
      child: Center(
        child: Text(
          "Italian",
        ),
      ),
    ),
    Container(
      child: Center(
        child: Text(
          "Indian",
        ),
      ),
    ),
    Container(
      child: Center(
        child: Text(
          "Punjabi",
        ),
      ),
    ),
    Container(
      child: Center(
        child: Text(
          "Burgure",
        ),
      ),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 8,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        extendBody: true,
        backgroundColor: AppColors.bluewhite,
        appBar: AppBar(
          actions: [
            Container(
                height: 50, width: 50, child: Image.asset(SvgIcons.avatar)),
            SizedBox(
              width: 20,
            )
          ],
          elevation: 0,
          backgroundColor: AppColors.bluewhite,
          automaticallyImplyLeading: false,
          title: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Icon(
                Icons.pin_drop_outlined,
                color: Colors.amber,
              ),
              Text(
                "Surat,Gujart.",
                style: AppTextStyles.h3_Bold.copyWith(color: Colors.black),
              ),
            ],
          ),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(100),
            child: Container(
              height: 100,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    height: 45,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              color: AppColors.grey,
                              offset: Offset(0, 3),
                              blurRadius: 3),
                        ],
                        borderRadius: BorderRadius.circular(15)),
                    child: TextField(
                      textAlignVertical: TextAlignVertical.center,
                      decoration: InputDecoration(
                          hintText: "Search Retaurant Or Dishes",
                          suffixIcon: Icon(Icons.search),
                          border:
                              OutlineInputBorder(borderSide: BorderSide.none)),
                    ),
                  ),
                  Expanded(
                      child: Container(
                    child: TabBar(
                        unselectedLabelStyle:
                            AppTextStyles.p1.copyWith(color: Colors.black),
                        labelStyle:
                            AppTextStyles.h4_Bold.copyWith(color: Colors.black),
                        isScrollable: true,
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        tabs: tabs
                            .map((e) => Text(
                                  e,
                                  style: TextStyle(color: Colors.black),
                                ))
                            .toList()),
                  ))
                ],
              ),
            ),
          ),
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: TabBarView(
            children: tabItems,
          ),
        ),
      ),
    );
  }
}
