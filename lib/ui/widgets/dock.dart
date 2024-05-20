import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:priority_test/core/constants/color_path.dart';
import 'package:priority_test/core/utilities/utilities.dart';

class Dock extends StatelessWidget {
  final double? amount;
  final String buttonText;
  final VoidCallback? onPressed;
  final bool useBoxShadow;
  final double buttonHorizontalPadding;
  final String label;
  const Dock({super.key, this.label = 'Price', this.buttonHorizontalPadding = 24, this.useBoxShadow = true, this.amount = 235, required this.buttonText, required this.onPressed});

  @override
  Widget build(BuildContext context) {

    if(useBoxShadow){
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 16.h),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: ColorPath.altoGrey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 2,
              offset: Offset(0, 0.75), // changes position of shadow
            ),
          ],

        ),
        child: SafeArea(
          child: Container(
            height: 50.h,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '$label',
                      style: GoogleFonts.urbanist(
                          color: ColorPath.nobelGrey,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400
                      ),
                    ),
                    Text(
                      '\$${Utilities.formatAmount(amount: amount)}',
                      style: GoogleFonts.urbanist(
                          color: ColorPath.codGrey,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w700
                      ),
                    ),
                  ],
                ),
                Container(
                  child: ElevatedButton(
                    onPressed: onPressed,
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 16.5.h, horizontal: buttonHorizontalPadding.w),
                      elevation: 0,
                      backgroundColor: ColorPath.codGrey,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100.r),
                      ),
                    ),
                    child: Text('$buttonText', style: GoogleFonts.urbanist(
                        color: Colors.white,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700
                    ),), // Button's label
                  ),
                )

              ],
            ),
          ),
        ),
      );
    }

    return Container(
      height: 50.h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '$label',
                  style: GoogleFonts.urbanist(
                      color: ColorPath.nobelGrey,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400
                  ),
                ),
                FittedBox(
                  child: Text(
                    '\$${Utilities.formatAmount(amount: amount)}',
                    style: GoogleFonts.urbanist(
                        color: ColorPath.codGrey,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w700
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 20.w,),
          Container(
            height: 50.h,
            child: ElevatedButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 13.h, horizontal: 24.w),
                elevation: 0,
                backgroundColor: ColorPath.codGrey,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100.r),
                ),
              ),
              child: Text('$buttonText', style: GoogleFonts.urbanist(
                  color: Colors.white,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w700
              ),), // Button's label
            ),
          )

        ],
      ),
    );
  }
}
