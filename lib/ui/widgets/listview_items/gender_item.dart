import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:priority_test/core/constants/color_path.dart';
import 'package:priority_test/core/view_models/filter_view_model.dart';

class GenderItem extends StatelessWidget {
  final String genderOption;
  final FilterViewModel filterVm;
  const GenderItem({super.key, required this.genderOption, required this.filterVm});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()=>filterVm.selectedGender = genderOption,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 400),
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 7.h),
        decoration: BoxDecoration(
            color: filterVm.selectedGender == genderOption ? ColorPath.codGrey:null,
            border: filterVm.selectedGender == genderOption ? null : Border.all(color: ColorPath.mercuryGrey),
            borderRadius: BorderRadius.all(Radius.circular(100.r))
        ),
        child: Text(
          '$genderOption',
          style: GoogleFonts.urbanist(
              color: filterVm.selectedGender == genderOption ? Colors.white:ColorPath.codGrey,
              fontSize: 16.sp,
              fontWeight: FontWeight.w600),
        ),
      ),
    );;
  }
}
