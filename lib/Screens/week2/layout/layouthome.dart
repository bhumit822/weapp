import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:weapp/Screens/week2/layout/data/layoutdata.dart';
import 'package:weapp/Screens/week2/layout/layoutdetail.dart';
import 'package:weapp/constdata/iconstring.dart';
import 'package:weapp/constdata/textstyles.dart';

class LayoutHome extends StatefulWidget {
  const LayoutHome({Key? key}) : super(key: key);

  @override
  State<LayoutHome> createState() => _LayoutHomeState();
}

class _LayoutHomeState extends State<LayoutHome> {
  int selected = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bluewhite,
      extendBody: true,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Titlebar(),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Text(
                        "Where Do \nYou Want To Go ?",
                        style: AppTextStyles.h1_Bold.copyWith(
                            fontSize: 34, fontWeight: FontWeight.w900),
                      ),
                    ),
                    Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        margin: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            color: Color.fromARGB(255, 255, 255, 255),
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                  color: Color.fromARGB(255, 197, 197, 197),
                                  offset: Offset(0, 3),
                                  blurRadius: 5)
                            ]),
                        child: TextField(
                          decoration: InputDecoration(
                              hintText: "Search for Places . . .",
                              border: OutlineInputBorder(
                                  borderSide: BorderSide.none),
                              suffixIcon: Container(
                                  padding: EdgeInsets.all(4),
                                  child: Iconbg(icons: Icons.search))),
                        )),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Text(
                        "Categories",
                        style: AppTextStyles.h3_Bold,
                      ),
                    ),
                    Container(
                      height: 70,
                      child: ListView.builder(
                          padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
                          scrollDirection: Axis.horizontal,
                          itemCount: Data.a.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                setState(() {
                                  selected = index;
                                });
                              },
                              child: Container(
                                margin: EdgeInsets.symmetric(horizontal: 8),
                                decoration: BoxDecoration(
                                    color: selected == index
                                        ? Colors.white
                                        : Colors.white.withOpacity(0.5),
                                    boxShadow: [
                                      selected == index
                                          ? BoxShadow(
                                              color: AppColors.grey,
                                              offset: Offset(0, 3),
                                              blurRadius: 5)
                                          : BoxShadow(color: Colors.transparent)
                                    ],
                                    borderRadius: BorderRadius.circular(16)),
                                child: Row(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(left: 10),
                                      height: 37,
                                      width: 37,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(Data.a[index])),
                                        borderRadius: BorderRadius.circular(12),
                                        color: Colors.black12.withOpacity(0.04),
                                      ),
                                    ),
                                    Container(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 15),
                                      child: Text(
                                        Data.b[index],
                                        style: AppTextStyles.h4_Bold,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          }),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Top Trips",
                            style: AppTextStyles.h3_Bold,
                          ),
                          Icon(Icons.expand_more),
                          Spacer(),
                          Text(
                            "Explore",
                            style: AppTextStyles.h4_Bold,
                          ),
                          Icon(
                            Icons.arrow_forward,
                            size: 15,
                          )
                        ],
                      ),
                    ),
                    Container(
                      // height: 500,
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 100),
                      child: GridView.builder(
                          padding: EdgeInsets.all(25),
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: Data.a.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 10,
                                  mainAxisExtent:
                                      (MediaQuery.of(context).size.width - 50) *
                                          0.7,
                                  mainAxisSpacing: 8),
                          itemBuilder: (contex, index) {
                            return LayoutBuilder(builder: (context, constains) {
                              return InkWell(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (contex) =>
                                          LayoutDetail(image: Data.a[index])));
                                },
                                child: Container(
                                  padding: EdgeInsets.all(7),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                            color: AppColors.grey,
                                            blurRadius: 5,
                                            offset: Offset(0, 2))
                                      ],
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Column(children: [
                                    Container(
                                        height: constains.maxWidth - 14,
                                        decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.black,
                                                blurRadius: 20,
                                                offset: Offset(0, 6),
                                                spreadRadius: -10)
                                          ],
                                          borderRadius:
                                              BorderRadius.circular(17),
                                          image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image:
                                                  NetworkImage(Data.a[index])),
                                        )),
                                    Container(
                                      margin: EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 5),
                                      child: Row(
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Banjir Canal",
                                                style: AppTextStyles.h4_Bold,
                                              ),
                                              Text(
                                                "Camp",
                                                style: AppTextStyles.h4_regular
                                                    .copyWith(
                                                        color: Colors.grey),
                                              )
                                            ],
                                          ),
                                          Spacer(),
                                          Icon(
                                            Icons.favorite_border,
                                            color: Colors.grey,
                                          )
                                        ],
                                      ),
                                    )
                                  ]),
                                ),
                              );
                            });
                          }),
                    )
                  ]),
            ),
            IgnorePointer(
              ignoring: true,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    Colors.transparent.withOpacity(0),
                    Colors.white.withOpacity(0.5)
                  ], stops: [
                    0.7,
                    1
                  ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
                ),
              ),
            )
          ],
        ),
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
