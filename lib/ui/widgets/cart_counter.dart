import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:priority_test/core/constants/color_path.dart';



// ignore: must_be_immutable
class CartCounter extends StatelessWidget {
  int? lowerLimit, upperLimit, stepValue, value;
  final ValueChanged<dynamic> onChanged;

  CartCounter({
    Key? key,
    required this.value,
    required this.onChanged,
    required this.lowerLimit,
    required this.upperLimit,
    required this.stepValue
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        InkResponse(
          onTap: value == 1 ? null : () {
            onChanged(value! - stepValue!);
          },
          child: SvgPicture.asset(
            "assets/icons/minus.svg",
            width: 24.w,
            height: 24.h,
            color: value == 1 ? ColorPath.nobelGrey:ColorPath.codGrey,
          ),
        ),
        SizedBox(width: 10.w,),
        Text(
          '$value',
          style: GoogleFonts.urbanist(
              color: ColorPath.codGrey,
              fontSize: 14.sp,
              fontWeight: FontWeight.w700
          ),
        ),
        SizedBox(width: 10.w,),
        InkResponse(
          onTap: value == upperLimit ? null : () {
            onChanged(value! + stepValue!);
          },
          child: SvgPicture.asset(
            "assets/icons/add.svg",
            width: 24.w,
            height: 24.h,
            color: value == upperLimit ? ColorPath.nobelGrey:ColorPath.codGrey,
          ),
        ),
      ],
    );
  }

}

