import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:priority_test/core/constants/color_path.dart';

class EmptyState extends StatelessWidget {
  final String message;
  const EmptyState({super.key, this.message = 'Not Found'});

  @override
  Widget build(BuildContext context) {
    return SlideInUp(
      duration: Duration(seconds: 1),
      child: Text('$message', style: GoogleFonts.urbanist(
          color: ColorPath.codGrey,
          fontSize: 18.sp,
          fontWeight: FontWeight.w700
      ),),
    );
  }
}
