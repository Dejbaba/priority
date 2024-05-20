import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:priority_test/core/constants/color_path.dart';

class ErrorState extends StatelessWidget {
  final String message;
  final VoidCallback onPressed;
  const ErrorState({super.key, this.message = 'An Error Occurred', required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SlideInUp(
      duration: Duration(seconds: 1),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            message,
            style: GoogleFonts.urbanist(
                color: ColorPath.codGrey,
                fontSize: 20.sp,
                fontWeight: FontWeight.w700
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 15.h,
          ),
          Container(
            height: 48.h,
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
              child: Text('Retry', style: GoogleFonts.urbanist(
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
