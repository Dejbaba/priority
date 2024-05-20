import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:priority_test/core/constants/color_path.dart';


class CustomDot extends StatelessWidget{

  final bool isActive;
  final bool fromProductScreen;
  final Color activeColor;
  final Color inactiveColor;
  final double innerSize;
  final Color borderColor;

  const CustomDot({ this.fromProductScreen = false, this.borderColor = Colors.white, this.isActive = true, this.innerSize = 4, this.activeColor = ColorPath.codGrey, this.inactiveColor = ColorPath.nobelGrey});

  @override
  Widget build(BuildContext context) {

    return AnimatedContainer(
      margin: EdgeInsets.only(right: 10.w),
      duration: Duration(microseconds: 1),
      height: 7.h,
      width: 7.w,   //45
      decoration: BoxDecoration(
        color: isActive ? activeColor : inactiveColor,
        shape: BoxShape.circle,
      ),
    );
  }


}