import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:priority_test/core/constants/color_path.dart';

confirmationDialog({required BuildContext context, String message = 'Are you sure you want to delete this item from your cart?'}){
  return AlertDialog(
    backgroundColor: Colors.white,
    title: Text('Confirm Delete'),
    content: Text('$message'),
    actions: <Widget>[
      ElevatedButton(
        onPressed: (){
          Navigator.of(context).pop(false);
        },
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 24.w),
          elevation: 0,
          backgroundColor: ColorPath.codGrey,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100.r),
          ),
        ),
        child: Text('NO', style: GoogleFonts.urbanist(
            color: Colors.white,
            fontSize: 14.sp,
            fontWeight: FontWeight.w700
        ),), // Button's label
      ),
      SizedBox(width: 5.w,),
      ElevatedButton(
        onPressed: (){
          Navigator.of(context).pop(true);
        },
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 24.w),
          elevation: 0,
          backgroundColor: ColorPath.radicalRed,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100.r),
          ),
        ),
        child: Text('YES', style: GoogleFonts.urbanist(
            color: Colors.white,
            fontSize: 14.sp,
            fontWeight: FontWeight.w700
        ),), // Button's label
      )
    ],
  );
}