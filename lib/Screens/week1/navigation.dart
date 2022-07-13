import 'package:flutter/material.dart';
import 'package:weapp/constdata/textstyles.dart';
import 'package:weapp/widgets/commonbutton.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({Key? key}) : super(key: key);

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blue3,
      appBar: AppBar(
        backgroundColor: AppColors.blue3,
        elevation: 0,
      ),
      body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30), topRight: Radius.circular(30))),
          child: SingleChildScrollView(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(
                "Push",
                style: AppTextStyles.h1_regular,
              ),
              CommonButton(
                  ontap: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (contex) => Page1()));
                  },
                  title: "Press",
                  color: AppColors.blue2),
              SizedBox(
                height: 20,
              ),
              Text(
                "Push And Remove Until",
                style: AppTextStyles.h1_regular,
              ),
              CommonButton(
                  ontap: () {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => Page2()),
                        ModalRoute.withName('/'));
                  },
                  title: "Press",
                  color: AppColors.skyblue),
              SizedBox(
                height: 20,
              ),
              Text(
                "Push And Replace",
                style: AppTextStyles.h1_regular,
              ),
              CommonButton(
                  ontap: () {
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (conatex) => page3()));
                  },
                  title: "Press",
                  color: AppColors.skyblue),
              SizedBox(
                height: 20,
              ),
              Text(
                "Pop",
                style: AppTextStyles.h1_regular,
              ),
              CommonButton(
                  ontap: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (contex) => Page4()));
                  },
                  title: "Press",
                  color: AppColors.teal),
              SizedBox(
                height: 20,
              ),
              Text(
                "PopUntil",
                style: AppTextStyles.h1_regular,
              ),
              CommonButton(
                  ontap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (conatex) => Page5(),
                        ));
                  },
                  title: "Press",
                  color: AppColors.teal),
            ]),
          )),
    );
  }
}

class Page1 extends StatefulWidget {
  const Page1({Key? key}) : super(key: key);

  @override
  State<Page1> createState() => _Page1State();
}

class _Page1State extends State<Page1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Push"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Card(
            elevation: 5,
            child: Container(
              height: 100,
              width: 300,
              padding: EdgeInsets.all(15),
              alignment: Alignment.center,
              child: Text(
                "push navigate to next page and back to prev.route.",
                style: AppTextStyles.p1,
                textAlign: TextAlign.center,
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Center(
              child: CommonButton(
                  color: AppColors.blue2,
                  ontap: () {
                    Navigator.of(context).pop();
                  },
                  title: "Go Back")),
        ],
      ),
    );
  }
}

class Page2 extends StatefulWidget {
  const Page2({Key? key}) : super(key: key);

  @override
  State<Page2> createState() => _Page2State();
}

class _Page2State extends State<Page2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Push And Remove Until"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Card(
            elevation: 5,
            child: Container(
              height: 100,
              width: 300,
              padding: EdgeInsets.all(15),
              alignment: Alignment.center,
              child: Text(
                "push And Remove Until Remove every route in between newRoute and root route .",
                style: AppTextStyles.p1,
                textAlign: TextAlign.center,
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Center(
              child: CommonButton(
                  color: AppColors.blue2,
                  ontap: () {
                    Navigator.of(context).pop();
                  },
                  title: "Go Back")),
        ],
      ),
    );
  }
}

class page3 extends StatefulWidget {
  const page3({Key? key}) : super(key: key);

  @override
  State<page3> createState() => _page3State();
}

class _page3State extends State<page3> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Push And Replace"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Card(
            elevation: 5,
            child: Container(
              height: 100,
              width: 300,
              padding: EdgeInsets.all(15),
              alignment: Alignment.center,
              child: Text(
                "Push and Repace Remove Previous screen  and replace newroute on palce of pre.Route when navigate back user navigate to second prev.screen",
                style: AppTextStyles.p1,
                textAlign: TextAlign.center,
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Center(
              child: CommonButton(
                  color: AppColors.blue2,
                  ontap: () {
                    Navigator.of(context).pop();
                  },
                  title: "Go Back")),
        ],
      ),
    );
  }
}

class Page4 extends StatefulWidget {
  const Page4({Key? key}) : super(key: key);

  @override
  State<Page4> createState() => _Page4State();
}

class _Page4State extends State<Page4> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pop"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Card(
            elevation: 5,
            child: Container(
              height: 100,
              width: 300,
              padding: EdgeInsets.all(15),
              alignment: Alignment.center,
              child: Text(
                "Pop used for go back to previous screen.",
                style: AppTextStyles.p1,
                textAlign: TextAlign.center,
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Center(
              child: CommonButton(
                  color: AppColors.blue2,
                  ontap: () {
                    Navigator.of(context).pop();
                  },
                  title: "Go Back")),
        ],
      ),
    );
  }
}

class Page5 extends StatefulWidget {
  const Page5({Key? key}) : super(key: key);

  @override
  State<Page5> createState() => _Page5State();
}

class _Page5State extends State<Page5> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pop Until"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
              child: CommonButton(
                  color: AppColors.blue2,
                  ontap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => NewPage()));
                  },
                  title: "Next Page")),
        ],
      ),
    );
  }
}

class NewPage extends StatelessWidget {
  const NewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pop Until"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Card(
            elevation: 5,
            child: Container(
              height: 100,
              width: 300,
              padding: EdgeInsets.all(15),
              alignment: Alignment.center,
              child: Text(
                "Pop until Remove Every route between  current page and specific route Route.",
                style: AppTextStyles.p1,
                textAlign: TextAlign.center,
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Center(
              child: CommonButton(
                  color: AppColors.blue2,
                  ontap: () {
                    int a = 0;
                    Navigator.popUntil(context, (route) {
                      return a++ == 2;
                    });
                    // Navigator.popUntil(
                    //     context,
                    //     (Route<dynamic> route) =>
                    //         route.settings.name == "navigation");
                  },
                  title: "Back")),
        ],
      ),
    );
  }
}
