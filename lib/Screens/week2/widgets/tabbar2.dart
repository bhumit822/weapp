import 'package:flutter/material.dart';
import 'package:flutter/src/scheduler/ticker.dart';
import 'package:tab_container/tab_container.dart';
import 'package:weapp/constdata/textstyles.dart';

class TabBar2demo extends StatefulWidget {
  const TabBar2demo({Key? key}) : super(key: key);

  @override
  State<TabBar2demo> createState() => _TabBar2demoState();
}

class _TabBar2demoState extends State<TabBar2demo>
    with TickerProviderStateMixin {
  late final TabContainerController _controller;
  late TextTheme textTheme;

  late TabController aa;
  @override
  void initState() {
    super.initState();
    aa = TabController(vsync: this, length: 4);
    aa.addListener(() {
      print(aa);
      setState(() {
        insd = aa.index;
      });
    });
  }

  List a = [Colors.red, Colors.blue, Colors.indigo, Colors.amber];
  var insd = 0;
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
            "TabBar 2",
            style: AppTextStyles.h3_Bold.copyWith(color: AppColors.blue1),
          )),
      body: DefaultTabController(
        length: 4,
        child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: TabBar(
                    controller: aa,
                    indicator: BoxDecoration(
                        color: a[insd],
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(20))),
                    labelColor: Colors.white,
                    unselectedLabelColor: Colors.black,
                    tabs: [
                      Tab(
                        iconMargin: EdgeInsets.all(0),
                        icon: Icon(Icons.home),
                        text: "Home",
                      ),
                      Tab(
                        iconMargin: EdgeInsets.all(0),
                        icon: Icon(Icons.person),
                        text: "Home",
                      ),
                      Tab(
                        iconMargin: EdgeInsets.all(0),
                        icon: Icon(Icons.share),
                        text: "Home",
                      ),
                      Tab(
                        iconMargin: EdgeInsets.all(0),
                        icon: Icon(Icons.alarm),
                        text: "Home",
                      )
                    ],
                  ),
                ),
                Expanded(
                    child: TabBarView(
                        controller: aa,
                        children: a
                            .map((e) => Container(
                                  color: e,
                                ))
                            .toList()))
              ],
            )),
      ),
    );
  }
}
// import 'package:flutter/material.dart';
// import 'package:tab_container/tab_container.dart';
// import 'package:weapp/constdata/textstyles.dart';

// class TabBar2demo extends StatefulWidget {
//   const TabBar2demo({Key? key}) : super(key: key);

//   @override
//   State<TabBar2demo> createState() => _TabBar2demoState();
// }

// class _TabBar2demoState extends State<TabBar2demo> {
//   late final TabContainerController _controller;
//   late TextTheme textTheme;

//   @override
//   void initState() {
//     _controller = TabContainerController(length: 3);
//     super.initState();
//   }

//   @override
//   void didChangeDependencies() {
//     textTheme = Theme.of(context).textTheme;
//     super.didChangeDependencies();
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.bluewhite,
//       appBar: AppBar(
//           backgroundColor: Colors.transparent,
//           elevation: 0,
//           centerTitle: true,
//           leading: IconButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               icon: Icon(
//                 Icons.arrow_back_ios,
//                 color: AppColors.blue1,
//               )),
//           title: Text(
//             "TabBar 2",
//             style: AppTextStyles.h3_Bold.copyWith(color: AppColors.blue1),
//           )),
//       body: DefaultTabController(
//         length: 4,
//         child: Container(
//             height: MediaQuery.of(context).size.height,
//             width: MediaQuery.of(context).size.width,
//             child: Column(
//               children: [
//                 Container(
//                   padding: EdgeInsets.symmetric(horizontal: 20),
//                   child: TabBar(
//                     indicator: BoxDecoration(
//                         color: Colors.amber,
//                         borderRadius:
//                             BorderRadius.vertical(top: Radius.circular(20))),
//                     labelColor: Colors.white,
//                     unselectedLabelColor: Colors.black,
//                     tabs: [
//                       Tab(
//                         iconMargin: EdgeInsets.all(0),
//                         icon: Icon(Icons.home),
//                         text: "Home",
//                       ),
//                       Tab(
//                         iconMargin: EdgeInsets.all(0),
//                         icon: Icon(Icons.person),
//                         text: "Home",
//                       ),
//                       Tab(
//                         iconMargin: EdgeInsets.all(0),
//                         icon: Icon(Icons.share),
//                         text: "Home",
//                       ),
//                       Tab(
//                         iconMargin: EdgeInsets.all(0),
//                         icon: Icon(Icons.alarm),
//                         text: "Home",
//                       )
//                     ],
//                   ),
//                 ),
//                 Expanded(
//                     child: TabBarView(children: [
//                   Container(
//                     color: Colors.amber,
//                   ),
//                   Container(
//                     color: Colors.amber,
//                   ),
//                   Container(
//                     color: Colors.amber,
//                   ),
//                   Container(
//                     color: Colors.amber,
//                   )
//                 ]))
//               ],
//             )),
//       ),
//     );
//   }
// }
