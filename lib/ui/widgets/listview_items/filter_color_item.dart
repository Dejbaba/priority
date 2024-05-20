import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:priority_test/core/constants/color_path.dart';
import 'package:priority_test/core/view_models/filter_view_model.dart';

class FilterColorItem extends StatelessWidget {
  final String color;
  final FilterViewModel filterVm;
  final int index;
  const FilterColorItem({super.key, required this.color, required this.index, required this.filterVm});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()=>filterVm.selectedFilterColor = color,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 400),
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 7.h),
        decoration: BoxDecoration(
            color: Colors.transparent,
            border: Border.all(color: filterVm.selectedFilterColor == color ? ColorPath.codGrey:ColorPath.mercuryGrey),
            borderRadius: BorderRadius.all(Radius.circular(100.r))
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 20.h,
              width: 20.w,
              decoration: BoxDecoration(
                  color: index == 1 ? Colors.transparent:filterVm.setFilterColorBg(index: index),
                  border: index == 1 ? Border.all(color: ColorPath.mercuryGrey):null,
                  shape: BoxShape.circle
              ),
            ),
            SizedBox(width: 10.w,),
            Text(
              '$color',
              style: GoogleFonts.urbanist(
                  color: ColorPath.codGrey,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600),
            )
          ],
        ),
      ),
    );
  }
}
