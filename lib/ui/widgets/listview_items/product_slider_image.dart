import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:priority_test/core/constants/color_path.dart';

class ProductSliderImage extends StatelessWidget {
  final String sneakerPic;
  const ProductSliderImage({super.key, required this.sneakerPic});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
          color: ColorPath.mercuryGrey,
          borderRadius: BorderRadius.all(Radius.circular(20.r))
      ),
      child:Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 67.2.h),
            child: Image.asset(
              "$sneakerPic",
              width: 252.w,
              height: 178.5.h,
            ),
          )
        ],
      ),
    );
  }
}
