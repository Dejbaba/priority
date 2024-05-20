import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:priority_test/core/constants/color_path.dart';
import 'package:priority_test/core/view_models/product_details_view_model.dart';

class ColorSelection extends StatelessWidget {
  final int index;
  final ProductDetailsViewModel productDetailsVm;
  const ColorSelection({super.key, required this.index, required this.productDetailsVm});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        productDetailsVm.setSelectedColor(index: index);
      },
      child: Container(
        margin: EdgeInsets.only(right: index == 4 ? 0:10.w),
        height: 20.h,
        width: 20.w,
        decoration: BoxDecoration(
            border: index == 1 ? Border.all(color: ColorPath.mercuryGrey):null,
            color: productDetailsVm.setColorBg(index: index),
            shape: BoxShape.circle
        ),
        child: index == productDetailsVm.selectedColorIndex ? Center(
      child: SvgPicture.asset(
      "assets/icons/check_mark.svg",
      width: 9.04.w,
      height: 6.4.h,
        colorFilter: ColorFilter.mode(
          index == 1?ColorPath.codGrey:Colors.white,  // Replace with your desired color
          BlendMode.srcIn,
        ),
      ),
      ):Container()),
    );
  }
}
