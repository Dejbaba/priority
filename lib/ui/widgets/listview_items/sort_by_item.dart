import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:priority_test/core/constants/color_path.dart';
import 'package:priority_test/core/view_models/filter_view_model.dart';

class SortByItem extends StatelessWidget {
  final String sortByOption;
  final FilterViewModel filterVm;
  const SortByItem({super.key, required this.sortByOption, required this.filterVm});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()=>filterVm.selectedSortByOption = sortByOption,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 400),
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 7.h),
        decoration: BoxDecoration(
            color: filterVm.selectedSortByOption == sortByOption ? ColorPath.codGrey:null,
            border: filterVm.selectedSortByOption == sortByOption ? null : Border.all(color: ColorPath.mercuryGrey),
            borderRadius: BorderRadius.all(Radius.circular(100.r))
        ),
        child: Text(
          '$sortByOption',
          style: GoogleFonts.urbanist(
              color: filterVm.selectedSortByOption == sortByOption ? Colors.white:ColorPath.codGrey,
              fontSize: 16.sp,
              fontWeight: FontWeight.w600),
        ),
      ),
    );;
  }
}
