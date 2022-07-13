import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:weapp/constdata/textstyles.dart';

class Sliderdemo extends StatefulWidget {
  const Sliderdemo({Key? key}) : super(key: key);

  @override
  State<Sliderdemo> createState() => _SliderdemoState();
}

class _SliderdemoState extends State<Sliderdemo> {
  double value = 0;
  double value2 = 0;
  RangeValues a = RangeValues(10, 20);
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
            "Slider",
            style: AppTextStyles.h3_Bold.copyWith(color: AppColors.blue1),
          )),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Text(
              value.toStringAsFixed(2),
              style: AppTextStyles.h2_Bold,
            ),
            Slider(
                value: value,
                onChanged: (v) {
                  setState(() {
                    value = v;
                  });
                }),
            SizedBox(
              height: 30,
            ),
            Slider(
                label: value.toString(),
                activeColor: AppColors.blue1,
                thumbColor: AppColors.blue3,
                value: value,
                onChanged: (v) {
                  setState(() {
                    value = v;
                  });
                }),
            SizedBox(
              height: 30,
            ),
            CupertinoSlider(
                value: value,
                onChanged: (v) {
                  setState(() {
                    value = v;
                  });
                }),
            SizedBox(
              height: 30,
            ),
            Text(
                "${a.start.toStringAsFixed(2)}====${a.end.toStringAsFixed(2)}"),
            RangeSlider(
                values: a,
                min: 0,
                max: 100,
                activeColor: AppColors.blue1,
                labels: RangeLabels(a.start.toString(), a.end.toString()),
                onChanged: (v) {
                  setState(() {
                    a = v;
                  });
                }),
            SizedBox(
              height: 30,
            ),
            SfSlider(
              min: 0.0,
              max: 1.0,
              value: value2,
              interval: 0.10,
              showTicks: true,
              showLabels: true,
              enableTooltip: true,
              minorTicksPerInterval: 1,
              onChanged: (dynamic value) {
                setState(() {
                  value2 = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
