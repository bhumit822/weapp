import 'package:flutter/material.dart';
import 'package:weapp/constdata/textstyles.dart';

class Containerdemo extends StatefulWidget {
  const Containerdemo({Key? key}) : super(key: key);

  @override
  State<Containerdemo> createState() => _ContainerdemoState();
}

class _ContainerdemoState extends State<Containerdemo> {
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
            "Container",
            style: AppTextStyles.h3_Bold.copyWith(color: AppColors.blue1),
          )),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 100,
                width: 100,
                alignment: Alignment.center,
                color: Colors.amber,
                child: Text("Container"),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.circular(10)),
                alignment: Alignment.center,
                child: Text("border radius"),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                    border: Border.all(width: 4),
                    color: Colors.amber,
                    borderRadius: BorderRadius.circular(10)),
                alignment: Alignment.center,
                child: Text("border"),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [AppColors.blue1, AppColors.skyblue],
                        begin: Alignment.topLeft),
                    borderRadius: BorderRadius.circular(10)),
                alignment: Alignment.center,
                child: Text("gradient"),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                            "https://media.4-paws.org/f/b/5/e/fb5e0f17dc321f71df9a03e2882d97c9ae35bfa8/VIER%20PFOTEN_2019-11-15_121-1930x1335-1920x1328.jpg")),
                    gradient: LinearGradient(
                        colors: [AppColors.blue1, AppColors.skyblue],
                        begin: Alignment.topLeft),
                    borderRadius: BorderRadius.circular(10)),
                alignment: Alignment.center,
                child: Text("gradient"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
