import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:priority_test/core/constants/color_path.dart';
import 'package:priority_test/ui/widgets/leading_icon.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final List<Widget>? actionIcons;
  const CustomAppBar({super.key, this.title, this.actionIcons});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      scrolledUnderElevation: 0,
      leading: LeadingIcon(),
      centerTitle: true,
      title: title != null ? Text(
        '$title',
        style: GoogleFonts.urbanist(
            color: ColorPath.codGrey,
            fontSize: 16.sp,
            fontWeight: FontWeight.w600
        ),
      ):null,
      actions: actionIcons != null ? actionIcons : null,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
