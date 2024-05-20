import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:priority_test/core/constants/color_path.dart';
import 'package:priority_test/core/view_models/filter_view_model.dart';

class BrandDetailsItem extends StatelessWidget {
  final String brandLogo;
  final String brandName;
  final FilterViewModel filterVm;
  final int index;
  const BrandDetailsItem({super.key, required this.index, required this.brandLogo, required this.brandName, required this.filterVm});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => filterVm.selectedBrandIndex = index,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 11.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              child: Stack(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: 13.w, vertical: 13.h),
                    decoration: BoxDecoration(
                        color: ColorPath.concreteGrey,
                        shape: BoxShape.circle),
                    child: Center(
                      child: SvgPicture.asset(
                        "$brandLogo",
                        width: 24.w,
                        height: 24.h,
                      ),
                    ),
                  ),
                  if (index == filterVm.selectedBrandIndex)
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: AnimatedContainer(
                          duration: Duration(seconds: 1),
                          height: 20.h,
                          width: 20.w,
                          decoration: BoxDecoration(
                              color: ColorPath.codGrey,
                              shape: BoxShape.circle),
                          child: Center(
                            child: SvgPicture.asset(
                              "assets/icons/check_mark.svg",
                              width: 9.04.w,
                              height: 6.4.h,
                              colorFilter: ColorFilter.mode(
                                Colors
                                    .white,
                                BlendMode.srcIn,
                              ),
                            ),
                          )),
                    )
                ],
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Text(
              '$brandName',
              style: GoogleFonts.urbanist(
                  color: ColorPath.codGrey,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w700),
            ),
            SizedBox(
              height: 3.h,
            ),
            Text(
              '1001 Items',
              style: GoogleFonts.urbanist(
                  color: ColorPath.nobelGrey,
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w400),
            ),
          ],
        ),
      ),
    );
  }
}
