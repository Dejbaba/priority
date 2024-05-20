import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:priority_test/core/constants/color_path.dart';



class StarRating extends StatelessWidget {
  final int value;
  final void Function(int index)? onChanged;
  final double padding;


  StarRating({this.value = 0, this.onChanged, this.padding = 7});


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Select Rating',
          style: GoogleFonts.urbanist(
              color: ColorPath.codGrey,
              fontSize: 16.sp,
              fontWeight: FontWeight.w700
          ),
        ),
        SizedBox(height: 20.h,),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(5, (index) {
            return GestureDetector(
              onTap: onChanged != null
                  ? () {
                onChanged!(value == index + 1 ? index : index + 1);
              }
                  : null,
              child: Padding(
                padding:  EdgeInsets.only(right: index == 4 ? 0 : padding.w),
                child: SvgPicture.asset(
                  index < value ? "assets/icons/star.svg":"assets/icons/star_empty.svg",
                  width: 24.w,
                  height: 24.h,
                ),
              ),
            );
          }),
        )
      ],
    );
  }
}