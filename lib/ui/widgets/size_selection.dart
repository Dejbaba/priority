import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:priority_test/core/constants/color_path.dart';
import 'package:priority_test/core/view_models/product_details_view_model.dart';

class SizeSelection extends StatelessWidget {
  final int index;
  final ProductDetailsViewModel productDetailsVm;
  const SizeSelection({super.key, required this.index, required this.productDetailsVm});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        productDetailsVm.setSelectedSize(index: index);
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 400),
          margin: EdgeInsets.only(right: index == 4 ? 0:15.w),
          height: 40.h,
          width: 40.w,
          decoration: BoxDecoration(
              border: index == productDetailsVm.selectedSizeIndex ? null : Border.all(color: ColorPath.mercuryGrey),
              color: index == productDetailsVm.selectedSizeIndex ? ColorPath.codGrey:Colors.transparent,
              shape: BoxShape.circle
          ),
          child: Center(
            child:  Text(
              '${productDetailsVm.sampleSneakerSizes[index]}',
              style: GoogleFonts.urbanist(
                  color: index == productDetailsVm.selectedSizeIndex ? Colors.white : ColorPath.doveGrey,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w700
              ),
            ),
          )),
    );
  }
}
