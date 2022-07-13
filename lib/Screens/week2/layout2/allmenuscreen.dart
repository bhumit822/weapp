import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:weapp/constdata/iconstring.dart';
import 'package:weapp/constdata/textstyles.dart';

class Allmenu extends StatefulWidget {
  const Allmenu({Key? key}) : super(key: key);

  @override
  State<Allmenu> createState() => _AllmenuState();
}

class _AllmenuState extends State<Allmenu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              TitleRow(),
              Container(
                height: 190,
                child: GridView.builder(
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                    itemCount: 10,
                    scrollDirection: Axis.horizontal,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        mainAxisExtent: 210),
                    itemBuilder: (context, index) {
                      return Container(
                        padding: EdgeInsets.all(7),
                        decoration: BoxDecoration(
                            color: AppColors.bluewhite,
                            borderRadius: BorderRadius.circular(20)),
                        child: LayoutBuilder(builder: (context, constaints) {
                          return Row(
                            children: [
                              Container(
                                height: constaints.maxHeight - 5,
                                width: constaints.maxHeight - 5,
                                decoration: BoxDecoration(
                                    color: AppColors.white,
                                    borderRadius: BorderRadius.circular(15)),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Food Name",
                                    style: AppTextStyles.h4_Bold
                                        .copyWith(color: Colors.black),
                                  ),
                                  Text(
                                    "Delevered time",
                                    style: AppTextStyles.p1
                                        .copyWith(color: Colors.grey),
                                  ),
                                  Text(
                                    "Offer",
                                    style: AppTextStyles.p1
                                        .copyWith(color: AppColors.blue2),
                                  ),
                                ],
                              )
                            ],
                          );
                        }),
                      );
                    }),
              ),
              Tags(),
            ]),
          )),
    );
  }
}

class Tags extends StatelessWidget {
  const Tags({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Features(
          text: "Saved\nPlaces",
          imageicon: AppImages.bookmarked,
        ),
        Features(
          text: "Pro\nPartners",
          imageicon: AppImages.crown,
        ),
        Features(
          text: "Great\nOffers",
          imageicon: AppImages.discount,
        ),
        Features(
          text: "Top\nRated",
          imageicon: AppImages.star,
        ),
        Features(
          text: "Primeum\nPicks",
          imageicon: AppImages.diamond,
        ),
      ],
    );
  }
}

class Features extends StatelessWidget {
  final String text;

  final String imageicon;

  const Features({Key? key, required this.text, required this.imageicon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 60,
            width: 60,
            child: CircleAvatar(
                backgroundColor: Colors.orange.shade50,
                child: SizedBox(
                  height: 30,
                  width: 30,
                  child: Image.asset(
                    imageicon,
                    fit: BoxFit.contain,
                  ),
                )),
          ),
          Container(
              alignment: Alignment.center,
              constraints: BoxConstraints(maxWidth: 50),
              child: Text(
                text,
                textAlign: TextAlign.center,
              ))
        ],
      ),
    );
  }
}

class TitleRow extends StatelessWidget {
  const TitleRow({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(15, 10, 20, 0),
      child: Row(
        children: [
          Text(
            "Order Again",
            style: AppTextStyles.h3_Bold,
          ),
          Spacer(),
          Text(
            "See All",
            style: AppTextStyles.p2.copyWith(
                color: Colors.grey, decoration: TextDecoration.underline),
          )
        ],
      ),
    );
  }
}
