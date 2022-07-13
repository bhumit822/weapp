import 'package:flutter/material.dart';
import 'package:weapp/constdata/textstyles.dart';

class GestureMoveObject extends StatefulWidget {
  const GestureMoveObject({Key? key}) : super(key: key);

  @override
  State<GestureMoveObject> createState() => _GestureMoveObjectState();
}

class _GestureMoveObjectState extends State<GestureMoveObject> {
  Offset a = Offset(50, 50);

  double _scal = 1.0;
  double _rotation = 1.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: GestureDetector(
          onScaleUpdate: (details) {
            print(details.rotation);
            setState(() {
              _scal = details.scale;
              _rotation = details.rotation;
              a = details.localFocalPoint;
            });
          },
          onLongPressMoveUpdate: (v) {
            print(v.localPosition);
            Offset vv = v.localPosition;

            final _width = MediaQuery.of(context).size.width - (50 + 20);

            if (vv.dx > 50 && vv.dy > 50 && vv.dx < _width) {
              setState(() {
                a = v.localPosition;
                print(a);
              });
            }
          },
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(width: 4, color: AppColors.blue3)),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  top: a.dy - 50,
                  left: a.dx - 50,
                  child: GestureDetector(
                    child: Transform.scale(
                      scale: _scal,
                      child: Container(
                        transform: Matrix4.rotationZ(_rotation),
                        height: 100,
                        decoration: BoxDecoration(
                            color: AppColors.blue1,
                            borderRadius: BorderRadius.circular(15)),
                        alignment: Alignment.center,
                        transformAlignment: Alignment.center,
                        width: 100,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
