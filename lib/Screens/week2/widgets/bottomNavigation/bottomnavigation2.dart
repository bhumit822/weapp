import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:weapp/constdata/iconstring.dart';
import 'package:weapp/constdata/textstyles.dart';

class Bottomnavigation2 extends StatefulWidget {
  const Bottomnavigation2({Key? key}) : super(key: key);

  @override
  State<Bottomnavigation2> createState() => _Bottomnavigation2State();
}

class _Bottomnavigation2State extends State<Bottomnavigation2> {
  int bottomindex = 0;
  List items = [
    Container(
      color: AppColors.blue1,
    ),
    Container(
      color: Colors.amber,
    ),
    Container(
      color: Colors.orange,
    ),
    Container(
      color: Colors.indigo,
    ),
  ];

  List Iconss = [
    SvgIcons.layouts,
    SvgIcons.menu,
    SvgIcons.widgets,
    SvgIcons.menu
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBody: true,
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            items[bottomindex],
            AppBar(
              elevation: 0,
              leading: Icon(Icons.arrow_back_ios_new),
              backgroundColor: Colors.transparent,
            ),
          ],
        ),
        bottomNavigationBar: Container(
          height: 70,
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: AppColors.bluewhite, width: 2),
              borderRadius: BorderRadius.circular(25),
              boxShadow: [
                BoxShadow(
                    color: AppColors.grey.withOpacity(0.4),
                    blurRadius: 5,
                    offset: Offset(1, 4),
                    spreadRadius: -3)
              ]),
          margin: EdgeInsets.all(20),
          width: MediaQuery.of(context).size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: List.generate(
                4,
                (index) => Expanded(
                      child: InkWell(
                          onTap: () {
                            setState(() {
                              bottomindex = index;
                            });
                          },
                          child: Btnitem(
                              svgicon: Iconss[index],
                              isSelcted: bottomindex == index)),
                    )),
          ),
        ));
  }
}

class Btnitem extends StatefulWidget {
  const Btnitem({Key? key, required this.svgicon, required this.isSelcted})
      : super(key: key);
  final String svgicon;
  final bool isSelcted;
  @override
  State<Btnitem> createState() => _BtnitemState();
}

class _BtnitemState extends State<Btnitem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 28,
            width: 28,
            padding: EdgeInsets.all(2),
            child: SvgPicture.asset(
              widget.svgicon,
              color: widget.isSelcted ? AppColors.blue1 : AppColors.grey,
            ),
          ),
          AnimatedContainer(
            transformAlignment: Alignment.topCenter,
            duration: Duration(milliseconds: 200),
            curve: Curves.easeInCirc,
            height: widget.isSelcted ? 6 : 0,
            width: widget.isSelcted ? 6 : 0,
            decoration: BoxDecoration(
                color: AppColors.blue1,
                borderRadius: BorderRadius.circular(20)),
          )
        ],
      ),
    );
  }
}
