import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:weapp/constdata/textstyles.dart';

class LayoutDetail extends StatefulWidget {
  LayoutDetail({Key? key, required this.image}) : super(key: key);
  final String image;
  @override
  State<LayoutDetail> createState() => _LayoutDetailState();
}

class _LayoutDetailState extends State<LayoutDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bluewhite,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.66,
              color: AppColors.bluewhite,
              child: Stack(children: [
                SafeArea(
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 10,
                              offset: Offset(0, 20),
                              spreadRadius: -10)
                        ]),
                    padding: EdgeInsets.fromLTRB(15, 10, 15, 0),
                    height: MediaQuery.of(context).size.height * 0.66,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.network(
                        widget.image,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Positioned(
                    top: 60,
                    left: 30,
                    child: InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Iconbg(icons: Icons.arrow_back))),
                Positioned(
                    top: 60,
                    right: 30,
                    child: Iconbg(icons: Icons.favorite_border)),
                Positioned(
                    bottom: 20,
                    right: 35,
                    child: Column(
                      children: [
                        Thumbnail(widget: widget),
                        Thumbnail(widget: widget),
                        Thumbnail(widget: widget),
                      ],
                    )),
                Positioned(
                    bottom: 20,
                    left: 35,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          constraints: BoxConstraints(maxWidth: 150),
                          child: Text(
                            "Banjir Kanal",
                            style: AppTextStyles.h1_Bold
                                .copyWith(color: Colors.white),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text.rich(TextSpan(children: [
                          TextSpan(
                              text: "\$120",
                              style: AppTextStyles.h2_Bold
                                  .copyWith(color: Colors.white)),
                          TextSpan(
                              text: "/Person",
                              style: AppTextStyles.h4_regular
                                  .copyWith(color: Colors.white)),
                        ])),
                      ],
                    )),
              ]),
            ),
            Expanded(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Container(
                  padding: EdgeInsets.only(bottom: 40),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(20),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "OverView",
                              style: AppTextStyles.h2_Bold
                                  .copyWith(fontWeight: FontWeight.w900),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Text(
                              "Review",
                              style: AppTextStyles.h4_Bold.copyWith(),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(20),
                        child: Row(children: [
                          Icon(
                            Icons.timer_sharp,
                            color: Color.fromARGB(255, 243, 176, 75),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Duration",
                                style: AppTextStyles.p1
                                    .copyWith(color: Colors.grey),
                              ),
                              Text(
                                "5 hours",
                                style: AppTextStyles.h3_Bold
                                    .copyWith(fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                          SizedBox(width: 50),
                          Icon(
                            Icons.timer_sharp,
                            color: Color.fromARGB(255, 243, 176, 75),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Rating",
                                style: AppTextStyles.p1
                                    .copyWith(color: Colors.grey),
                              ),
                              Text(
                                "4.8 out of 5",
                                style: AppTextStyles.h3_Bold
                                    .copyWith(fontWeight: FontWeight.bold),
                              )
                            ],
                          )
                        ]),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          """Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.""",
                          style: AppTextStyles.p1.copyWith(color: Colors.grey),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class Thumbnail extends StatelessWidget {
  const Thumbnail({
    Key? key,
    required this.widget,
  }) : super(key: key);

  final LayoutDetail widget;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 50,
      margin: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.2),
          borderRadius: BorderRadius.circular(10)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: Container(
              padding: EdgeInsets.all(4),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  widget.image,
                  fit: BoxFit.cover,
                ),
              )),
        ),
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
          color: Color.fromARGB(255, 236, 236, 236).withOpacity(0.4),
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
