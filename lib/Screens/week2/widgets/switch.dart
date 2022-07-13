import 'package:flutter/material.dart';
import 'package:weapp/constdata/textstyles.dart';

class Switchdemo extends StatefulWidget {
  const Switchdemo({Key? key}) : super(key: key);

  @override
  State<Switchdemo> createState() => _SwitchdemoState();
}

class _SwitchdemoState extends State<Switchdemo> {
  bool value = false;
  bool value2 = false;
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
            "CheckBox",
            style: AppTextStyles.h3_Bold.copyWith(color: AppColors.blue1),
          )),
      body: Container(
        padding: EdgeInsets.only(top: 30),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(children: [
          Switch(
              materialTapTargetSize: MaterialTapTargetSize.padded,
              activeThumbImage: NetworkImage(
                  "https://w7.pngwing.com/pngs/881/489/png-transparent-red-bell-notification-thumbnail.png"),
              value: value,
              onChanged: (v) {
                setState(() {
                  value = v;
                  print(value);
                });
              }),
          SizedBox(
            height: 30,
          ),
          Customswitch(
            value: value2,
            onchange: (v) {
              setState(() {
                value = v;
              });
            },
          )
        ]),
      ),
    );
  }
}

class Customswitch extends StatefulWidget {
  const Customswitch({Key? key, required this.value, required this.onchange})
      : super(key: key);
  final bool value;
  final Function(bool) onchange;
  @override
  State<Customswitch> createState() => _CustomswitchState();
}

class _CustomswitchState extends State<Customswitch>
    with SingleTickerProviderStateMixin {
  late AnimationController _animation;
  late Animation _switch;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _animation =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));
    _switch = Tween<Alignment>(
            begin: widget.value ? Alignment.centerRight : Alignment.centerLeft,
            end: widget.value ? Alignment.centerLeft : Alignment.centerRight)
        .animate(_animation);
    _animation.addListener(() {
      setState(() {
        _switch = _switch;
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _animation.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _animation,
        builder: (context, chilld) {
          return GestureDetector(
              onTap: () {
                if (_animation.isCompleted) {
                  _animation.reverse();
                } else {
                  _animation.forward();
                }
                widget.value ? widget.onchange(false) : widget.onchange(true);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AnimatedOpacity(
                      duration: Duration(milliseconds: 300),
                      opacity: !widget.value ? 1 : 0,
                      curve: Curves.easeInCubic,
                      child: Text(
                        "OFF",
                        style: AppTextStyles.h3_Bold,
                      )),
                  SizedBox(
                    width: 5,
                  ),
                  Container(
                    height: 30,
                    width: 60,
                    decoration: BoxDecoration(
                        color: AppColors.grey,
                        borderRadius: BorderRadius.circular(20)),
                    child: Align(
                      alignment: _switch.value,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          color: widget.value ? Colors.green : Colors.redAccent,
                        ),
                        height: 30,
                        width: 30,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  AnimatedOpacity(
                      duration: Duration(milliseconds: 300),
                      opacity: widget.value ? 1 : 0,
                      curve: Curves.bounceIn,
                      child: Text(
                        "ON",
                        style: AppTextStyles.h3_Bold,
                      )),
                ],
              ));
        });
  }
}
