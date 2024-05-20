import 'package:flutter/material.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:priority_test/core/constants/color_path.dart';


showFloatingFlushBar({required BuildContext context, Color bgColor = ColorPath.radicalRed, required String message, Color messageColor = Colors.white, FlushbarPosition position = FlushbarPosition.TOP, int duration = 2, bool isPersistent = false}) {

  Flushbar(
    padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
    backgroundColor: bgColor,
    dismissDirection: FlushbarDismissDirection.HORIZONTAL,
    forwardAnimationCurve: Curves.fastLinearToSlowEaseIn,
    flushbarPosition: position,
    messageText: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(child: Text(message, style: GoogleFonts.urbanist(
        color: messageColor,
        fontSize: 14.sp,
        fontWeight: FontWeight.w600
    ))),
      ],
    ),
    duration: isPersistent ? null : Duration(seconds: duration),
  )..show(context);
}