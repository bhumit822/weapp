import 'package:flutter/material.dart';
import 'package:weapp/constdata/textstyles.dart';

class WeekButton extends StatefulWidget {
  const WeekButton({
    Key? key,
    required this.ontap,
    required this.title,
  }) : super(key: key);
  final VoidCallback ontap;
  final String title;

  @override
  State<WeekButton> createState() => _WeekButtonState();
}

class _WeekButtonState extends State<WeekButton> {
  bool isTaped = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.ontap,
      onHighlightChanged: (status) {
        setState(() {
          isTaped = status;
        });
      },
      child: Container(
          height: 50,
          width: 200,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: AppColors.blue1,
              boxShadow: [
                !isTaped
                    ? BoxShadow(
                        color: AppColors.blue3.withOpacity(0.4),
                        offset: Offset(0, 3),
                        blurRadius: 10)
                    : BoxShadow()
              ],
              borderRadius: BorderRadius.circular(13)),
          child: Text(
            widget.title,
            style: AppTextStyles.h2_Bold.copyWith(color: AppColors.white),
          )),
    );
  }
}
