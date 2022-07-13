import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:weapp/constdata/textstyles.dart';

class ControllerLifeCycleScreen extends StatefulWidget {
  const ControllerLifeCycleScreen({Key? key}) : super(key: key);

  @override
  State<ControllerLifeCycleScreen> createState() =>
      _ControllerLifeCycleScreenState();
}

class _ControllerLifeCycleScreenState extends State<ControllerLifeCycleScreen>
    with WidgetsBindingObserver {
  String intialized = "";
  String didChangeDep = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Fluttertoast.showToast(
      msg: "Widget intialized",
    );
    WidgetsBinding.instance.addObserver(this);
    intialized = "Widget Initialized";
    print("initState=====================${DateTime.now()}");
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    Fluttertoast.showToast(msg: "didChangeDependencies");
    super.didChangeDependencies();

    print("didChangeDependencies=====================${DateTime.now()}");
  }

  @override
  void didUpdateWidget(covariant ControllerLifeCycleScreen oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    print(oldWidget.runtimeType);
    Fluttertoast.showToast(msg: "didUpdateWidget");
    print("didUpdateWidget===================${DateTime.now()}");
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // TODO: implement didChangeAppLifecycleState
    super.didChangeAppLifecycleState(state);

    switch (state) {
      case AppLifecycleState.resumed:
        print("App Resumed");
        Fluttertoast.cancel();
        Fluttertoast.showToast(msg: "App Resumed");
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("App Resumed")));

        break;
      case AppLifecycleState.inactive:
        Fluttertoast.showToast(msg: "App inactive");
        print("App is inactive");
        break;
      case AppLifecycleState.paused:
        Fluttertoast.showToast(msg: "App paused");
        print("App paused");
        break;
      case AppLifecycleState.detached:
        Fluttertoast.showToast(msg: "App detached");
        print("App detached");
        break;
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    Fluttertoast.showToast(msg: "Disposed...");
    WidgetsBinding.instance.removeObserver(this);
    print("Widget Disposed");
  }

  int count = 0;
  @override
  Widget build(BuildContext context) {
    print("BuildMethod==================${DateTime.now()}");
    Fluttertoast.showToast(msg: "Build mathod call");
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.blue3,
        title: Text(
          "View controller life cycle/activity",
          style: AppTextStyles.h3_regular,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {});
        },
        backgroundColor: AppColors.teal,
        child: Icon(Icons.add),
      ),
      body: Center(
        child: Container(),
      ),
    );
  }
}
