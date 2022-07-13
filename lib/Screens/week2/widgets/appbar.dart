import 'package:flutter/material.dart';
import 'package:weapp/constdata/textstyles.dart';

class Appbardemo extends StatefulWidget {
  const Appbardemo({Key? key}) : super(key: key);

  @override
  State<Appbardemo> createState() => _AppbardemoState();
}

class _AppbardemoState extends State<Appbardemo>
    with SingleTickerProviderStateMixin {
  late TabController _tab;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tab = TabController(vsync: this, length: 3);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            "AppBar",
            style: AppTextStyles.h3_Bold.copyWith(color: AppColors.blue1),
          )),
      body: Container(
        padding: EdgeInsets.only(top: 30),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            AppBar(
              title: Text("Title"),
              actions: [
                Icon(Icons.search),
                SizedBox(
                  width: 10,
                ),
                Icon(Icons.settings),
                SizedBox(
                  width: 10,
                ),
                Icon(Icons.more_vert),
                SizedBox(
                  width: 20,
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            AppBar(
              centerTitle: true,
              backgroundColor: AppColors.blue3,
              title: Text("Title 2"),
              actions: [
                Icon(Icons.more_vert),
                SizedBox(
                  width: 15,
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 100,
              child: AppBar(
                centerTitle: true,
                backgroundColor: Color.fromARGB(255, 99, 209, 99),
                title: Text("Title 3"),
                actions: [
                  Icon(Icons.more_vert),
                  SizedBox(
                    width: 15,
                  ),
                ],
                bottom: PreferredSize(
                    child: Container(
                      height: 60,
                      child: TabBar(
                        controller: _tab,
                        tabs: [
                          Text("data 1"),
                          Text("data 2"),
                          Text("data 3"),
                        ],
                      ),
                    ),
                    preferredSize: Size.fromHeight(60)),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            AppBar(
              centerTitle: true,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              backgroundColor: AppColors.blue3,
              title: Text("Title 4"),
              actions: [
                Icon(Icons.more_vert),
                SizedBox(
                  width: 15,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
