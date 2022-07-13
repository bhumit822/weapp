import 'package:flutter/material.dart';
import 'package:weapp/constdata/textstyles.dart';

class TabBardemo extends StatefulWidget {
  const TabBardemo({Key? key}) : super(key: key);

  @override
  State<TabBardemo> createState() => _TabBardemoState();
}

class _TabBardemoState extends State<TabBardemo> {
  List<Widget> tabviewitem = [
    Container(
      color: Colors.amber,
    ),
    Container(
      color: Colors.orange,
    ),
    Container(
      color: Colors.blueAccent,
    ),
    Container(
      color: Colors.indigo,
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
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
                "TabBar",
                style: AppTextStyles.h3_Bold.copyWith(color: AppColors.blue1),
              )),
          body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(children: [
              Container(
                height: 50,
                color: AppColors.bluewhite,
                child: TabBar(
                  indicator: Customindicator(color: AppColors.blue1, radius: 4),
                  // indicator: UnderlineTabIndicator(
                  //     borderSide: BorderSide(width: 5.0),
                  //     insets: EdgeInsets.symmetric(horizontal: 16.0)),
                  labelColor: AppColors.blue1,
                  indicatorSize: TabBarIndicatorSize.label,
                  tabs: [
                    Text("Home"),
                    Text("Messages"),
                    Text("Story"),
                    Text("Calls"),
                  ],
                ),
              ),
              Expanded(
                  child: TabBarView(
                children: tabviewitem,
              )),
            ]),
          )),
    );
  }
}

class Customindicator extends Decoration {
  final BoxPainter _painter;

  Customindicator({required Color color, required double radius})
      : _painter = Indicatorpainter(color, radius);

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) => _painter;
}

class Indicatorpainter extends BoxPainter {
  Indicatorpainter(this.color, this.radius)
      : _paint = Paint()
          ..color = color
          ..isAntiAlias = true;
  final Paint _paint;
  final double radius;
  final Color color;

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    final path = Path();
    final paint = Paint()..color = color;
    final value = offset +
        Offset(configuration.size!.width, configuration.size!.height - 10);
    final value2 = offset +
        Offset(configuration.size!.width / 10, configuration.size!.height - 10);

    print(configuration.size!.width);
    canvas.drawRRect(
        RRect.fromRectAndRadius(
            Rect.fromLTRB(value2.dx - configuration.size!.width / 10,
                value.dy + 5, value.dx, value.dy + 0),
            Radius.circular(10)),
        paint);
  }
}
