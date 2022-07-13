import 'package:flutter/material.dart';
import 'package:weapp/constdata/textstyles.dart';

class ContentButton extends StatefulWidget {
  const ContentButton({Key? key, required this.ontap, required this.title})
      : super(key: key);
  final VoidCallback ontap;
  final String title;
  @override
  State<ContentButton> createState() => _ContentButtonState();
}

class _ContentButtonState extends State<ContentButton> {
  @override
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
          height: 150,
          width: 150,
          padding: EdgeInsets.all(10),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: AppColors.blue1,
              boxShadow: [
                !isTaped
                    ? BoxShadow(
                        color: AppColors.blue3.withOpacity(0.4),
                        offset: Offset(-2, 5),
                        spreadRadius: 0,
                        blurRadius: 5)
                    : BoxShadow()
              ],
              borderRadius: BorderRadius.circular(16)),
          child: Text(
            widget.title,
            textAlign: TextAlign.center,
            style: AppTextStyles.h3_Bold.copyWith(color: AppColors.white),
          )),
    );
  }
}
