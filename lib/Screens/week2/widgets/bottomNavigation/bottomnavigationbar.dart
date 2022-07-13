import 'package:flutter/material.dart';
import 'package:weapp/Screens/week2/widgets/bottomNavigation/bottomnaviagtion1.dart';
import 'package:weapp/Screens/week2/widgets/bottomNavigation/bottomnavigation2.dart';
import 'package:weapp/constdata/textstyles.dart';

class Bottomnavigation extends StatefulWidget {
  const Bottomnavigation({Key? key}) : super(key: key);

  @override
  State<Bottomnavigation> createState() => _BottomnaigationState();
}

class _BottomnaigationState extends State<Bottomnavigation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bluewhite,
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: AppColors.blue1,
              )),
          title: Text(
            "Bottom Navigation",
            style: AppTextStyles.h3_Bold.copyWith(color: AppColors.blue1),
          )),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              CustomListTilewidgetbottom(
                  title: "Bottom Navigation 1",
                  ontap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => Bottomnavigation1()));
                  }),
              CustomListTilewidgetbottom(
                  title: "Bottom Navigation 2",
                  ontap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => Bottomnavigation2()));
                  }),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomListTilewidgetbottom extends StatelessWidget {
  const CustomListTilewidgetbottom({
    Key? key,
    required this.title,
    required this.ontap,
  }) : super(key: key);

  final String title;
  final VoidCallback ontap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Container(
        height: 80,
        padding: EdgeInsets.all(20),
        margin: EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: AppColors.bluewhite, width: 1.5),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                  offset: Offset(-2, 3), color: AppColors.grey, blurRadius: 8)
            ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: AppTextStyles.h3_Bold,
            )
          ],
        ),
      ),
    );
  }
}
