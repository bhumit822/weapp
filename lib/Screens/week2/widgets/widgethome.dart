import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:weapp/Screens/week2/widgets/align.dart';
import 'package:weapp/Screens/week2/widgets/appbar.dart';
import 'package:weapp/Screens/week2/widgets/bottomNavigation/bottomnavigationbar.dart';
import 'package:weapp/Screens/week2/widgets/card.dart';
import 'package:weapp/Screens/week2/widgets/center.dart';
import 'package:weapp/Screens/week2/widgets/checbox.dart';
import 'package:weapp/Screens/week2/widgets/column.dart';
import 'package:weapp/Screens/week2/widgets/container.dart';
import 'package:weapp/Screens/week2/widgets/cupertinoalert.dart';
import 'package:weapp/Screens/week2/widgets/datatable.dart';
import 'package:weapp/Screens/week2/widgets/dismissable.dart';
import 'package:weapp/Screens/week2/widgets/dragable.dart';
import 'package:weapp/Screens/week2/widgets/progressindicators.dart';
import 'package:weapp/Screens/week2/widgets/radiobuton.dart';
import 'package:weapp/Screens/week2/widgets/row.dart';
import 'package:weapp/Screens/week2/widgets/slider.dart';
import 'package:weapp/Screens/week2/widgets/switch.dart';
import 'package:weapp/Screens/week2/widgets/tabbar.dart';
import 'package:weapp/Screens/week2/widgets/tabbar2.dart';
import 'package:weapp/constdata/iconstring.dart';
import 'package:weapp/constdata/textstyles.dart';

class Widgeshome extends StatelessWidget {
  const Widgeshome({Key? key}) : super(key: key);

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
            "Flutter Widgets",
            style: AppTextStyles.h3_Bold.copyWith(color: AppColors.blue1),
          )),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              CustomListTilewidgetss(
                  iconpath: SvgIcons.menu,
                  title: "AppBar",
                  ontap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => Appbardemo()));
                  }),
              CustomListTilewidgetss(
                  iconpath: SvgIcons.layouts,
                  title: "Bottom Navigation Bar",
                  ontap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => Bottomnavigation()));
                  }),
              CustomListTilewidgetss(
                  iconpath: SvgIcons.box,
                  title: "Container",
                  ontap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => Containerdemo()));
                  }),
              CustomListTilewidgetss(
                  iconpath: SvgIcons.column,
                  title: "Column",
                  ontap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => Columndemo()));
                  }),
              CustomListTilewidgetss(
                  iconpath: SvgIcons.row,
                  title: "Row",
                  ontap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => Rowdemo()));
                  }),
              CustomListTilewidgetss(
                  iconpath: SvgIcons.row,
                  title: "Align",
                  ontap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => Aligndemo()));
                  }),
              CustomListTilewidgetss(
                  iconpath: SvgIcons.row,
                  title: "Card",
                  ontap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => Carddemo()));
                  }),
              CustomListTilewidgetss(
                  iconpath: SvgIcons.row,
                  title: "Center",
                  ontap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => Centerdemo()));
                  }),
              CustomListTilewidgetss(
                  iconpath: SvgIcons.checkbox,
                  title: "CheckBox",
                  ontap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => CheckBoxdemo()));
                  }),
              CustomListTilewidgetss(
                  iconpath: SvgIcons.table,
                  title: "DataTable",
                  ontap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => DataTabledemo()));
                  }),
              CustomListTilewidgetss(
                  iconpath: SvgIcons.radio,
                  title: "Radio Button",
                  ontap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => RadioButtondemo()));
                  }),
              CustomListTilewidgetss(
                  iconpath: SvgIcons.radio,
                  title: "Dragable widget",
                  ontap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => Draggabledemo()));
                  }),
              CustomListTilewidgetss(
                  iconpath: SvgIcons.radio,
                  title: "Dismissable",
                  ontap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => Dismissibledemo()));
                  }),
              CustomListTilewidgetss(
                  iconpath: SvgIcons.swich,
                  title: "Switch",
                  ontap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => Switchdemo()));
                  }),
              CustomListTilewidgetss(
                  iconpath: SvgIcons.swich,
                  title: "ProgressIndicator",
                  ontap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ProgressIndicatordemo()));
                  }),
              CustomListTilewidgetss(
                  iconpath: SvgIcons.swich,
                  title: "TabBar",
                  ontap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => TabBardemo()));
                  }),
              CustomListTilewidgetss(
                  iconpath: SvgIcons.swich,
                  title: "TabBar 2",
                  ontap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => TabBar2demo()));
                  }),
              CustomListTilewidgetss(
                  iconpath: SvgIcons.swich,
                  title: "Cupertino Alert",
                  ontap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => CupertinoAlertDialogdemo()));
                  }),
              CustomListTilewidgetss(
                  iconpath: SvgIcons.swich,
                  title: "Slider",
                  ontap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => Sliderdemo()));
                  }),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomListTilewidgetss extends StatelessWidget {
  const CustomListTilewidgetss({
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
                height: 28,
                width: 28,
                child: SvgPicture.asset(
                  iconpath,
                  fit: BoxFit.contain,
                )),
            Text(
              title,
              style: AppTextStyles.h4_Bold,
            )
          ],
        ),
      ),
    );
  }
}
