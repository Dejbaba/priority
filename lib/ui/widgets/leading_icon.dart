import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:priority_test/core/utilities/navigator.dart';

class LeadingIcon extends StatelessWidget {
  const LeadingIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:(){
        popNavigation(context: context);
      },
      child: Padding(
        padding: EdgeInsets.only(left: 30.w),
        child: SvgPicture.asset(
          "assets/icons/arrow_left.svg",
          width: 24.w,
          height: 24.h,
        ),
      ),
    );
  }
}
