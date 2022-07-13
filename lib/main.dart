import 'package:camera/camera.dart';
import 'package:facebook_audience_network/facebook_audience_network.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:location/location.dart';
import 'package:weapp/Screens/week2/week2.dart';
import 'package:weapp/Screens/week3/week3.dart';
import 'package:weapp/Screens/week4/week4.dart';
import 'package:weapp/Screens/week5/week5.dart';
import 'package:weapp/Screens/week6/week6.dart';
import 'package:weapp/Screens/week7/week7.dart';
import 'package:weapp/constdata/textstyles.dart';
import 'package:weapp/Screens/week1/week1.dart';
import 'package:weapp/widgets/weekbutton.dart';

late Box box;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await oninit();
  runApp(MyApp());
}

LocationData? initLocation;
List<CameraDescription>? cameras;
Future oninit() async {
  cameras = await availableCameras();

  FacebookAudienceNetwork.init(
      testingId: "f7d54062-4ff9-4806-89c1-38826fe31ea6");

  MobileAds.instance.initialize().then((value) => MobileAds.instance
      .updateRequestConfiguration(RequestConfiguration(
          testDeviceIds: ['BCD776986614FC0955EC0839DA049246'])));
  await Hive.initFlutter();

  box = await Hive.openBox('data');
  await Firebase.initializeApp();
  Location _loc = await Location()
    ..changeSettings(interval: 100);
  final _hasPermission = await Location.instance.hasPermission();
  if (_hasPermission == PermissionStatus.granted) {
    initLocation = await _loc.getLocation();
  } else {
    await Location.instance.requestPermission();
    initLocation = await _loc.getLocation();
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
          backgroundColor: AppColors.bluewhite,
          fontFamily: "jkr",
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent),
      home: MyHome(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHome extends StatefulWidget {
  const MyHome({Key? key}) : super(key: key);

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        drawer: Drawer(
            child: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                    color: AppColors.blue2,
                    image: DecorationImage(
                        image: NetworkImage(
                            "https://images.pexels.com/photos/1072179/pexels-photo-1072179.jpeg?cs=srgb&dl=pexels-c%C3%A1tia-matos-1072179.jpg&fm=jpg"),
                        fit: BoxFit.cover)),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ListTile(
                        textColor: Colors.white,
                        trailing: Icon(
                          Icons.expand_more,
                          color: AppColors.white,
                        ),
                        title: Text("Bhumit Antala"),
                        subtitle: Text("Bantala822@mail.com"),
                      )
                    ],
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.mail),
                title: Text("Mails"),
              ),
              ListTile(
                leading: Icon(Icons.drafts),
                title: Text("Draft"),
              ),
              ListTile(
                leading: Icon(Icons.settings),
                title: Text("Setting"),
              ),
              ListTile(
                leading: Icon(Icons.logout),
                title: Text("SignOut"),
              ),
            ],
          ),
        )),
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              _scaffoldKey.currentState!.openDrawer();
            },
          ),
          title: Text(
            "Training",
            style: AppTextStyles.h2_Bold,
          ),
          backgroundColor: AppColors.blue1,
        ),
        body: Container(
          padding: EdgeInsets.all(20),
          child: ListView(
            children: [
              WeekButton(
                ontap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => Week1(),
                      settings: RouteSettings(
                        name: 'Week1',
                      ),
                    ),
                  );
                },
                title: "Week 1",
              ),
              SizedBox(
                height: 10,
              ),
              WeekButton(
                ontap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => Week2(),
                      settings: RouteSettings(
                        name: 'Week2',
                      ),
                    ),
                  );
                },
                title: "Week 2",
              ),
              SizedBox(
                height: 10,
              ),
              WeekButton(
                ontap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => Week3(),
                    ),
                  );
                },
                title: "Week 3",
              ),
              SizedBox(
                height: 10,
              ),
              WeekButton(
                ontap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => Week4(),
                    ),
                  );
                },
                title: "Week 4",
              ),
              SizedBox(
                height: 10,
              ),
              WeekButton(
                ontap: () {
                  Get.to(() => Week5());
                  // Get.to(() => VideoPlayerDemo());

                  // Navigator.of(context).push(
                  //   MaterialPageRoute(
                  //     builder: (context) =>
                  //         FirebaseAuth.instance.currentUser == null
                  //             ? GoogleAndFacebookSignin()
                  //             : SigninHome(),
                  //   ),
                  // );
                },
                title: "Week 5",
              ),
              SizedBox(
                height: 10,
              ),
              WeekButton(
                ontap: () {
                  // Get.to(() => FacebookAdsDemo());
                  Get.to(() => Week6Demo());
                  // Get.to(() => GoogleAdsDemo());
                  // Get.to(() => ShareMediaDemo());

                  // Navigator.of(context).push(
                  //   MaterialPageRoute(
                  //     builder: (context) =>
                  //         FirebaseAuth.instance.currentUser == null
                  //             ? GoogleAndFacebookSignin()
                  //             : SigninHome(),
                  //   ),
                  // );
                },
                title: "Week 6",
              ),
              SizedBox(
                height: 10,
              ),
              WeekButton(
                ontap: () {
                  Get.to(() => Week7());
                },
                title: "Week 7",
              ),
            ],
          ),
        ));
  }
}
