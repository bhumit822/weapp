import 'package:flutter/material.dart';

class Bottomnavigation1 extends StatefulWidget {
  const Bottomnavigation1({Key? key}) : super(key: key);

  @override
  State<Bottomnavigation1> createState() => _Bottomnavigation1State();
}

class _Bottomnavigation1State extends State<Bottomnavigation1> {
  int bottomindex = 0;
  List items = [
    Container(
      color: Colors.red,
    ),
    Container(
      color: Colors.amber,
    ),
    Container(
      color: Colors.orange,
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: items[bottomindex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: bottomindex,
        onTap: (v) {
          setState(() {
            bottomindex = v;
          });
        },
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Setting"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }
}
