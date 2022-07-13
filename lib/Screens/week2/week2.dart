import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:weapp/Screens/week2/datatransfer/page1.dart';
import 'package:weapp/Screens/week2/layout/layouthome.dart';
import 'package:weapp/Screens/week2/layout/layoutmain.dart';
import 'package:weapp/Screens/week2/layout2/layout2home.dart';
import 'package:weapp/Screens/week2/widgets/widgethome.dart';
import 'package:weapp/constdata/iconstring.dart';
import 'package:weapp/constdata/textstyles.dart';
import 'package:weapp/main.dart';

class Week2 extends StatefulWidget {
  const Week2({Key? key}) : super(key: key);

  @override
  State<Week2> createState() => _Week2State();
}

class _Week2State extends State<Week2> {
  GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bluewhite,
      key: _scaffoldkey,
      drawer: Container(
          height: MediaQuery.of(context).size.height,
          width: 250,
          padding: EdgeInsets.only(top: 50, bottom: 30),
          color: Colors.white,
          child: SafeArea(
              child: Column(
            children: [
              Container(
                height: 100,
                width: 100,
                child: CircleAvatar(
                  backgroundColor: Colors.indigo,
                  child: Container(
                    padding: EdgeInsets.all(20),
                    child: Image.asset(SvgIcons.avatar),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                "Bhumit Antala",
                style: AppTextStyles.h1_Bold.copyWith(),
              ),
              SizedBox(
                height: 50,
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (co) => MyHome()));
                },
                child: Container(
                  width: 130,
                  padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                  decoration: BoxDecoration(
                      color: AppColors.blue1,
                      borderRadius: BorderRadius.circular(14)),
                  child: Center(
                    child: Text(
                      "Home",
                      style: AppTextStyles.h3_regular
                          .copyWith(color: Colors.white),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                width: 130,
                padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                decoration: BoxDecoration(
                    color: AppColors.blue1,
                    borderRadius: BorderRadius.circular(14)),
                child: Center(
                  child: Text(
                    "Profile",
                    style:
                        AppTextStyles.h3_regular.copyWith(color: Colors.white),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                width: 130,
                padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                decoration: BoxDecoration(
                    color: AppColors.blue1,
                    borderRadius: BorderRadius.circular(14)),
                child: Center(
                  child: Text(
                    "Settings",
                    style:
                        AppTextStyles.h3_regular.copyWith(color: Colors.white),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                width: 130,
                padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                decoration: BoxDecoration(
                    color: AppColors.blue1,
                    borderRadius: BorderRadius.circular(14)),
                child: Center(
                  child: Text(
                    "Notification",
                    style:
                        AppTextStyles.h3_regular.copyWith(color: Colors.white),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Spacer(),
              Container(
                width: 130,
                padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                decoration: BoxDecoration(
                    color: AppColors.blue2,
                    borderRadius: BorderRadius.circular(14)),
                child: Center(
                  child: Text(
                    "Log Out",
                    style:
                        AppTextStyles.h3_regular.copyWith(color: Colors.white),
                  ),
                ),
              ),
            ],
          ))),
      appBar: AppBar(
        title: Text(
          "Week 2 Tasks",
          style: AppTextStyles.h2_regular
              .copyWith(color: Colors.black.withOpacity(0.7)),
        ),
        elevation: 0,
        centerTitle: true,
        leading: InkWell(
          onTap: () {
            _scaffoldkey.currentState!.openDrawer();
            print("object");
          },
          child: Container(
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: AppColors.grey.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(15)),
              padding: EdgeInsets.all(5),
              height: 25,
              width: 25,
              child: SvgPicture.asset(
                SvgIcons.menu,
                height: 25,
                width: 25,
                color: AppColors.blue1,
              )),
        ),
        backgroundColor: Colors.white,
      ),
      body: GestureDetector(
        // onHorizontalDragEnd: (v) {
        //   if (_scaffoldkey.currentState!.isDrawerOpen) {
        //     _scaffoldkey.currentState!.openEndDrawer();
        //     print("object  close");
        //   } else {
        //     print("object  open");
        //     _scaffoldkey.currentState!.openDrawer();
        //   }
        // },
        child: Container(
          color: Colors.white,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            padding: EdgeInsets.all(20),
            child: Column(children: [
              CustomListTile(
                ontap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => Transferscreen1()));
                },
                title: "Passing data between screens",
                iconpath: SvgIcons.datatransfer,
              ),
              CustomListTile(
                ontap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => Widgeshome()));
                },
                title: "Widgets",
                iconpath: SvgIcons.widgets,
              ),
              CustomListTile(
                ontap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => LayoutMainView()));
                },
                title: "Layout",
                iconpath: SvgIcons.widgets,
              ),
              // CustomListTile(
              //   ontap: () {
              //     Navigator.of(context).push(
              //         MaterialPageRoute(builder: (context) => Layout2home()));
              //   },
              //   title: "Layout 2",
              //   iconpath: SvgIcons.widgets,
              // ),
            ]),
          ),
        ),
      ),
    );
  }
}

class CustomListTile extends StatelessWidget {
  const CustomListTile({
    Key? key,
    required this.iconpath,
    required this.title,
    required this.ontap,
  }) : super(key: key);
  final String iconpath;
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
          children: [
            Container(
                margin: EdgeInsets.only(right: 20),
                height: 30,
                width: 30,
                child: SvgPicture.asset(
                  iconpath,
                  fit: BoxFit.contain,
                )),
            Flexible(
              child: Text(
                title,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: AppTextStyles.h4_Bold,
              ),
            )
          ],
        ),
      ),
    );
  }
}
