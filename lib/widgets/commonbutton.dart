import 'package:flutter/material.dart';
import 'package:weapp/constdata/textstyles.dart';

class CommonButton extends StatefulWidget {
  const CommonButton({
    Key? key,
    required this.ontap,
    required this.title,
    required this.color,
  }) : super(key: key);
  final VoidCallback ontap;
  final String title;
  final Color color;

  @override
  State<CommonButton> createState() => _CommonButtonState();
}

class _CommonButtonState extends State<CommonButton> {
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
          height: 30,
          width: 80,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: widget.color,
              boxShadow: [
                !isTaped
                    ? BoxShadow(
                        color: widget.color.withOpacity(0.4),
                        offset: Offset(0, 2),
                        blurRadius: 5)
                    : BoxShadow()
              ],
              borderRadius: BorderRadius.circular(13)),
          child: Text(
            widget.title,
            style: AppTextStyles.p1.copyWith(color: AppColors.white),
          )),
    );
  }
}
